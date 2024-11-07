enum Attendance { attended, didNotAttend }

extension AttendanceExtension on Attendance {
  String get value {
    switch (this) {
      case Attendance.attended:
        return 'Attended';
      case Attendance.didNotAttend:
        return "Didn't Attend";
      default:
        return '';
    }
  }

  static Attendance fromString(String? gender) {
    switch (gender) {
      case 'Attended':
        return Attendance.attended;
      case "Didn't Attend":
        return Attendance.didNotAttend;
      default:
        throw ArgumentError('Invalid status value');
    }
  }
}
