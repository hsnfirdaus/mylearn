import { type RouteConfig, index, layout, route } from "@react-router/dev/routes";

export default [
  layout("guard/private-route.tsx", [
    layout("components/layout/wrapper.tsx", [
      route("/dashboard", "routes/home.tsx"),
      route("/master-data/major", "routes/master-data/major/index.tsx"),
      route("/master-data/study-program", "routes/master-data/study-program/index.tsx"),
      route("/master-data/class", "routes/master-data/class/index.tsx"),
      route("/master-data/lecturer", "routes/master-data/lecturer/index.tsx"),
      route("/master-data/room", "routes/master-data/room/index.tsx"),

      route("/academic/subject", "routes/academic/subject/index.tsx"),
      route("/academic/semester", "routes/academic/semester/index.tsx"),
      route("/academic/schedule", "routes/academic/schedule/index.tsx"),
    ]),
  ]),
  layout("guard/public-route.tsx", [route("/auth/login", "routes/auth/login.tsx")]),
  index("guard/route-redirector.tsx"),
] satisfies RouteConfig;
