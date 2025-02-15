import { useEffect, useState, useTransition } from "react";
import type { BaseSelect } from "./select";
import supabase from "~/lib/supabase";
import { toast } from "sonner";
import Select from "./select";
import type { Tables } from "~/types/supabase";

const SelectSemester: React.FC<BaseSelect> = ({ ...rest }) => {
  const [semester, setSemester] = useState<Tables<"semester">[]>([]);
  const [isLoading, startStudyProgramLoading] = useTransition();

  useEffect(() => {
    startStudyProgramLoading(async () => {
      const { data, error } = await supabase.from("semester").select("*").order("start_date", {
        ascending: false,
      });
      if (data) {
        setSemester(data);
      }
      if (error) {
        toast.error(error.name, {
          description: error.message,
        });
      }
    });
  }, []);

  return (
    <Select
      options={semester.map((item) => ({
        label: item.name + (item.is_active ? " (Aktif)" : ""),
        value: item.id,
      }))}
      isLoading={isLoading}
      {...rest}
    />
  );
};
export default SelectSemester;
