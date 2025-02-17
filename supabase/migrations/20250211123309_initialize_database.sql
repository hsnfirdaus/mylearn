-- Enable UUID extension for unique IDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- DOMAIN: Semester Check
CREATE DOMAIN public.semester_type AS INT CHECK (VALUE BETWEEN 1 AND 8);

-- ENUM: Task Status
CREATE TYPE public.task_status AS ENUM ('pending', 'not_submitted', 'submitted');

-- ENUM: Class Group
CREATE TYPE public.class_session_type AS ENUM ('Pagi', 'Malam');

-- ENUM: User Role
CREATE TYPE public.app_role AS ENUM ('student', 'admin');

-- User Role Table
CREATE TABLE public.user_roles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    role public.app_role NOT NULL,
    UNIQUE (user_id, role)
);

-- JWT Hooks
CREATE OR REPLACE FUNCTION public.custom_access_token_hook(event jsonb)
RETURNS jsonb
LANGUAGE plpgsql
STABLE
AS $$
  DECLARE
    claims jsonb;
    user_roles jsonb;
  BEGIN
    -- Fetch all roles as an array
    SELECT jsonb_agg(role) INTO user_roles 
    FROM public.user_roles 
    WHERE user_id = (event->>'user_id')::uuid;

    claims := event->'claims';

    -- Set the claim to an array of roles or null if none exist
    IF user_roles IS NOT NULL THEN
      claims := jsonb_set(claims, '{user_roles}', user_roles);
    ELSE
      claims := jsonb_set(claims, '{user_roles}', 'null');
    END IF;

    -- Update the 'claims' object in the original event
    event := jsonb_set(event, '{claims}', claims);
    RETURN event;
  END;
$$;

GRANT usage ON SCHEMA public TO supabase_auth_admin;

GRANT EXECUTE
  ON FUNCTION public.custom_access_token_hook
  TO supabase_auth_admin;

REVOKE EXECUTE
  ON FUNCTION public.custom_access_token_hook
  FROM authenticated, anon, public;

GRANT all
  ON TABLE public.user_roles
TO supabase_auth_admin;

REVOKE all
  ON TABLE public.user_roles
  FROM authenticated, anon, public;


-- RLS User Role Table
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow auth admin to read user roles"
    ON public.user_roles
    AS permissive FOR SELECT
    TO supabase_auth_admin
    USING (true);

-- RLS Method
CREATE OR REPLACE FUNCTION public.authorize(
  requested_role public.app_role
)
RETURNS BOOLEAN AS $$
DECLARE
  user_roles public.app_role[];
BEGIN
  SELECT ARRAY(
    SELECT jsonb_array_elements_text(auth.jwt()->'user_roles')::public.app_role
  ) INTO user_roles;

  RETURN requested_role = ANY(user_roles);
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = '';


-- RLS User Role Table
CREATE POLICY "admin can do everything in user_roles"
    ON public.user_roles
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );

-- Major Table
CREATE TABLE public.major (
    code TEXT PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- RLS Major Table
ALTER TABLE public.major ENABLE ROW LEVEL SECURITY;
CREATE POLICY "major select for authenticated"
    ON public.major FOR SELECT
    TO authenticated
    USING ( true );
CREATE POLICY "admin can do everything in major"
    ON public.major
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );


-- Study Program Table (Each study program belongs to a single major)
CREATE TABLE public.study_program (
    code text PRIMARY KEY,
    name TEXT NOT NULL,
    major_code TEXT REFERENCES public.major(code) ON DELETE CASCADE ON UPDATE CASCADE
);

-- RLS Study Program Table
ALTER TABLE public.study_program ENABLE ROW LEVEL SECURITY;
CREATE POLICY "study_program select for authenticated"
    ON public.study_program FOR SELECT
    TO authenticated
    USING ( true );
CREATE POLICY "admin can do everything in study_program"
    ON public.study_program
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );


-- Class Table (Each class belongs to a single study program)
CREATE TABLE public.class (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    study_program_code TEXT REFERENCES public.study_program(code) ON DELETE CASCADE ON UPDATE CASCADE,
    semester semester_type NOT NULL,
    class_group TEXT NOT NULL CHECK (class_group ~ '^[A-Z]$'),
    session_type class_session_type NOT NULL,
    admission_year INT CHECK (admission_year BETWEEN 1900 AND EXTRACT(YEAR FROM NOW())),
    UNIQUE (study_program_code, semester, class_group, session_type)
);

-- Computed field
CREATE FUNCTION full_class_name(public.class)
RETURNS text AS $$
  SELECT $1.study_program_code || ' ' || $1.semester || $1.class_group || ' ' || $1.session_type;
$$ LANGUAGE SQL;

-- RLS Class Table
ALTER TABLE public.class ENABLE ROW LEVEL SECURITY;
CREATE POLICY "class select for authenticated"
    ON public.class FOR SELECT
    TO authenticated
    USING ( true );
CREATE POLICY "admin can do everything in class"
    ON public.class
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );


-- Lecturer Table (Each lecturer belongs to a major)
CREATE TABLE public.lecturer (
    nik TEXT PRIMARY KEY,
    code TEXT DEFAULT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone_number TEXT CHECK (phone_number ~ '^\+?[1-9][0-9]{7,14}$'),
    major_code TEXT REFERENCES public.major(code) ON DELETE SET NULL ON UPDATE CASCADE
);

-- RLS Lecturer Table
ALTER TABLE public.lecturer ENABLE ROW LEVEL SECURITY;
CREATE POLICY "lecturer select for authenticated"
    ON public.lecturer FOR SELECT
    TO authenticated
    USING ( true );
CREATE POLICY "admin can do everything in lecturer"
    ON public.lecturer
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );


-- Subject/Course Table (Each subject belongs to a study program)
CREATE TABLE public.subject (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    semester semester_type NOT NULL,
    code TEXT UNIQUE NOT NULL,
    study_program_code TEXT REFERENCES public.study_program(code) ON DELETE CASCADE ON UPDATE CASCADE
);

-- RLS Subject Table
ALTER TABLE public.subject ENABLE ROW LEVEL SECURITY;
CREATE POLICY "subject select for authenticated"
    ON public.subject FOR SELECT
    TO authenticated
    USING ( true );
CREATE POLICY "admin can do everything in subject"
    ON public.subject
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );

-- Student Table
CREATE TABLE public.student (
    nim TEXT PRIMARY KEY,
    user_id UUID REFERENCES auth.users ON DELETE CASCADE ON UPDATE CASCADE NOT NULL UNIQUE,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    class_id UUID REFERENCES public.class(id) ON DELETE SET NULL
);

-- RLS Student Table
ALTER TABLE public.student ENABLE ROW LEVEL SECURITY;
CREATE POLICY "student select for authenticated"
    ON public.student FOR SELECT
    TO authenticated
    USING ( true );
CREATE POLICY "student update for same user_id"
    ON public.student FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "student insert their own data"
    ON public.student FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "admin can do everything in student"
    ON public.student
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );

-- Semester Table (To handle semester changes)
CREATE TABLE public.semester (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT FALSE
);

-- RLS Semester Table
ALTER TABLE public.semester ENABLE ROW LEVEL SECURITY;
CREATE POLICY "semester select for authenticated"
    ON public.semester FOR SELECT
    TO authenticated
    USING ( true );
CREATE POLICY "admin can do everything in semester"
    ON public.semester
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );


-- Enrollment table
CREATE TABLE public.enrollment (
    student_nim TEXT REFERENCES public.student(nim) ON UPDATE CASCADE ON DELETE CASCADE,
    subject_id UUID REFERENCES public.subject(id) ON DELETE CASCADE,
    PRIMARY KEY (student_nim, subject_id)
);

-- RLS Student Table
ALTER TABLE public.enrollment ENABLE ROW LEVEL SECURITY;
CREATE POLICY "student can manage their own enrollments"
    ON public.enrollment
    FOR ALL
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.student
            WHERE student.nim = enrollment.student_nim
            AND student.user_id = auth.uid()
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.student
            WHERE student.nim = enrollment.student_nim
            AND student.user_id = auth.uid()
        )
    );

CREATE POLICY "admin can do everything in enrollment"
    ON public.enrollment
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );


-- Room Table
CREATE TABLE public.room (
    code TEXT PRIMARY KEY
);

-- RLS Room Table
ALTER TABLE public.room ENABLE ROW LEVEL SECURITY;
CREATE POLICY "room select for authenticated"
    ON public.room FOR SELECT
    TO authenticated
    USING ( true );
CREATE POLICY "admin can do everything in room"
    ON public.room
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );

-- Schedule Table (Class schedules with optional room or Zoom)
CREATE TABLE public.schedule (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    subject_id UUID REFERENCES public.subject(id) ON DELETE CASCADE,
    class_id UUID REFERENCES public.class(id) ON DELETE CASCADE,
    lecturer_nik TEXT REFERENCES lecturer(nik) ON DELETE CASCADE,
    is_theory BOOLEAN NOT NULL DEFAULT TRUE,
    is_practice BOOLEAN NOT NULL DEFAULT FALSE,
    semester_id UUID REFERENCES public.semester(id) ON DELETE CASCADE,
    day_of_week INT NOT NULL CHECK (day_of_week BETWEEN 1 AND 7),
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    room_code TEXT REFERENCES public.room(code) ON DELETE SET NULL ON UPDATE CASCADE,
    zoom_link VARCHAR(500) DEFAULT NULL,
    CHECK (
        (room_code IS NOT NULL AND zoom_link IS NULL) OR 
        (room_code IS NULL AND zoom_link IS NOT NULL) OR 
        (room_code IS NULL AND zoom_link IS NULL)
    ),
    UNIQUE (subject_id, class_id, semester_id, day_of_week, start_time)
);

-- RLS Schedule Table
ALTER TABLE public.schedule ENABLE ROW LEVEL SECURITY;
CREATE POLICY "schedule select for authenticated"
    ON public.schedule FOR SELECT
    TO authenticated
    USING ( true );
CREATE POLICY "admin can do everything in schedule"
    ON public.schedule
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );

-- Subject Task Table (Tasks assigned to subjects, visible to all students in the class)
CREATE TABLE public.subject_task (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    subject_id UUID REFERENCES public.subject(id) ON DELETE CASCADE,
    class_id UUID REFERENCES public.class(id) ON DELETE CASCADE,
    student_nim TEXT REFERENCES public.student(nim) ON UPDATE CASCADE ON DELETE CASCADE,
    learning_link VARCHAR(500) DEFAULT NULL,
    deadline TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- RLS Subject Task Table
ALTER TABLE public.subject_task ENABLE ROW LEVEL SECURITY;
CREATE POLICY "student can manage their own subject task"
    ON public.subject_task
    FOR ALL
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.student
            WHERE student.class_id = subject_task.class_id
            AND student.nim = subject_task.student_nim
            AND student.user_id = auth.uid()
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.student
            WHERE student.class_id = subject_task.class_id
            AND student.nim = subject_task.student_nim
            AND student.user_id = auth.uid()
        )
    );

CREATE POLICY "admin can do everything in subject_task"
    ON public.subject_task
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );

-- Subject Task Student Table (Each student tracks their task status)
CREATE TABLE public.subject_task_student (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_nim TEXT REFERENCES public.student(nim) ON UPDATE CASCADE ON DELETE CASCADE,
    task_id UUID REFERENCES public.subject_task(id) ON DELETE CASCADE,
    status task_status NOT NULL DEFAULT 'pending',
    note TEXT,
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE (student_nim, task_id)
);

-- RLS Subject Task Student Table
ALTER TABLE public.subject_task_student ENABLE ROW LEVEL SECURITY;
CREATE POLICY "student can manage their own subject task item"
    ON public.subject_task_student
    FOR ALL
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.student
            WHERE student.nim = subject_task_student.student_nim
            AND student.user_id = auth.uid()
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.student
            WHERE student.nim = subject_task_student.student_nim
            AND student.user_id = auth.uid()
        )
    );

CREATE POLICY "admin can do everything in subject_task_student"
    ON public.subject_task_student
    FOR ALL
    TO authenticated
    USING (
        (SELECT authorize('admin'))
    )
    WITH CHECK (
        (SELECT authorize('admin'))
    );


-- View For Available Subject
CREATE VIEW available_subjects AS
    WITH student_info AS (
        SELECT st.nim, c.semester, c.study_program_code
        FROM student st
        JOIN class c ON st.class_id = c.id
        WHERE st.user_id = auth.uid()
    )
    SELECT s.*
    FROM subject s
    LEFT JOIN enrollment e
        ON s.id = e.subject_id
        AND e.student_nim = (SELECT nim FROM student_info)
    WHERE e.subject_id IS NULL
    AND s.semester = (SELECT semester FROM student_info)
    AND s.study_program_code = (SELECT study_program_code FROM student_info);
