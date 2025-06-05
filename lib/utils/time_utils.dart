enum PartOfDay { earlyMorning, lateMorning, afternoon, evening, night }

class TimeUtils {
  static PartOfDay getCurrentPartOfDay() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 9) {
      return PartOfDay.earlyMorning;
    } else if (hour >= 9 && hour < 12) {
      return PartOfDay.lateMorning;
    } else if (hour >= 12 && hour < 17) {
      return PartOfDay.afternoon;
    } else if (hour >= 17 && hour < 21) {
      return PartOfDay.evening;
    } else {
      return PartOfDay.night;
    }
  }
}
