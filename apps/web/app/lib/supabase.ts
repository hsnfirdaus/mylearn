import { createClient } from "@supabase/supabase-js";
import type { Database } from "~/types/supabase";

const supabase = createClient<Database>(
  import.meta.env.VITE_SUPABASE_URL,
  import.meta.env.VITE_SUPABASE_ANON,
);

export const LIMIT = 20;

export const getRange = (page: number): [number, number] => {
  const from = (page - 1) * LIMIT;
  const to = from + LIMIT - 1;

  return [from, to];
};

export default supabase;
