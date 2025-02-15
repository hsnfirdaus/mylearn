import { z } from "zod";
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from "~/components/ui/form";
import { Input } from "~/components/ui/input";
import React from "react";
import type { AddModalProps } from "~/components/base-add-modal";
import BaseAddModal from "~/components/base-add-modal";
import supabase from "~/lib/supabase";
import SelectMajor from "~/components/form/select-major";

const formSchema = z.object({
  code: z.string(),
  name: z.string(),
  major_code: z.string(),
});
const StudyProgramAddModal: React.FC<AddModalProps<"study_program">> = (props) => {
  const doAdd = async (values: z.infer<typeof formSchema>) => {
    return await supabase.from("study_program").insert({
      code: values.code,
      name: values.name,
      major_code: values.major_code,
    });
  };

  const doEdit = async (values: z.infer<typeof formSchema>) => {
    return await supabase
      .from("study_program")
      .update({
        code: values.code,
        name: values.name,
        major_code: values.major_code,
      })
      .eq("code", props.data!.code);
  };
  return (
    <BaseAddModal
      {...props}
      title="Program Studi"
      formSchema={formSchema}
      doAdd={doAdd}
      doEdit={doEdit}
    >
      {(form) => (
        <React.Fragment>
          <FormField
            control={form.control}
            name="code"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Kode Prodi</FormLabel>
                <FormControl>
                  <Input placeholder="TRPL" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="name"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Name Prodi</FormLabel>
                <FormControl>
                  <Input placeholder="Teknologi Rekayasa Perangkat Lunak" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="major_code"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Jurusan</FormLabel>
                <FormControl>
                  <SelectMajor {...field} />
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
export default StudyProgramAddModal;
