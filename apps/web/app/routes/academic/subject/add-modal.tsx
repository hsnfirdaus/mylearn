import { z } from "zod";
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from "~/components/ui/form";
import { Input } from "~/components/ui/input";
import React from "react";
import type { AddModalProps } from "~/components/base-add-modal";
import BaseAddModal from "~/components/base-add-modal";
import supabase from "~/lib/supabase";
import InputNumber from "~/components/form/input-number";
import SelectStudyProgram from "~/components/form/select-study-program";

const formSchema = z.object({
  name: z.string(),
  semester: z.number().min(1).max(8),
  code: z.string(),
  study_program_code: z.string(),
});
const SubjectAddModal: React.FC<AddModalProps<"subject">> = (props) => {
  const doAdd = async (values: z.infer<typeof formSchema>) => {
    return await supabase.from("subject").insert({
      name: values.name,
      semester: values.semester,
      code: values.code,
      study_program_code: values.study_program_code,
    });
  };

  const doEdit = async (values: z.infer<typeof formSchema>) => {
    return await supabase
      .from("subject")
      .update({
        name: values.name,
        semester: values.semester,
        code: values.code,
        study_program_code: values.study_program_code,
      })
      .eq("id", props.data!.id);
  };
  return (
    <BaseAddModal
      {...props}
      title="Mata Kuliah"
      formSchema={formSchema}
      doAdd={doAdd}
      doEdit={doEdit}
    >
      {(form) => (
        <React.Fragment>
          <FormField
            control={form.control}
            name="name"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Nama Mata Kuliah</FormLabel>
                <FormControl>
                  <Input placeholder="Pengantar Rekayasa Perangkat Lunak" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="semester"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Semester</FormLabel>
                <FormControl>
                  <InputNumber placeholder="1" min={1} max={8} {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="code"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Kode Matkul</FormLabel>
                <FormControl>
                  <Input placeholder="RPL104" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="study_program_code"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Program Studi</FormLabel>
                <FormControl>
                  <SelectStudyProgram {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
        </React.Fragment>
      )}
    </BaseAddModal>
  );
};
export default SubjectAddModal;
