import { useEffect, useState, useTransition } from "react";
import type { BaseSelect } from "./select";
import supabase from "~/lib/supabase";
import { toast } from "sonner";
import Select from "./select";
import type { Tables } from "~/types/supabase";

const SelectMajor: React.FC<BaseSelect> = ({ ...rest }) => {
  const [majors, setMajor] = useState<Tables<"major">[]>([]);
  const [isLoading, startStudyProgramLoading] = useTransition();

  useEffect(() => {
    startStudyProgramLoading(async () => {
      const { data, error } = await supabase
        .from("major")
        .select("*")
        .order("name", { ascending: true });
      if (data) {
        setMajor(data);
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
      options={majors.map((item) => ({
        label: item.name,
        value: item.code,
      }))}
      isLoading={isLoading}
      {...rest}
    />
  );
};
export default SelectMajor;
