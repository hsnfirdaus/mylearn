import { LoadingSpinner } from "./loading-spinner";

interface Props {
  text?: string;
}
const FullLoading: React.FC<Props> = ({ text }) => {
  return (
    <div className="fixed inset-0 flex items-center justify-center">
      <div className="flex flex-row items-center justify-center gap-2 text-center">
        <img className="h-12" src="/favicon.svg" />
        <LoadingSpinner />
        <span className="text-muted-foreground">{text}</span>
      </div>
    </div>
  );
};
export default FullLoading;
