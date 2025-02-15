import { z } from "zod";
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from "~/components/ui/form";
import { Input } from "~/components/ui/input";
import React, { useEffect, useState, useTransition } from "react";
import type { AddModalProps } from "~/components/base-add-modal";
import BaseAddModal from "~/components/base-add-modal";
import supabase from "~/lib/supabase";
import type { Tables } from "~/types/supabase";
import Select from "~/components/form/select";
import { toast } from "sonner";
import InputNumber from "~/components/form/input-number";
import SelectStudyProgram from "~/components/form/select-study-program";

const currentYear = new Date().getFullYear();

const formSchema = z.object({
  study_program_code: z.string(),
  semester: z.number().min(1).max(8),
  class_group: z.string(),
  session_type: z.enum(["Pagi", "Malam"]),
  admission_year: z.number().min(1900).max(currentYear),
});
const ClassAddModal: React.FC<AddModalProps<"class">> = (props) => {
  const doAdd = async (values: z.infer<typeof formSchema>) => {
    return await supabase.from("class").insert({
      study_program_code: values.study_program_code,
      semester: values.semester,
      class_group: values.class_group,
      session_type: values.session_type,
      admission_year: values.admission_year,
    });
  };

  const doEdit = async (values: z.infer<typeof formSchema>) => {
    return await supabase
      .from("class")
      .update({
        study_program_code: values.study_program_code,
        semester: values.semester,
        class_group: values.class_group,
        session_type: values.session_type,
        admission_year: values.admission_year,
      })
      .eq("id", props.data!.id);
  };
  return (
    <BaseAddModal {...props} title="Kelas" formSchema={formSchema} doAdd={doAdd} doEdit={doEdit}>
      {(form) => (
        <React.Fragment>
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
            name="class_group"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Grup Kelas</FormLabel>
                <FormControl>
                  <Input placeholder="A/B/C/..." {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="session_type"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Jenis Sesi</FormLabel>
                <FormControl>
                  <Select
                    options={[
                      {
                        label: "Pagi",
                        value: "Pagi",
                      },
                      {
                        label: "Malam",
                        value: "Malam",
                      },
                    ]}
                    {...field}
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="admission_year"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Tahun Masuk</FormLabel>
                <FormControl>
                  <InputNumber
                    placeholder={currentYear.toString()}
                    min={1900}
                    max={currentYear}
                    {...field}
                  />
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
export default ClassAddModal;
