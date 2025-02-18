import { z } from "zod";
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from "~/components/ui/form";
import { Input } from "~/components/ui/input";
import React from "react";
import type { AddModalProps } from "~/components/base-add-modal";
import BaseAddModal from "~/components/base-add-modal";
import supabase from "~/lib/supabase";
import SelectMajor from "~/components/form/select-major";

const formSchema = z.object({
  nik: z.string(),
  code: z.string().optional(),
  name: z.string(),
  email: z.string().email().optional(),
  phone_number: z.string().optional(),
  photo_url: z.string().url().optional(),
  major_code: z.string(),
});
const LecturerAddModal: React.FC<AddModalProps<"lecturer">> = (props) => {
  const doAdd = async (values: z.infer<typeof formSchema>) => {
    return await supabase.from("lecturer").insert({
      nik: values.nik,
      code: values.code,
      name: values.name,
      email: values.email,
      phone_number: values.phone_number,
      photo_url: values.photo_url,
      major_code: values.major_code,
    });
  };

  const doEdit = async (values: z.infer<typeof formSchema>) => {
    return await supabase
      .from("lecturer")
      .update({
        nik: values.nik,
        code: values.code,
        name: values.name,
        email: values.email,
        phone_number: values.phone_number,
        photo_url: values.photo_url,
        major_code: values.major_code,
      })
      .eq("nik", props.data!.nik);
  };
  return (
    <BaseAddModal {...props} title="Dosen" formSchema={formSchema} doAdd={doAdd} doEdit={doEdit}>
      {(form) => (
        <React.Fragment>
          <FormField
            control={form.control}
            name="nik"
            render={({ field }) => (
              <FormItem>
                <FormLabel>NIK</FormLabel>
                <FormControl>
                  <Input placeholder="34xxxx" {...field} />
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
                <FormLabel>Kode Dosen</FormLabel>
                <FormControl>
                  <Input placeholder="SP/AM/..." {...field} />
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
                <FormLabel>Nama Lengkap</FormLabel>
                <FormControl>
                  <Input placeholder="John Doe, M.Eng." {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="email"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Email</FormLabel>
                <FormControl>
                  <Input placeholder="john@polibatam.ac.id" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="phone_number"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Nomor Telepon</FormLabel>
                <FormControl>
                  <Input placeholder="08xxxxxxxxxxx" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="photo_url"
            render={({ field }) => (
              <FormItem>
                <FormLabel>URL Foto</FormLabel>
                <FormControl>
                  <Input placeholder="https://....." {...field} />
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
export default LecturerAddModal;
