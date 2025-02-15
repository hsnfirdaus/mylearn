import { use } from "react";
import { Navigate, Outlet } from "react-router";
import AuthContext, { EAuthStatus } from "~/context/auth-context";

const PublicRoute: React.FC = () => {
  const {
    auth: { status },
  } = use(AuthContext);

  if (status !== EAuthStatus.NOT_LOGIN) {
    return <Navigate to={`/dashboard`} replace={true} />;
  }

  return <Outlet />;
};
export default PublicRoute;
