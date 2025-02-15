import type { TableDataProps } from "~/components/table-data";

type ClientLoader = (...args: any) => Promise<{
  data: unknown[];
  total: number;
}>;

export type ClientLoaderTableCol<T extends ClientLoader> = TableDataProps<
  Awaited<ReturnType<T>>["data"][0]
>["columns"][0];
