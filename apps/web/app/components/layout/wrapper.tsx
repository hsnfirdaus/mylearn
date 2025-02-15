import { SidebarInset, SidebarProvider, SidebarTrigger } from "~/components/ui/sidebar";
import { Separator } from "~/components/ui/separator";
import { AppSidebar } from "./app-sidebar";
import { Outlet } from "react-router";

export default function Wrapper() {
  return (
    <SidebarProvider>
      <AppSidebar />
      <SidebarInset>
        <header className="flex h-16 shrink-0 items-center gap-2 transition-[width,height] ease-linear group-has-[[data-collapsible=icon]]/sidebar-wrapper:h-12 border-b">
          <div className="flex items-center gap-2 px-4">
            <SidebarTrigger className="-ml-1" />
            <Separator orientation="vertical" className="mr-2 !h-4" />
            <span className="font-bold text-sm">MyLearn CMS</span>
          </div>
        </header>
        <main className="p-4 container mx-auto">
          <Outlet />
        </main>
      </SidebarInset>
    </SidebarProvider>
  );
}
