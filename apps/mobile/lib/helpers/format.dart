String taskStatus(String? status) {
  switch (status) {
    case "submitted":
      return "Dikerjakan";

    case "not_submitted":
      return "Belum Dikumpulkan";

    case "pending":
      return "Belum Dikerjakan";

    default:
      return "Tidak Tau";
  }
}
