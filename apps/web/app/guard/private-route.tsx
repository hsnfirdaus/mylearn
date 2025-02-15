import { use } from "react";
import { Navigate, Outlet } from "react-router";
import AuthContext, { EAuthStatus } from "~/context/auth-context";

const PrivateRoute: React.FC = () => {
  const {
    auth: { status },
  } = use(AuthContext);

  if (status !== EAuthStatus.LOGIN) {
    return <Navigate to={`/auth/login`} replace={true} />;
  }

  return <Outlet />;
};
export default PrivateRoute;
