import supabase from "~/lib/supabase";
import { toast } from "sonner";
import SelectAsync from "./select-async";
import type { BaseSelect } from "./select";

const SelectLecturer: React.FC<BaseSelect> = ({ value, onChange }) => {
  const doSearch = async (search: string) => {
    const { data, error } = await supabase
      .from("lecturer")
      .select("*")
      .ilike("name", "%" + search.replaceAll(" ", "%") + "%")
      .order("name", { ascending: true });
    if (data) {
      return data.map((item) => ({
        label: item.name,
        value: item.nik,
      }));
    }
    if (error) {
      toast.error(error.name, {
        description: error.message,
      });
    }
  };

  const getLabel = async (id: string) => {
    const { data, error } = await supabase.from("lecturer").select("name").eq("nik", id);
    if (data) {
      return data?.[0]?.name;
    }
    if (error) {
      toast.error(error.name, {
        description: error.message,
      });
    }
  };

  return (
    <SelectAsync
      placeholder="Pilih Dosen..."
      value={value}
      onChange={onChange}
      onSearch={doSearch}
      getSingleLabel={getLabel}
    />
  );
};
export default SelectLecturer;
