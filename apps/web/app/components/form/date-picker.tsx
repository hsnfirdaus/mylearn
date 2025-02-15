import type React from "react";
import { Popover, PopoverContent, PopoverTrigger } from "../ui/popover";
import { Button } from "../ui/button";
import { cn } from "~/lib/utils";
import { CalendarIcon } from "lucide-react";
import { Calendar } from "../ui/calendar";
import { useMemo } from "react";
import { format } from "date-fns";

interface Props {
  value?: string;
  onChange?: (value?: string) => void;
}
const DatePicker: React.FC<Props> = ({ value, onChange }) => {
  const dateValue = useMemo(() => {
    if (value) {
      return new Date(value);
    }
    return undefined;
  }, [value]);

  const dateChange = (value?: Date) => {
    if (value) {
      onChange?.(value.toISOString());
    } else {
      onChange?.(undefined);
    }
  };

  return (
    <Popover>
      <PopoverTrigger asChild>
        <Button
          variant={"outline"}
          className={cn(
            "w-full justify-start text-left font-normal",
            !value && "text-muted-foreground",
          )}
        >
          <CalendarIcon className="mr-2 h-4 w-4" />
          {dateValue ? format(dateValue, "PP") : <span>Pilih Tanggal</span>}
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-auto p-0">
        <Calendar mode="single" selected={dateValue} onSelect={dateChange} initialFocus />
      </PopoverContent>
    </Popover>
  );
};
export default DatePicker;
