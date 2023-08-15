String truncateWithEllipsis(String input, int maxLength) {
  if (input == null || input.length <= maxLength) return input;

  return '${input.substring(0, maxLength - 1)}…';
}
