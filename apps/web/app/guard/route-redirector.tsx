import { use } from "react";
import { Navigate } from "react-router";
import AuthContext, { EAuthStatus } from "~/context/auth-context";

const RouteRedirector: React.FC = () => {
  const {
    auth: { status },
  } = use(AuthContext);

  return (
    <Navigate replace={true} to={status === EAuthStatus.NOT_LOGIN ? "/auth/login" : "/dashboard"} />
  );
};
export default RouteRedirector;
