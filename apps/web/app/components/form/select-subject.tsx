import supabase from "~/lib/supabase";
import { toast } from "sonner";
import SelectAsync from "./select-async";
import type { BaseSelect } from "./select";

const SelectSubject: React.FC<BaseSelect> = ({ value, onChange }) => {
  const doSearch = async (search: string) => {
    const { data, error } = await supabase
      .from("subject")
      .select("*")
      .ilike("name", "%" + search.replaceAll(" ", "%") + "%")
      .order("name", { ascending: true });
    if (data) {
      return data.map((item) => ({
        label: "[" + item.code + "] " + item.name,
        value: item.id,
      }));
    }
    if (error) {
      toast.error(error.name, {
        description: error.message,
      });
    }
  };

  const getLabel = async (id: string) => {
    const { data, error } = await supabase.from("subject").select("name, code").eq("id", id);
    if (data) {
      const row = data?.[0];
      return "[" + row.code + "] " + row.name;
    }
    if (error) {
      toast.error(error.name, {
        description: error.message,
      });
    }
  };

  return (
    <SelectAsync
      placeholder="Pilih Mata Kuliah..."
      value={value}
      onChange={onChange}
      onSearch={doSearch}
      getSingleLabel={getLabel}
    />
  );
};
export default SelectSubject;
