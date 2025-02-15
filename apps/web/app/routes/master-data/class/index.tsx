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
import ClassAddModal from "./add-modal";

export const meta = () => {
  return [{ title: t("Kelola Kelas") }];
};

export const clientLoader = async ({ request }: Route.ClientLoaderArgs) => {
  const qs = parseSearchParams<BaseQS>(request);
  let page = 1;
  if (qs.page) {
    page = parseInt(qs.page);
  }
  let query = supabase.from("class").select("*", {
    count: "exact",
  });

  if (qs.search) {
    query = query.ilike("full_class_name", "%" + qs.search.replace(" ", "%") + "%");
  }

  const { data, count, error } = await query
    .order("full_class_name", {
      ascending: true,
    })
    .range(...getRange(page));

  if (error) throw error;

  return { data, total: count! };
};

const Class: React.FC<Route.ComponentProps> = ({ loaderData }) => {
  const [showAdd, setShowAdd] = useState(false);
  const [showEdit, setShowEdit] = useState<Tables<"class">>();
  const [showDelete, setShowDelete] = useState<Tables<"class">>();
  const revalidator = useRevalidator();

  const columns: ClientLoaderTableCol<typeof clientLoader>[] = [
    {
      title: "Program Studi",
      colClassName: "font-bold",
      key: "study_program_code",
    },
    {
      title: "Semester",
      key: "semester",
    },
    {
      title: "Grup Kelas",
      key: "class_group",
    },
    {
      title: "Jenis Sesi",
      key: "session_type",
    },
    {
      title: "Tahun Masuk",
      key: "admission_year",
    },
    {
      title: "",
      key: "id",
      headClassName: "w-16",
      renderItem(value, item) {
        return (
          <DefaultDropdown onEdit={() => setShowEdit(item)} onDelete={() => setShowDelete(item)} />
        );
      },
    },
  ];

  return (
    <div>
      <TopSection title="Kelas" onAdd={() => setShowAdd(true)} />
      <TableData data={loaderData.data} columns={columns} rowKey="id" total={loaderData.total} />
      <ClassAddModal
        open={showAdd}
        onClose={() => setShowAdd(false)}
        onSuccess={revalidator.revalidate}
      />
      <ClassAddModal
        isEdit={true}
        open={showEdit !== undefined}
        onClose={() => setShowEdit(undefined)}
        data={showEdit}
        onSuccess={revalidator.revalidate}
      />
      <DeleteDialog
        title="Kelas"
        table="class"
        colKey="id"
        colVal={showDelete?.id}
        label={
          showDelete
            ? showDelete.study_program_code +
              " " +
              showDelete.semester +
              showDelete.class_group +
              " " +
              showDelete.session_type
            : undefined
        }
        onSuccess={revalidator.revalidate}
        onCancel={() => setShowDelete(undefined)}
      />
    </div>
  );
};
export default Class;
