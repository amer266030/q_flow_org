class Event {
  String? id;
  String? organizerId;
  String? name;
  String? location;
  String? imgUrl;
  bool? didInviteCompanies;
  bool? didInviteUsers;
  String? startDate;
  String? endDate;

  Event({
    this.id,
    this.organizerId,
    this.name,
    this.location,
    this.imgUrl,
    this.didInviteCompanies,
    this.didInviteUsers,
    this.startDate,
    this.endDate,
  });
}
