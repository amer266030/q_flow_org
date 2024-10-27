class EventInvitedCompany {
  String? eventId;
  String? companyId;

  EventInvitedCompany({this.eventId, this.companyId});

  factory EventInvitedCompany.fromJson(Map<String, dynamic> json) {
    return EventInvitedCompany(
      eventId: json['event_id'] as String?,
      companyId: json['company_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'company_id': companyId,
    };
  }
}
