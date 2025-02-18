import { Dialog, DialogContent, DialogHeader, DialogTitle } from "~/components/ui/dialog";
import { z } from "zod";
import { useForm, type DefaultValues, type UseFormReturn } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { Form } from "~/components/ui/form";
import { Button } from "~/components/ui/button";
import { toast } from "sonner";
import type { Database, Tables } from "~/types/supabase";
import React, { useEffect, useMemo } from "react";
import type { PostgrestSingleResponse } from "@supabase/supabase-js";

export type AddModalProps<T extends keyof Database["public"]["Tables"]> = {
  open?: boolean;
  onClose?: () => void;
  onSuccess?: () => void;
  data?: Tables<T>;
  isEdit?: boolean;
};

type Props<
  T extends keyof Database["public"]["Tables"],
  FS extends z.ZodObject<any, any, any>,
> = AddModalProps<T> & {
  title: string;
  formSchema: FS;
  doAdd?: (values: z.TypeOf<FS>) => Promise<PostgrestSingleResponse<null>>;
  doEdit?: (values: z.TypeOf<FS>) => Promise<PostgrestSingleResponse<null>>;
  children?: (form: UseFormReturn<z.TypeOf<FS>, any, undefined>) => React.ReactNode;
  defaultValues?: DefaultValues<z.TypeOf<FS>>;
};

export default function BaseAddModal<
  T extends keyof Database["public"]["Tables"],
  FS extends z.ZodObject<any, any, any>,
>({
  open,
  onClose,
  onSuccess,
  data,
  isEdit,
  formSchema,
  doAdd,
  doEdit,
  title,
  children,
  defaultValues,
}: Props<T, FS>) {
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues,
  });

  useEffect(() => {
    if (data) {
      var newData: { [key: string]: any } = {};
      for (const key in data) {
        if (Object.prototype.hasOwnProperty.call(data, key)) {
          const element = data[key];
          if (element === null) {
            newData[key] = undefined;
            continue;
          }
          newData[key] = element;
        }
      }
      form.reset(newData, { keepDefaultValues: true });
    }
  }, [data]);

  const onSubmit = async (values: z.infer<typeof formSchema>) => {
    var res: PostgrestSingleResponse<null>;
    if (isEdit) {
      res = await doEdit!(values);
    } else {
      res = await doAdd!(values);
    }
    const { error } = res;
    if (error) {
      toast.error(error.name, {
        description: error.message,
      });
    } else {
      toast.success("Berhasil!", {
        description: title + " " + (isEdit ? "disimpan" : "ditambahkan") + "!",
      });
      onSuccess?.();
      onClose?.();
    }
  };

  const content = useMemo(() => {
    return children?.(form);
  }, [form, children]);

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="p-0">
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <div className="max-h-[80vh] flex flex-col">
              <DialogHeader className="p-6 border-b">
                <DialogTitle>
                  {isEdit ? "Edit" : "Tambah"} {title}
                </DialogTitle>
              </DialogHeader>
              <div className="p-6 space-y-8 flex-1 overflow-y-auto">{content}</div>
              <div className="p-6 border-t">
                <Button type="submit">{isEdit ? "Simpan" : "Tambah"}</Button>
              </div>
            </div>
          </form>
        </Form>
      </DialogContent>
    </Dialog>
  );
}
