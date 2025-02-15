import type { JwtPayload } from "jwt-decode";
import type { Enums } from "./supabase";

export interface CustomJWT extends JwtPayload {
  user_roles: Enums<"app_role">[] | null;
}
