export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          operationName?: string
          query?: string
          variables?: Json
          extensions?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  pgbouncer: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      get_auth: {
        Args: {
          p_usename: string
        }
        Returns: {
          username: string
          password: string
        }[]
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      class: {
        Row: {
          admission_year: number | null
          class_group: string
          id: string
          semester: number
          session_type: Database["public"]["Enums"]["class_session_type"]
          study_program_code: string | null
          full_class_name: string | null
        }
        Insert: {
          admission_year?: number | null
          class_group: string
          id?: string
          semester: number
          session_type: Database["public"]["Enums"]["class_session_type"]
          study_program_code?: string | null
        }
        Update: {
          admission_year?: number | null
          class_group?: string
          id?: string
          semester?: number
          session_type?: Database["public"]["Enums"]["class_session_type"]
          study_program_code?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "class_study_program_code_fkey"
            columns: ["study_program_code"]
            referencedRelation: "study_program"
            referencedColumns: ["code"]
          },
        ]
      }
      enrollment: {
        Row: {
          student_nim: string
          subject_id: string
        }
        Insert: {
          student_nim: string
          subject_id: string
        }
        Update: {
          student_nim?: string
          subject_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "enrollment_student_nim_fkey"
            columns: ["student_nim"]
            referencedRelation: "student"
            referencedColumns: ["nim"]
          },
          {
            foreignKeyName: "enrollment_subject_id_fkey"
            columns: ["subject_id"]
            referencedRelation: "available_subjects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "enrollment_subject_id_fkey"
            columns: ["subject_id"]
            referencedRelation: "subject"
            referencedColumns: ["id"]
          },
        ]
      }
      lecturer: {
        Row: {
          code: string | null
          email: string | null
          major_code: string | null
          name: string
          nik: string
          phone_number: string | null
          photo_url: string | null
        }
        Insert: {
          code?: string | null
          email?: string | null
          major_code?: string | null
          name: string
          nik: string
          phone_number?: string | null
          photo_url?: string | null
        }
        Update: {
          code?: string | null
          email?: string | null
          major_code?: string | null
          name?: string
          nik?: string
          phone_number?: string | null
          photo_url?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "lecturer_major_code_fkey"
            columns: ["major_code"]
            referencedRelation: "major"
            referencedColumns: ["code"]
          },
        ]
      }
      major: {
        Row: {
          code: string
          name: string
        }
        Insert: {
          code: string
          name: string
        }
        Update: {
          code?: string
          name?: string
        }
        Relationships: []
      }
      room: {
        Row: {
          code: string
        }
        Insert: {
          code: string
        }
        Update: {
          code?: string
        }
        Relationships: []
      }
      schedule: {
        Row: {
          class_id: string | null
          day_of_week: number
          end_time: string
          id: string
          is_practice: boolean
          is_theory: boolean
          lecturer_nik: string | null
          room_code: string | null
          semester_id: string | null
          start_time: string
          subject_id: string | null
          zoom_link: string | null
        }
        Insert: {
          class_id?: string | null
          day_of_week: number
          end_time: string
          id?: string
          is_practice?: boolean
          is_theory?: boolean
          lecturer_nik?: string | null
          room_code?: string | null
          semester_id?: string | null
          start_time: string
          subject_id?: string | null
          zoom_link?: string | null
        }
        Update: {
          class_id?: string | null
          day_of_week?: number
          end_time?: string
          id?: string
          is_practice?: boolean
          is_theory?: boolean
          lecturer_nik?: string | null
          room_code?: string | null
          semester_id?: string | null
          start_time?: string
          subject_id?: string | null
          zoom_link?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "schedule_class_id_fkey"
            columns: ["class_id"]
            referencedRelation: "class"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "schedule_lecturer_nik_fkey"
            columns: ["lecturer_nik"]
            referencedRelation: "lecturer"
            referencedColumns: ["nik"]
          },
          {
            foreignKeyName: "schedule_room_code_fkey"
            columns: ["room_code"]
            referencedRelation: "room"
            referencedColumns: ["code"]
          },
          {
            foreignKeyName: "schedule_semester_id_fkey"
            columns: ["semester_id"]
            referencedRelation: "semester"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "schedule_subject_id_fkey"
            columns: ["subject_id"]
            referencedRelation: "available_subjects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "schedule_subject_id_fkey"
            columns: ["subject_id"]
            referencedRelation: "subject"
            referencedColumns: ["id"]
          },
        ]
      }
      semester: {
        Row: {
          end_date: string
          id: string
          is_active: boolean | null
          name: string
          start_date: string
        }
        Insert: {
          end_date: string
          id?: string
          is_active?: boolean | null
          name: string
          start_date: string
        }
        Update: {
          end_date?: string
          id?: string
          is_active?: boolean | null
          name?: string
          start_date?: string
        }
        Relationships: []
      }
      student: {
        Row: {
          class_id: string | null
          email: string | null
          name: string
          nim: string
          user_id: string
        }
        Insert: {
          class_id?: string | null
          email?: string | null
          name: string
          nim: string
          user_id: string
        }
        Update: {
          class_id?: string | null
          email?: string | null
          name?: string
          nim?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "student_class_id_fkey"
            columns: ["class_id"]
            referencedRelation: "class"
            referencedColumns: ["id"]
          },
        ]
      }
      study_program: {
        Row: {
          code: string
          major_code: string | null
          name: string
        }
        Insert: {
          code: string
          major_code?: string | null
          name: string
        }
        Update: {
          code?: string
          major_code?: string | null
          name?: string
        }
        Relationships: [
          {
            foreignKeyName: "study_program_major_code_fkey"
            columns: ["major_code"]
            referencedRelation: "major"
            referencedColumns: ["code"]
          },
        ]
      }
      subject: {
        Row: {
          code: string
          id: string
          name: string
          semester: number
          study_program_code: string | null
        }
        Insert: {
          code: string
          id?: string
          name: string
          semester: number
          study_program_code?: string | null
        }
        Update: {
          code?: string
          id?: string
          name?: string
          semester?: number
          study_program_code?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "subject_study_program_code_fkey"
            columns: ["study_program_code"]
            referencedRelation: "study_program"
            referencedColumns: ["code"]
          },
        ]
      }
      subject_task: {
        Row: {
          class_id: string | null
          created_at: string | null
          deadline: string
          description: string | null
          id: string
          learning_link: string | null
          student_nim: string | null
          subject_id: string | null
          title: string
        }
        Insert: {
          class_id?: string | null
          created_at?: string | null
          deadline: string
          description?: string | null
          id?: string
          learning_link?: string | null
          student_nim?: string | null
          subject_id?: string | null
          title: string
        }
        Update: {
          class_id?: string | null
          created_at?: string | null
          deadline?: string
          description?: string | null
          id?: string
          learning_link?: string | null
          student_nim?: string | null
          subject_id?: string | null
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "subject_task_class_id_fkey"
            columns: ["class_id"]
            referencedRelation: "class"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "subject_task_student_nim_fkey"
            columns: ["student_nim"]
            referencedRelation: "student"
            referencedColumns: ["nim"]
          },
          {
            foreignKeyName: "subject_task_subject_id_fkey"
            columns: ["subject_id"]
            referencedRelation: "available_subjects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "subject_task_subject_id_fkey"
            columns: ["subject_id"]
            referencedRelation: "subject"
            referencedColumns: ["id"]
          },
        ]
      }
      subject_task_student: {
        Row: {
          id: string
          note: string | null
          status: Database["public"]["Enums"]["task_status"]
          student_nim: string | null
          task_id: string | null
          updated_at: string | null
        }
        Insert: {
          id?: string
          note?: string | null
          status?: Database["public"]["Enums"]["task_status"]
          student_nim?: string | null
          task_id?: string | null
          updated_at?: string | null
        }
        Update: {
          id?: string
          note?: string | null
          status?: Database["public"]["Enums"]["task_status"]
          student_nim?: string | null
          task_id?: string | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "subject_task_student_student_nim_fkey"
            columns: ["student_nim"]
            referencedRelation: "student"
            referencedColumns: ["nim"]
          },
          {
            foreignKeyName: "subject_task_student_task_id_fkey"
            columns: ["task_id"]
            referencedRelation: "subject_task"
            referencedColumns: ["id"]
          },
        ]
      }
      user_roles: {
        Row: {
          id: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Insert: {
          id?: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Update: {
          id?: string
          role?: Database["public"]["Enums"]["app_role"]
          user_id?: string
        }
        Relationships: []
      }
    }
    Views: {
      available_subjects: {
        Row: {
          code: string | null
          id: string | null
          name: string | null
          semester: number | null
          study_program_code: string | null
        }
        Relationships: [
          {
            foreignKeyName: "subject_study_program_code_fkey"
            columns: ["study_program_code"]
            referencedRelation: "study_program"
            referencedColumns: ["code"]
          },
        ]
      }
    }
    Functions: {
      authorize: {
        Args: {
          requested_role: Database["public"]["Enums"]["app_role"]
        }
        Returns: boolean
      }
      custom_access_token_hook: {
        Args: {
          event: Json
        }
        Returns: Json
      }
      full_class_name: {
        Args: {
          "": unknown
        }
        Returns: string
      }
    }
    Enums: {
      app_role: "student" | "admin"
      class_session_type: "Pagi" | "Malam"
      task_status: "pending" | "not_submitted" | "submitted"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  storage: {
    Tables: {
      buckets: {
        Row: {
          created_at: string | null
          id: string
          name: string
          owner: string | null
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          id: string
          name: string
          owner?: string | null
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          id?: string
          name?: string
          owner?: string | null
          updated_at?: string | null
        }
        Relationships: []
      }
      migrations: {
        Row: {
          executed_at: string | null
          hash: string
          id: number
          name: string
        }
        Insert: {
          executed_at?: string | null
          hash: string
          id: number
          name: string
        }
        Update: {
          executed_at?: string | null
          hash?: string
          id?: number
          name?: string
        }
        Relationships: []
      }
      objects: {
        Row: {
          bucket_id: string | null
          created_at: string | null
          id: string
          last_accessed_at: string | null
          metadata: Json | null
          name: string | null
          owner: string | null
          updated_at: string | null
        }
        Insert: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          updated_at?: string | null
        }
        Update: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "objects_bucketId_fkey"
            columns: ["bucket_id"]
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      extension: {
        Args: {
          name: string
        }
        Returns: string
      }
      filename: {
        Args: {
          name: string
        }
        Returns: string
      }
      foldername: {
        Args: {
          name: string
        }
        Returns: string[]
      }
      search: {
        Args: {
          prefix: string
          bucketname: string
          limits?: number
          levels?: number
          offsets?: number
        }
        Returns: {
          name: string
          id: string
          updated_at: string
          created_at: string
          last_accessed_at: string
          metadata: Json
        }[]
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type PublicSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (PublicSchema["Tables"] & PublicSchema["Views"])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
        Database[PublicTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
      Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (PublicSchema["Tables"] &
        PublicSchema["Views"])
    ? (PublicSchema["Tables"] &
        PublicSchema["Views"])[PublicTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof PublicSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : PublicEnumNameOrOptions extends keyof PublicSchema["Enums"]
    ? PublicSchema["Enums"][PublicEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof PublicSchema["CompositeTypes"]
    | { schema: keyof Database },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends { schema: keyof Database }
  ? Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof PublicSchema["CompositeTypes"]
    ? PublicSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never
