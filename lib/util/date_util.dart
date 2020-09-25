class _DateUtil {
  String getDate({DateTime date}) {
    date ??= DateTime.now();
    return '${date.month}月${date.day}日';
  }

  String getDateFromFormattedString(String formattedString) {
    final date = DateTime.parse(formattedString);
    return getDate(date: date);
  }
}

final dateUtil = _DateUtil();
