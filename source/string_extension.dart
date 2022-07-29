extension StringExtension on String {
  num toNum() {
    try {
      return num.tryParse(this) ?? 0;
    } catch (e) {
      return 0;
    }
  }
}
