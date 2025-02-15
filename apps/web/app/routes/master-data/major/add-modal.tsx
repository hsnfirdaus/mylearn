import { z } from "zod";
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from "~/components/ui/form";
import { Input } from "~/components/ui/input";
import React from "react";
import type { AddModalProps } from "~/components/base-add-modal";
import BaseAddModal from "~/components/base-add-modal";
import supabase from "~/lib/supabase";

const formSchema = z.object({
  code: z.string(),
  name: z.string(),
});
const MajorAddModal: React.FC<AddModalProps<"major">> = (props) => {
  const doAdd = async (values: z.infer<typeof formSchema>) => {
    return await supabase.from("major").insert({
      code: values.code,
      name: values.name,
    });
  };

  const doEdit = async (values: z.infer<typeof formSchema>) => {
    return await supabase
      .from("major")
      .update({
        code: values.code,
        name: values.name,
      })
      .eq("code", props.data!.code);
  };
  return (
    <BaseAddModal {...props} title="Jurusan" formSchema={formSchema} doAdd={doAdd} doEdit={doEdit}>
      {(form) => (
        <React.Fragment>
          <FormField
            control={form.control}
            name="code"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Kode Jurusan</FormLabel>
                <FormControl>
                  <Input placeholder="IF" {...field} />
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
                <FormLabel>Name Jurusan</FormLabel>
                <FormControl>
                  <Input placeholder="Teknik Informatika" {...field} />
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
export default MajorAddModal;
