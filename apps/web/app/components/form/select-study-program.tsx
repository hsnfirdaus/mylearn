import { useEffect, useState, useTransition } from "react";
import type { BaseSelect } from "./select";
import supabase from "~/lib/supabase";
import { toast } from "sonner";
import Select from "./select";
import type { Tables } from "~/types/supabase";

const SelectStudyProgram: React.FC<BaseSelect> = ({ ...rest }) => {
  const [studyPrograms, setStudyPrograms] = useState<Tables<"study_program">[]>([]);
  const [isLoading, startStudyProgramLoading] = useTransition();

  useEffect(() => {
    startStudyProgramLoading(async () => {
      const { data, error } = await supabase
        .from("study_program")
        .select("*")
        .order("name", { ascending: true });
      if (data) {
        setStudyPrograms(data);
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
      options={studyPrograms.map((item) => ({
        label: item.name,
        value: item.code,
      }))}
      isLoading={isLoading}
      {...rest}
    />
  );
};
export default SelectStudyProgram;
