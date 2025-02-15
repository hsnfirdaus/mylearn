import { useEffect, useState, useTransition } from "react";
import Select, { type BaseSelect, type SelectOption } from "./select";
import { useDebounce } from "use-debounce";

interface Props extends BaseSelect {
  placeholder?: string;
  onSearch?: (query: string) => Promise<SelectOption[] | undefined> | undefined;
  getSingleLabel?: (value: string) => Promise<string | undefined | null>;
}
const SelectAsync: React.FC<Props> = ({
  placeholder,
  value,
  onChange,
  onSearch,
  getSingleLabel,
}) => {
  const [options, setOptions] = useState<SelectOption[]>([]);
  const [isLoading, startLoading] = useTransition();
  const [search, setSearch] = useState<undefined | string>("");

  const [debouncedSearch] = useDebounce(search, 300);

  useEffect(() => {
    if (!debouncedSearch) return;
    startLoading(async () => {
      const selected = options.find((item) => item.value === value);

      const res = await onSearch?.(debouncedSearch);
      if (res !== undefined) {
        const newVal = res.filter((item) => item.value !== selected?.value);
        if (selected) {
          newVal.unshift(selected);
        }
        setOptions(newVal);
      }
    });
  }, [debouncedSearch]);

  useEffect(() => {
    (async () => {
      if (value) {
        const find = options.find((item) => item.value === value);
        if (!find) {
          const label = await getSingleLabel?.(value);
          if (label) {
            setOptions((prev) => [
              {
                label,
                value,
              },
              ...prev.filter((item) => item.value !== value),
            ]);
          }
        }
      }
    })();
  }, [value, options]);

  return (
    <Select
      placeholder={placeholder}
      isLoading={isLoading}
      options={options}
      value={value}
      onChange={onChange}
      onSearchValueChange={setSearch}
    />
  );
};
export default SelectAsync;
