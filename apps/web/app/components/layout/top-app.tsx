import { Link } from "react-router";
import { SidebarMenu, SidebarMenuButton, SidebarMenuItem } from "~/components/ui/sidebar";

export function TopApp() {
  return (
    <SidebarMenu>
      <SidebarMenuItem>
        <SidebarMenuButton size="lg" asChild>
          <Link to={`/`}>
            <div className="flex aspect-square size-8 items-center justify-center">
              <img src="/favicon.svg" className="size-8" />
            </div>
            <div className="grid flex-1 text-left text-sm leading-tight">
              <span className="truncate font-semibold">{import.meta.env.VITE_APP_NAME}</span>
              <span className="truncate text-xs">Administrator</span>
            </div>
          </Link>
        </SidebarMenuButton>
      </SidebarMenuItem>
    </SidebarMenu>
  );
}
