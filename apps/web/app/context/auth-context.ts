import type { User } from "@supabase/supabase-js";
import { createContext } from "react";

export enum EAuthStatus {
  NOT_LOGIN = "NOT_LOGIN",
  LOGIN = "LOGIN",
}

export interface AuthProperties {
  status: EAuthStatus;
  user?: User;
}

export interface IAuthContext {
  auth: AuthProperties;
  setAuth: React.Dispatch<React.SetStateAction<AuthProperties>>;
}

const AuthContext = createContext<IAuthContext>({
  auth: {
    status: EAuthStatus.NOT_LOGIN,
  },
  setAuth: () => {
    throw new Error("setAuth Not implemented!");
  },
});
export default AuthContext;
