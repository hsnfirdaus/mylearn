import { useEffect, useState } from "react";
import AuthContext, { EAuthStatus, type AuthProperties } from "./auth-context";
import supabase from "~/lib/supabase";
import FullLoading from "~/components/full-loading";
import type { Session } from "@supabase/supabase-js";
import { jwtDecode } from "jwt-decode";
import type { CustomJWT } from "~/types/jwt.type";

interface Props {
  children?: React.ReactNode;
}
const AuthProvider: React.FC<Props> = ({ children }) => {
  const [isLoading, setIsLoading] = useState(true);
  const [auth, setAuth] = useState<AuthProperties>({
    status: EAuthStatus.NOT_LOGIN,
  });

  const handleSession = async (session: Session | null) => {
    if (session) {
      const jwt = jwtDecode<CustomJWT>(session.access_token);
      if (jwt.user_roles && jwt.user_roles.includes("admin")) {
        const {
          data: { user },
        } = await supabase.auth.getUser();

        setAuth({
          status: EAuthStatus.LOGIN,
          user: user ?? undefined,
        });
      } else {
        await supabase.auth.signOut();
      }
    } else {
      setAuth({
        status: EAuthStatus.NOT_LOGIN,
      });
    }
  };

  useEffect(() => {
    (async () => {
      setIsLoading(true);
      const {
        data: { session },
      } = await supabase.auth.getSession();
      await handleSession(session);
      setIsLoading(false);
    })();

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      handleSession(session);
    });

    return () => subscription.unsubscribe();
  }, []);

  if (isLoading) {
    return <FullLoading />;
  } else {
    return (
      <AuthContext
        value={{
          auth,
          setAuth,
        }}
      >
        {children}
      </AuthContext>
    );
  }
};
export default AuthProvider;
