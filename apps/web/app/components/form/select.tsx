import { useEffect, useState } from "react";
import { Popover, PopoverContent, PopoverTrigger } from "../ui/popover";
import { Button } from "../ui/button";
import { Check, ChevronsUpDown, Loader2Icon } from "lucide-react";
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from "../ui/command";
import { cn } from "~/lib/utils";

type ValidKey = string | number;
export interface SelectOption<T extends ValidKey = string> {
  label: string;
  value: T;
}

export interface BaseSelect<T extends ValidKey = string> {
  value?: T;
  onChange?: (v?: T) => void;
}

interface Props<T extends ValidKey = string> extends BaseSelect<T> {
  placeholder?: string;
  options?: SelectOption<T>[];
  isLoading?: boolean;
  searchValue?: string;
  onSearchValueChange?: (value?: string) => void;
}
export default function Select<T extends ValidKey = string>({
  placeholder,
  value,
  onChange,
  options,
  isLoading,
  searchValue,
  onSearchValueChange,
}: Props<T>) {
  const [open, setOpen] = useState(false);
  const [currentLabel, setCurrentLabel] = useState<string>();

  useEffect(() => {
    if (value === undefined || value === null) {
      setCurrentLabel(undefined);
    } else {
      const find = options?.find((item) => item.value === value);
      if (find) {
        setCurrentLabel(find.label);
      }
    }
  }, [value, options]);

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          variant="outline"
          role="combobox"
          aria-expanded={open}
          className="w-full justify-between"
        >
          <span className="flex-1 text-left min-w-0 truncate">
            {value ? (currentLabel ?? value) : (placeholder ?? "Pilih Opsi...")}
          </span>
          <span className="ml-2 shrink-0 opacity-50">
            {isLoading ? (
              <Loader2Icon className="h-4 w-4 animate-spin" />
            ) : (
              <ChevronsUpDown className="h-4 w-4" />
            )}
          </span>
        </Button>
      </PopoverTrigger>
      <PopoverContent className="p-0 popover-content-width-full">
        <Command>
          <CommandInput
            value={searchValue}
            onValueChange={onSearchValueChange}
            placeholder="Cari opsi..."
          />
          <CommandList>
            <CommandEmpty>{isLoading ? "Silahkan Tunggu..." : "Tidak ada opsi."}</CommandEmpty>
            <CommandGroup>
              {options?.map((item) => (
                <CommandItem
                  key={item.value}
                  value={item.label}
                  onSelect={() => {
                    onChange?.(item.value);
                    setOpen(false);
                  }}
                >
                  <Check
                    className={cn(
                      "mr-2 h-4 w-4",
                      value === item.value ? "opacity-100" : "opacity-0",
                    )}
                  />
                  {item.label}
                </CommandItem>
              ))}
            </CommandGroup>
          </CommandList>
        </Command>
      </PopoverContent>
    </Popover>
  );
}
