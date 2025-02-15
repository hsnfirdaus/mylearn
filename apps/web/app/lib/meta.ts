export const t = (title: string) => {
  return title + " - " + import.meta.env.VITE_APP_NAME;
};
