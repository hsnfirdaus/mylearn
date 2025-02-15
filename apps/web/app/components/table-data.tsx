import React, { useMemo, useCallback, type Key } from "react";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "./ui/table";
import Pagination from "./pagination";

interface ColItem<D, K extends keyof D> {
  title: string;
  key: K | string[];
  renderItem?: (value: D[K], item: D) => React.ReactNode;
  headClassName?: string;
  colClassName?: string;
}
export interface TableDataProps<D, K extends keyof D = keyof D> {
  data: D[];
  columns: ColItem<D, K>[];
  rowKey: K;
  total: number;
}

export default function TableData<D>({ data, columns, total, rowKey }: TableDataProps<D>) {
  const HeaderRow = useMemo(
    () => (
      <TableRow>
        {columns.map((item, idx) => (
          <TableHead key={idx} className={item.headClassName}>
            {item.title}
          </TableHead>
        ))}
      </TableRow>
    ),
    [columns],
  );

  const renderRow = useCallback(
    (item: D) => (
      <TableRow key={item[rowKey] as Key}>
        {columns.map((col, idx) => {
          let value: any;
          if (col.key instanceof Array) {
            value = col.key.reduce((obj, curr) => (obj as any)?.[curr], item);
          } else {
            value = item[col.key];
          }
          const renderedItem = col.renderItem
            ? col.renderItem(value, item)
            : value !== undefined && value !== null
              ? value
              : "-";
          return (
            <TableCell key={idx} className={col.colClassName}>
              {renderedItem as React.ReactNode}
            </TableCell>
          );
        })}
      </TableRow>
    ),
    [columns, rowKey],
  );

  const renderedData = useMemo(
    () =>
      data.length === 0 ? (
        <TableRow>
          <TableCell colSpan={columns.length} className="text-center">
            No Data
          </TableCell>
        </TableRow>
      ) : (
        <React.Fragment>{data.map(renderRow)}</React.Fragment>
      ),
    [data, columns.length, renderRow],
  );

  return (
    <React.Fragment>
      <div className="rounded-md border my-4">
        <Table>
          <TableHeader>{HeaderRow}</TableHeader>
          <TableBody>{renderedData}</TableBody>
        </Table>
      </div>
      <Pagination count={total} />
    </React.Fragment>
  );
}
