enum Health {
  none(""),
  unknown("Unknown"),
  good("Good"),
  overheat("Over Heat"),
  dead("Dead"),
  overVoltage("Over Voltage"),
  unspecifiedFailure("Unspecified Failure"),
  cold("Cold");

  final String title;

  const Health(this.title);
}

enum Status {
  none(""),
  unknown("Unknown"),
  charging("Charging"),
  discharging("Discharging"),
  notCharging("Not Charging"),
  full("Full");

  final String title;

  const Status(this.title);
}

enum Plugged {
  none(""),
  ac("AC"),
  usb("USB"),
  wireless("Wireless");

  final String title;

  const Plugged(this.title);
}
