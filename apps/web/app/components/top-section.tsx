import { PlusIcon } from "lucide-react";
import { Button } from "./ui/button";

interface Props {
  title: string;
  onAdd: () => void;
}
const TopSection: React.FC<Props> = ({ title, onAdd }) => {
  return (
    <div className="flex justify-between my-4">
      <h1 className="font-bold text-2xl">{title}</h1>
      <Button onClick={onAdd}>
        <PlusIcon /> Tambah
      </Button>
    </div>
  );
};
export default TopSection;
