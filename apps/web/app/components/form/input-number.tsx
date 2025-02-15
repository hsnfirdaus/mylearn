import { useMemo } from "react";
import { Input } from "../ui/input";

type Props = Omit<React.ComponentProps<"input">, "type" | "onChange" | "value"> & {
  value?: number;
  onChange?: (value?: number) => void;
};

const InputNumber: React.FC<Props> = ({ onChange, value, ...rest }) => {
  const stringVal = useMemo(() => {
    return value ? value.toString() : undefined;
  }, [value]);

  const stringOnChange = (value?: string) => {
    if (value === undefined || value.trim() === "") {
      onChange?.(undefined);
    } else {
      const parsed = parseInt(value);
      if (isNaN(parsed)) {
        onChange?.(undefined);
      } else {
        onChange?.(parsed);
      }
    }
  };
  return (
    <Input
      type="number"
      value={stringVal}
      onChange={(e) => stringOnChange(e.target.value)}
      {...rest}
    />
  );
};
export default InputNumber;
