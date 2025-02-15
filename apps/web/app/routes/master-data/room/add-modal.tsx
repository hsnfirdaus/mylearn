import { z } from "zod";
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from "~/components/ui/form";
import { Input } from "~/components/ui/input";
import React from "react";
import type { AddModalProps } from "~/components/base-add-modal";
import BaseAddModal from "~/components/base-add-modal";
import supabase from "~/lib/supabase";

const formSchema = z.object({
  code: z.string(),
});
const RoomAddModal: React.FC<AddModalProps<"room">> = (props) => {
  const doAdd = async (values: z.infer<typeof formSchema>) => {
    return await supabase.from("room").insert({
      code: values.code,
    });
  };

  const doEdit = async (values: z.infer<typeof formSchema>) => {
    return await supabase
      .from("room")
      .update({
        code: values.code,
      })
      .eq("code", props.data!.code);
  };
  return (
    <BaseAddModal {...props} title="Ruangan" formSchema={formSchema} doAdd={doAdd} doEdit={doEdit}>
      {(form) => (
        <React.Fragment>
          <FormField
            control={form.control}
            name="code"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Kode Ruangan</FormLabel>
                <FormControl>
                  <Input placeholder="TA 12.4" {...field} />
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
export default RoomAddModal;
