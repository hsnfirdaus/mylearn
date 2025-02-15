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
import StudyProgramAddModal from "./add-modal";

export const meta = () => {
  return [{ title: t("Kelola Prodi") }];
};

export const clientLoader = async ({ request }: Route.ClientLoaderArgs) => {
  const qs = parseSearchParams<BaseQS>(request);
  let page = 1;
  if (qs.page) {
    page = parseInt(qs.page);
  }
  let query = supabase.from("study_program").select("*", {
    count: "exact",
  });

  if (qs.search) {
    query = query.ilike("name", "%" + qs.search.replace(" ", "%") + "%");
  }

  const { data, count, error } = await query.range(...getRange(page));

  if (error) throw error;

  return { data, total: count! };
};

const StudyProgram: React.FC<Route.ComponentProps> = ({ loaderData }) => {
  const [showAdd, setShowAdd] = useState(false);
  const [showEdit, setShowEdit] = useState<Tables<"study_program">>();
  const [showDelete, setShowDelete] = useState<Tables<"study_program">>();
  const revalidator = useRevalidator();

  const columns: ClientLoaderTableCol<typeof clientLoader>[] = [
    {
      title: "Kode",
      headClassName: "w-[100px]",
      colClassName: "font-bold",
      key: "code",
    },
    {
      title: "Nama",
      key: "name",
    },
    {
      title: "Jurusan",
      key: "major_code",
    },
    {
      title: "",
      key: "code",
      headClassName: "w-16",
      renderItem(value, item) {
        return (
          <DefaultDropdown onEdit={() => setShowEdit(item)} onDelete={() => setShowDelete(item)} />
        );
      },
    },
  ];

  return (
    <div className="max-w-xl mx-auto">
      <TopSection title="Program Studi" onAdd={() => setShowAdd(true)} />
      <TableData data={loaderData.data} columns={columns} rowKey="code" total={loaderData.total} />
      <StudyProgramAddModal
        open={showAdd}
        onClose={() => setShowAdd(false)}
        onSuccess={revalidator.revalidate}
      />
      <StudyProgramAddModal
        isEdit={true}
        open={showEdit !== undefined}
        onClose={() => setShowEdit(undefined)}
        data={showEdit}
        onSuccess={revalidator.revalidate}
      />
      <DeleteDialog
        title="Program Studi"
        table="study_program"
        colKey="code"
        colVal={showDelete?.code}
        label={showDelete?.name}
        onSuccess={revalidator.revalidate}
        onCancel={() => setShowDelete(undefined)}
      />
    </div>
  );
};
export default StudyProgram;
