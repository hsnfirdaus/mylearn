import supabase from "~/lib/supabase";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "./ui/alert-dialog";
import type { Database, Tables } from "~/types/supabase";
import { toast } from "sonner";
import { useEffect, useState } from "react";

interface Props<
  T extends keyof Database["public"]["Tables"],
  C extends keyof Database["public"]["Tables"][T]["Row"],
> {
  title: string;
  table: T;
  colKey: C;
  colVal?: Database["public"]["Tables"][T]["Row"][C];
  label?: string;
  onSuccess?: () => void;
  onCancel?: () => void;
}
export default function DeleteDialog<
  T extends keyof Database["public"]["Tables"],
  C extends keyof Database["public"]["Tables"][T]["Row"],
>({ title, table, colKey, colVal, label, onSuccess, onCancel }: Props<T, C>) {
  const [memorizedLabel, setMemorizedLabel] = useState(label);

  useEffect(() => {
    if (label) {
      setMemorizedLabel(label);
    }
  }, [label]);

  const doDelete = async () => {
    const { error } = await supabase
      .from(table)
      .delete()
      .eq(colKey as any, colVal as any);
    if (error) {
      toast.error(error.name, {
        description: error.message,
      });
    } else {
      toast.success("Berhasil!", {
        description: title + " " + memorizedLabel + " berhasil dihapus!",
      });
      onSuccess?.();
    }
  };

  return (
    <AlertDialog open={colVal !== undefined} onOpenChange={onCancel}>
      <AlertDialogContent>
        <AlertDialogHeader>
          <AlertDialogTitle>Apakah anda yakin?</AlertDialogTitle>
          <AlertDialogDescription>
            Aksi ini tidak akan dapat dibatalkan. Anda akan menghapus {title} {memorizedLabel}{" "}
            beserta seluruh relasinya!
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogCancel>Batal</AlertDialogCancel>
          <AlertDialogAction
            className="bg-destructive text-destructive-foreground hover:bg-destructive/80 hover:text-destructive-foreground"
            onClick={doDelete}
          >
            Hapus
          </AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  );
}
