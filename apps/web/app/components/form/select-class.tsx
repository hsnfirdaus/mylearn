import supabase from "~/lib/supabase";
import { toast } from "sonner";
import SelectAsync from "./select-async";
import type { BaseSelect } from "./select";

const SelectClass: React.FC<BaseSelect> = ({ value, onChange }) => {
  const doSearch = async (search: string) => {
    const { data, error } = await supabase
      .from("class")
      .select("id, full_class_name")
      .ilike("full_class_name", "%" + search.replaceAll(" ", "%") + "%")
      .order("full_class_name", { ascending: true });
    if (data) {
      return data.map((item) => ({
        label: item.full_class_name + "",
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
    const { data, error } = await supabase.from("class").select("full_class_name").eq("id", id);
    if (data) {
      return data?.[0]?.full_class_name;
    }
    if (error) {
      toast.error(error.name, {
        description: error.message,
      });
    }
  };

  return (
    <SelectAsync
      placeholder="Pilih Kelas..."
      value={value}
      onChange={onChange}
      onSearch={doSearch}
      getSingleLabel={getLabel}
    />
  );
};
export default SelectClass;
