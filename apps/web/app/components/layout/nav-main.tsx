import {
  AtomIcon,
  BookMarkedIcon,
  CalendarIcon,
  HomeIcon,
  MicroscopeIcon,
  OrbitIcon,
  SchoolIcon,
  TagIcon,
  UsersIcon,
} from "lucide-react";
import React, { useMemo } from "react";
import { Link, useLocation } from "react-router";
import {
  SidebarGroup,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "~/components/ui/sidebar";

const masterData = [
  {
    title: "Jurusan",
    url: "/master-data/major",
    icon: OrbitIcon,
  },
  {
    title: "Program Studi",
    url: "/master-data/study-program",
    icon: MicroscopeIcon,
  },
  {
    title: "Kelas",
    url: "/master-data/class",
    icon: AtomIcon,
  },
  {
    title: "Dosen",
    url: "/master-data/lecturer",
    icon: UsersIcon,
  },
  {
    title: "Ruangan",
    url: "/master-data/room",
    icon: SchoolIcon,
  },
];

const academic = [
  {
    title: "Mata Kuliah",
    url: "/academic/subject",
    icon: BookMarkedIcon,
  },
  {
    title: "Semester",
    url: "/academic/semester",
    icon: TagIcon,
  },
  {
    title: "Jadwal Kuliah",
    url: "/academic/schedule",
    icon: CalendarIcon,
  },
];

const NavMain: React.FC = () => {
  const location = useLocation();

  const activeMenu = useMemo(() => {
    if (location.pathname.startsWith("/dashboard")) {
      return "/dashboard";
    }
    const splitted = location.pathname.split("/").slice(0, 3);

    return splitted.join("/");
  }, [location.pathname]);

  return (
    <React.Fragment>
      <SidebarGroup>
        <SidebarMenu>
          <SidebarMenuItem>
            <SidebarMenuButton asChild isActive={activeMenu === "/dashboard"}>
              <Link to={`/dashboard`}>
                <HomeIcon />
                <span>Dashboard</span>
              </Link>
            </SidebarMenuButton>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarGroup>
      <SidebarGroup>
        <SidebarGroupLabel>Master Data</SidebarGroupLabel>
        <SidebarMenu>
          {masterData.map((item) => (
            <SidebarMenuItem key={item.url}>
              <SidebarMenuButton tooltip={item.title} asChild isActive={activeMenu === item.url}>
                <Link to={item.url}>
                  {item.icon && <item.icon />}
                  <span>{item.title}</span>
                </Link>
              </SidebarMenuButton>
            </SidebarMenuItem>
          ))}
        </SidebarMenu>
      </SidebarGroup>
      <SidebarGroup>
        <SidebarGroupLabel>Akademik</SidebarGroupLabel>
        <SidebarMenu>
          {academic.map((item) => (
            <SidebarMenuItem key={item.url}>
              <SidebarMenuButton tooltip={item.title} asChild isActive={activeMenu === item.url}>
                <Link to={item.url}>
                  {item.icon && <item.icon />}
                  <span>{item.title}</span>
                </Link>
              </SidebarMenuButton>
            </SidebarMenuItem>
          ))}
        </SidebarMenu>
      </SidebarGroup>
    </React.Fragment>
  );
};
export default NavMain;
