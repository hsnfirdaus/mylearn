import { z } from "zod";
import {
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "~/components/ui/form";
import { Input } from "~/components/ui/input";
import React from "react";
import type { AddModalProps } from "~/components/base-add-modal";
import BaseAddModal from "~/components/base-add-modal";
import supabase from "~/lib/supabase";
import DatePicker from "~/components/form/date-picker";
import { Switch } from "~/components/ui/switch";

const formSchema = z.object({
  name: z.string(),
  start_date: z.string(),
  end_date: z.string(),
  is_active: z.boolean().optional(),
});
const SemesterAddModal: React.FC<AddModalProps<"semester">> = (props) => {
  const doAdd = async (values: z.infer<typeof formSchema>) => {
    return await supabase.from("semester").insert({
      name: values.name,
      start_date: values.start_date,
      end_date: values.end_date,
      is_active: values.is_active === true,
    });
  };

  const doEdit = async (values: z.infer<typeof formSchema>) => {
    return await supabase
      .from("semester")
      .update({
        name: values.name,
        start_date: values.start_date,
        end_date: values.end_date,
        is_active: values.is_active === true,
      })
      .eq("id", props.data!.id);
  };
  return (
    <BaseAddModal
      {...props}
      title="Semester"
      formSchema={formSchema}
      doAdd={doAdd}
      doEdit={doEdit}
      defaultValues={{ is_active: false }}
    >
      {(form) => (
        <React.Fragment>
          <FormField
            control={form.control}
            name="name"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Nama Semester</FormLabel>
                <FormControl>
                  <Input placeholder="Ganjil 2024/2025" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="start_date"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Tanggal Mulai</FormLabel>
                <FormControl>
                  <DatePicker {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="end_date"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Tanggal Selesai</FormLabel>
                <FormControl>
                  <DatePicker {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="is_active"
            render={({ field }) => (
              <FormItem className="flex flex-row items-center justify-between rounded-lg border p-3 shadow-sm">
                <div className="space-y-0.5">
                  <FormLabel>Semester Aktif</FormLabel>
                  <FormDescription>Atur Sebagai Semester Aktif</FormDescription>
                </div>
                <FormControl>
                  <Switch checked={field.value} onCheckedChange={field.onChange} />
                </FormControl>
              </FormItem>
            )}
          />
        </React.Fragment>
      )}
    </BaseAddModal>
  );
};
export default SemesterAddModal;
