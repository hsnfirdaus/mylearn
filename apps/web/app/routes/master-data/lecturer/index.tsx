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
import LecturerAddModal from "./add-modal";

export const meta = () => {
  return [{ title: t("Kelola Dosen") }];
};

export const clientLoader = async ({ request }: Route.ClientLoaderArgs) => {
  const qs = parseSearchParams<BaseQS>(request);
  let page = 1;
  if (qs.page) {
    page = parseInt(qs.page);
  }
  let query = supabase.from("lecturer").select("*", {
    count: "exact",
  });

  if (qs.search) {
    query = query.ilike("name", "%" + qs.search.replace(" ", "%") + "%");
  }

  const { data, count, error } = await query
    .order("name", {
      ascending: true,
    })
    .range(...getRange(page));

  if (error) throw error;

  return { data, total: count! };
};

const Lecturer: React.FC<Route.ComponentProps> = ({ loaderData }) => {
  const [showAdd, setShowAdd] = useState(false);
  const [showEdit, setShowEdit] = useState<Tables<"lecturer">>();
  const [showDelete, setShowDelete] = useState<Tables<"lecturer">>();
  const revalidator = useRevalidator();

  const columns: ClientLoaderTableCol<typeof clientLoader>[] = [
    {
      title: "Foto",
      key: "photo_url",
      colClassName: "w-14",
      renderItem(value, item) {
        return (
          <figure className="h-12 w-12 overflow-hidden rounded-md bg-accent">
            {value ? (
              <img src={value} className="h-full w-full object-cover object-center" />
            ) : (
              <React.Fragment />
            )}
          </figure>
        );
      },
    },
    {
      title: "NIK",
      colClassName: "font-bold",
      key: "nik",
    },
    {
      title: "Kode",
      key: "code",
    },
    {
      title: "Nama",
      key: "name",
    },
    {
      title: "Email",
      key: "email",
    },
    {
      title: "Nomor Telepon",
      key: "phone_number",
    },
    {
      title: "Jurusan",
      key: "major_code",
    },
    {
      title: "",
      key: "nik",
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
      <TopSection title="Dosen" onAdd={() => setShowAdd(true)} />
      <TableData data={loaderData.data} columns={columns} rowKey="nik" total={loaderData.total} />
      <LecturerAddModal
        open={showAdd}
        onClose={() => setShowAdd(false)}
        onSuccess={revalidator.revalidate}
      />
      <LecturerAddModal
        isEdit={true}
        open={showEdit !== undefined}
        onClose={() => setShowEdit(undefined)}
        data={showEdit}
        onSuccess={revalidator.revalidate}
      />
      <DeleteDialog
        title="Dosen"
        table="lecturer"
        colKey="nik"
        colVal={showDelete?.nik}
        label={showDelete?.name}
        onSuccess={revalidator.revalidate}
        onCancel={() => setShowDelete(undefined)}
      />
    </div>
  );
};
export default Lecturer;
