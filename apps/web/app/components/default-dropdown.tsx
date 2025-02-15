import { EditIcon, MoreHorizontal, TrashIcon } from "lucide-react";
import { Button } from "./ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuTrigger,
} from "./ui/dropdown-menu";

interface Props {
  onEdit?: () => void;
  onDelete?: () => void;
}
const DefaultDropdown: React.FC<Props> = ({ onEdit, onDelete }) => {
  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" className="h-8 w-8 p-0">
          <span className="sr-only">Open menu</span>
          <MoreHorizontal />
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end">
        <DropdownMenuLabel>Aksi</DropdownMenuLabel>
        <DropdownMenuItem onClick={onEdit}>
          <EditIcon />
          <span>Edit</span>
        </DropdownMenuItem>
        <DropdownMenuItem
          className="hover:!bg-destructive hover:!text-destructive-foreground"
          onClick={onDelete}
        >
          <TrashIcon />
          <span>Hapus</span>
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
};
export default DefaultDropdown;
