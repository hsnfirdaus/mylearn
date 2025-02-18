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
import { Switch } from "~/components/ui/switch";
import SelectClass from "~/components/form/select-class";
import SelectSubject from "~/components/form/select-subject";
import SelectLecturer from "~/components/form/select-lecturer";
import SelectSemester from "~/components/form/select-semester";
import Select from "~/components/form/select";
import SelectRoom from "~/components/form/select-room";

const formSchema = z.object({
  subject_id: z.string(),
  class_id: z.string(),
  lecturer_nik: z.string(),
  is_theory: z.boolean(),
  is_practice: z.boolean(),
  semester_id: z.string(),
  day_of_week: z.number(),
  start_time: z.string(),
  end_time: z.string(),
  room_code: z.string().nullable().optional(),
  zoom_link: z.string().optional(),
});
const ScheduleAddModal: React.FC<AddModalProps<"schedule">> = (props) => {
  const doAdd = async (values: z.infer<typeof formSchema>) => {
    return await supabase.from("schedule").insert({
      subject_id: values.subject_id,
      class_id: values.class_id,
      lecturer_nik: values.lecturer_nik,
      is_theory: values.is_theory,
      is_practice: values.is_practice,
      semester_id: values.semester_id,
      day_of_week: values.day_of_week,
      start_time: values.start_time,
      end_time: values.end_time,
      room_code: values.room_code,
      zoom_link: values.zoom_link,
    });
  };

  const doEdit = async (values: z.infer<typeof formSchema>) => {
    return await supabase
      .from("schedule")
      .update({
        subject_id: values.subject_id,
        class_id: values.class_id,
        lecturer_nik: values.lecturer_nik,
        is_theory: values.is_theory,
        is_practice: values.is_practice,
        semester_id: values.semester_id,
        day_of_week: values.day_of_week,
        start_time: values.start_time,
        end_time: values.end_time,
        room_code: values.room_code,
        zoom_link: values.zoom_link,
      })
      .eq("id", props.data!.id);
  };

  return (
    <BaseAddModal
      defaultValues={{
        is_practice: false,
        is_theory: false,
      }}
      {...props}
      title="Semester"
      formSchema={formSchema}
      doAdd={doAdd}
      doEdit={doEdit}
    >
      {(form) => (
        <React.Fragment>
          <FormField
            control={form.control}
            name="class_id"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Kelas</FormLabel>
                <FormControl>
                  <SelectClass {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="subject_id"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Mata Kuliah</FormLabel>
                <FormControl>
                  <SelectSubject {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="lecturer_nik"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Dosen</FormLabel>
                <FormControl>
                  <SelectLecturer {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="is_theory"
            render={({ field }) => (
              <FormItem className="flex flex-row items-center justify-between rounded-lg border p-3 shadow-sm">
                <div className="space-y-0.5">
                  <FormLabel>Sesi Teori</FormLabel>
                  <FormDescription>Atur Sebagai Sesi Teori</FormDescription>
                </div>
                <FormControl>
                  <Switch checked={field.value} onCheckedChange={field.onChange} />
                </FormControl>
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="is_practice"
            render={({ field }) => (
              <FormItem className="flex flex-row items-center justify-between rounded-lg border p-3 shadow-sm">
                <div className="space-y-0.5">
                  <FormLabel>Sesi Praktikum</FormLabel>
                  <FormDescription>Atur Sebagai Sesi Praktikum</FormDescription>
                </div>
                <FormControl>
                  <Switch checked={field.value} onCheckedChange={field.onChange} />
                </FormControl>
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="semester_id"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Semester</FormLabel>
                <FormControl>
                  <SelectSemester {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="day_of_week"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Hari</FormLabel>
                <FormControl>
                  <Select
                    options={[
                      {
                        value: 1,
                        label: "Senin",
                      },
                      {
                        value: 2,
                        label: "Selasa",
                      },
                      {
                        value: 3,
                        label: "Rabu",
                      },
                      {
                        value: 4,
                        label: "Kamis",
                      },
                      {
                        value: 5,
                        label: "Jum'at",
                      },
                      {
                        value: 6,
                        label: "Sabtu",
                      },
                      {
                        value: 7,
                        label: "Minggu",
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
            name="start_time"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Waktu Mulai</FormLabel>
                <FormControl>
                  <Input placeholder="08:45" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="end_time"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Waktu Selesai</FormLabel>
                <FormControl>
                  <Input placeholder="11:00" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="room_code"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Ruangan</FormLabel>
                <FormControl>
                  <SelectRoom isAllowUnselect={true} {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="zoom_link"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Link Zoom</FormLabel>
                <FormControl>
                  <Input placeholder="https://" {...field} />
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
export default ScheduleAddModal;
