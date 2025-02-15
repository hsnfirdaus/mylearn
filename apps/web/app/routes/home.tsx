import { t } from "~/lib/meta";
import type { Route } from "./+types/home";
import { use } from "react";
import AuthContext from "~/context/auth-context";

export function meta({}: Route.MetaArgs) {
  return [{ title: t("Dashboard") }];
}

export default function Home() {
  const {
    auth: { user },
  } = use(AuthContext);
  return <h1 className="text-2xl font-bold">Hello, {user?.user_metadata?.full_name}!</h1>;
}
