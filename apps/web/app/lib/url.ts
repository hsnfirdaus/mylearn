import type { BaseQS } from "~/types/url.type";

export const parseSearchParams = <T extends BaseQS>(request: Request) => {
  const url = new URL(request.url);
  const searchParams = Object.fromEntries(url.searchParams.entries());
  return searchParams as unknown as T;
};
