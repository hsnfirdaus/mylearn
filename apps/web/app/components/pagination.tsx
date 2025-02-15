import { Link, useSearchParams } from "react-router";
import { Button } from "./ui/button";
import { LIMIT } from "~/lib/supabase";
import React, { useMemo } from "react";

interface Props {
  count: number;
  limit?: number;
}
const Pagination: React.FC<Props> = ({ count, limit = LIMIT }) => {
  const [searchParams] = useSearchParams();

  const currentPage = useMemo(() => {
    const qsPage = searchParams.get("page");
    if (qsPage) {
      const parsedPage = parseInt(qsPage);
      if (!isNaN(parsedPage) && parsedPage > 0) {
        return parsedPage;
      }
    }

    return 1;
  }, [searchParams]);

  const totalPage = useMemo(() => {
    return Math.ceil(count / limit);
  }, [count, limit]);

  const getLink = (page: number) => {
    const newSp = new URLSearchParams([...searchParams]);
    newSp.set("page", page.toString());

    return "?" + newSp.toString();
  };

  return (
    <div className="flex items-center justify-center space-x-2 my-4">
      <div className="space-x-2">
        <ButtonOrLink isDisabled={currentPage === 1} to={getLink(currentPage - 1)}>
          Previous
        </ButtonOrLink>
        <Button variant="default" disabled className="disabled:opacity-100">
          {currentPage}
        </Button>
        <ButtonOrLink isDisabled={currentPage >= totalPage} to={getLink(currentPage + 1)}>
          Next
        </ButtonOrLink>
      </div>
    </div>
  );
};

interface ButtonOrLinkProps {
  to?: string;
  children?: React.ReactNode;
  isDisabled?: boolean;
}
const ButtonOrLink: React.FC<ButtonOrLinkProps> = ({ to, children, isDisabled }) => {
  if (isDisabled || !to) {
    return (
      <Button variant="outline" disabled>
        {children}
      </Button>
    );
  }

  return (
    <Button variant="outline" asChild>
      <Link to={to}>{children}</Link>
    </Button>
  );
};
export default Pagination;
