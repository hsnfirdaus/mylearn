import React, { useState } from "react";
import { parseSearchParams } from "~/lib/url";
import type { BaseQS } from "~/types/url.type";
import supabase, { getRange } from "~/lib/supabase";
import { t } from "~/lib/meta";
import TableData from "~/components/table-data";
import type { ClientLoaderTableCol } from "~/types/loader.type";
import MajorAddModal from "./add-modal";
import { useRevalidator } from "react-router";
import TopSection from "~/components/top-section";
import DefaultDropdown from "~/components/default-dropdown";
import type { Tables } from "~/types/supabase";
import DeleteDialog from "~/components/delete-dialog";
import type { Route } from "./+types";

export const meta = () => {
  return [{ title: t("Kelola Jurusan") }];
};

export const clientLoader = async ({ request }: Route.ClientLoaderArgs) => {
  const qs = parseSearchParams<BaseQS>(request);
  let page = 1;
  if (qs.page) {
    page = parseInt(qs.page);
  }
  let query = supabase.from("major").select("*", {
    count: "exact",
  });

  if (qs.search) {
    query = query.ilike("name", "%" + qs.search.replace(" ", "%") + "%");
  }

  const { data, count, error } = await query.range(...getRange(page));

  if (error) throw error;

  return { data, total: count! };
};

const Major: React.FC<Route.ComponentProps> = ({ loaderData }) => {
  const [showAdd, setShowAdd] = useState(false);
  const [showEdit, setShowEdit] = useState<Tables<"major">>();
  const [showDelete, setShowDelete] = useState<Tables<"major">>();
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
      <TopSection title="Jurusan" onAdd={() => setShowAdd(true)} />
      <TableData data={loaderData.data} columns={columns} rowKey="code" total={loaderData.total} />
      <MajorAddModal
        open={showAdd}
        onClose={() => setShowAdd(false)}
        onSuccess={revalidator.revalidate}
      />
      <MajorAddModal
        isEdit={true}
        open={showEdit !== undefined}
        onClose={() => setShowEdit(undefined)}
        data={showEdit}
        onSuccess={revalidator.revalidate}
      />
      <DeleteDialog
        title="Jurusan"
        table="major"
        colKey="code"
        colVal={showDelete?.code}
        label={showDelete?.name}
        onSuccess={revalidator.revalidate}
        onCancel={() => setShowDelete(undefined)}
      />
    </div>
  );
};
export default Major;
