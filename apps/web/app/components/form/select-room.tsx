import supabase from "~/lib/supabase";
import { toast } from "sonner";
import SelectAsync from "./select-async";
import type { BaseSelect } from "./select";

const SelectRoom: React.FC<BaseSelect> = ({ ...rest }) => {
  const doSearch = async (search: string) => {
    const { data, error } = await supabase
      .from("room")
      .select("*")
      .ilike("code", "%" + search.replaceAll(" ", "%") + "%")
      .order("code", { ascending: true });
    if (data) {
      return data.map((item) => ({
        label: item.code,
        value: item.code,
      }));
    }
    if (error) {
      toast.error(error.name, {
        description: error.message,
      });
    }
  };

  const getLabel = async (id: string) => {
    return id;
  };

  return (
    <SelectAsync
      placeholder="Pilih Ruangan..."
      {...rest}
      onSearch={doSearch}
      getSingleLabel={getLabel}
    />
  );
};
export default SelectRoom;
