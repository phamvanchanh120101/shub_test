extension DateTimeFormatting on DateTime {
  String format() {
    final hours = hour.toString().padLeft(2, '0');
    final minutes = minute.toString().padLeft(2, '0');
    final seconds = second.toString().padLeft(2, '0');
    return '$day/$month/$year $hours:$minutes:$seconds';
  }
}
