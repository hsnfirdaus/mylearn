import React, { useState } from "react";
import { parseSearchParams } from "~/lib/url";
import type { BaseQS } from "~/types/url.type";
import supabase, { getRange } from "~/lib/supabase";
import { t } from "~/lib/meta";
import TableData from "~/components/table-data";
import type { ClientLoaderTableCol } from "~/types/loader.type";
import { useRevalidator } from "react-router";
import TopSection from "~/components/top-section";
import DefaultDropdown from "~/components/default-dropdown";
import type { Tables } from "~/types/supabase";
import DeleteDialog from "~/components/delete-dialog";
import type { Route } from "./+types";
import ScheduleAddModal from "./add-modal";

export const meta = () => {
  return [{ title: t("Kelola Jadwal") }];
};

type QS = BaseQS & {
  class_id?: string;
  lecturer_nik?: string;
  semester_id?: string;
  day_of_week?: string;
};
export const clientLoader = async ({ request }: Route.ClientLoaderArgs) => {
  const qs = parseSearchParams<QS>(request);
  let page = 1;
  if (qs.page) {
    page = parseInt(qs.page);
  }
  let query = supabase
    .from("schedule")
    .select(
      `id, subject( id, name, code ), class (id, full_class_name), lecturer (nik, name, code), is_theory, is_practice, semester (id, name), day_of_week, start_time, end_time, room_code, zoom_link`,
      {
        count: "exact",
      },
    );

  if (qs.class_id) {
    query = query.eq("class_id", qs.class_id);
  }

  if (qs.lecturer_nik) {
    query = query.eq("lecturer_nik", qs.lecturer_nik);
  }

  if (qs.semester_id) {
    query = query.eq("semester_id", qs.semester_id);
  }

  if (qs.day_of_week) {
    query = query.eq("day_of_week", parseInt(qs.day_of_week));
  }

  const { data, count, error } = await query
    .order("class_id", {
      ascending: true,
    })
    .order("day_of_week", {
      ascending: true,
    })
    .order("start_time", {
      ascending: true,
    })
    .range(...getRange(page));

  if (error) throw error;

  return { data, total: count! };
};

const Semester: React.FC<Route.ComponentProps> = ({ loaderData }) => {
  const [showAdd, setShowAdd] = useState(false);
  const [showEdit, setShowEdit] = useState<Tables<"schedule">>();
  const [showDelete, setShowDelete] = useState<Tables<"schedule">>();
  const revalidator = useRevalidator();

  const columns: ClientLoaderTableCol<typeof clientLoader>[] = [
    {
      title: "Semester",
      key: ["semester", "name"],
    },
    {
      title: "Kelas",
      key: ["class", "full_class_name"],
    },
    {
      title: "Hari",
      key: "day_of_week",
      renderItem: (v) => {
        const days = ["Senin", "Selasa", "Rabu", "Kamis", "Jum'at", "Sabtu", "Minggu"];

        return days[v as number];
      },
    },
    {
      title: "Mulai",
      key: "start_time",
    },
    {
      title: "Selesai",
      key: "end_time",
    },
    {
      title: "Dosen",
      key: ["lecturer", "name"],
    },
    {
      title: "Ruangan",
      key: "room_code",
    },
    {
      title: "",
      key: "id",
      headClassName: "w-16",
      renderItem(value, item) {
        const realItem: Tables<"schedule"> = {
          id: item.id,
          subject_id: item.subject!.id,
          class_id: item.class!.id,
          lecturer_nik: item.lecturer!.nik,
          is_theory: item.is_theory,
          is_practice: item.is_practice,
          semester_id: item.semester!.id,
          day_of_week: item.day_of_week,
          start_time: item.start_time,
          end_time: item.end_time,
          room_code: item.room_code,
          zoom_link: item.zoom_link,
        };
        return (
          <DefaultDropdown
            onEdit={() => setShowEdit(realItem)}
            onDelete={() => setShowDelete(realItem)}
          />
        );
      },
    },
  ];

  return (
    <div>
      <TopSection title="Jadwal" onAdd={() => setShowAdd(true)} />
      <TableData data={loaderData.data} columns={columns} rowKey="id" total={loaderData.total} />
      <ScheduleAddModal
        open={showAdd}
        onClose={() => setShowAdd(false)}
        onSuccess={revalidator.revalidate}
      />
      <ScheduleAddModal
        isEdit={true}
        open={showEdit !== undefined}
        onClose={() => setShowEdit(undefined)}
        data={showEdit}
        onSuccess={revalidator.revalidate}
      />
      <DeleteDialog
        title="Jadwal"
        table="schedule"
        colKey="id"
        colVal={showDelete?.id}
        label="ini"
        onSuccess={revalidator.revalidate}
        onCancel={() => setShowDelete(undefined)}
      />
    </div>
  );
};
export default Semester;
