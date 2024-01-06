void updateSelectedTimes(
  String time,
  bool selected,
  List<String> selectedTimes,
) {
  if (selected) {
    if (time == 'Morning') {
      selectedTimes
        ..remove('Morning')
        ..insert(0, 'Morning');
    } else if (time == 'Afternoon') {
      if (!selectedTimes.contains('Morning')) {
        selectedTimes
          ..remove('Afternoon')
          ..insert(0, 'Afternoon');
      } else if (selectedTimes.contains('Morning') &&
          selectedTimes.contains('Evening')) {
        selectedTimes
          ..remove('Morning')
          ..remove('Evening')
          ..add('Morning')
          ..add('Afternoon')
          ..add('Evening');
      } else if (selectedTimes.contains('Morning')) {
        selectedTimes
          ..remove('Morning')
          ..add('Morning')
          ..add('Afternoon');
      }
    } else if (time == 'Evening') {
      if (!selectedTimes.contains('Morning') &&
          !selectedTimes.contains('Afternoon')) {
        selectedTimes
          ..remove('Evening')
          ..insert(0, 'Evening');
      } else if (!selectedTimes.contains('Morning')) {
        selectedTimes
          ..remove('Afternoon')
          ..add('Afternoon')
          ..add('Evening');
      } else if (!selectedTimes.contains('Afternoon')) {
        selectedTimes
          ..remove('Morning')
          ..add('Morning')
          ..add('Evening');
      } else if (selectedTimes.contains('Morning') &&
          selectedTimes.contains('Afternoon')) {
        selectedTimes
          ..remove('Morning')
          ..remove('Afternoon')
          ..add('Morning')
          ..add('Afternoon')
          ..add('Evening');
      }
    }
  } else {
    selectedTimes.remove(time);
  }
}

  // void updateSelectedTimes(
  //   String time,
  //   bool selected,
  //   List<String> selectedTimes,
  // ) {
  //   if (selected) {
  //     selectedTimes.add(time);
  //   } else {
  //     selectedTimes.remove(time);
  //   }
  // }