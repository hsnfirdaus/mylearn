String countDown(String dateString) {
  final targetDate = DateTime.parse(dateString);
  final now = DateTime.now();
  final difference = targetDate.difference(now);

  String countdownText;
  if (difference.isNegative) {
    countdownText = "Terlambat";
  } else if (difference.inDays > 7) {
    countdownText = "${(difference.inDays / 7).floor()} Minggu";
  } else if (difference.inDays > 0) {
    countdownText = "${difference.inDays} Hari";
  } else if (difference.inHours > 0) {
    countdownText = "${difference.inHours} Jam";
  } else if (difference.inMinutes > 0) {
    countdownText = "${difference.inMinutes} Menit";
  } else {
    countdownText = "Sekarang";
  }

  return countdownText;
}
