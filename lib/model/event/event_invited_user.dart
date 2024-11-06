class EventInvitedUser {
  String? id;
  String? eventId;
  String? email;
  String? invitedAt;
  String? visitorId;
  String? companyId;
  bool? isCompany;

  EventInvitedUser({
    this.id,
    this.eventId,
    this.email,
    this.invitedAt,
    this.visitorId,
    this.companyId,
    this.isCompany,
  });

  factory EventInvitedUser.fromJson(Map<String, dynamic> json) {
    return EventInvitedUser(
      id: json['id'] as String?,
      eventId: json['event_id'] as String?,
      email: json['email'] as String?,
      invitedAt: json['invited_at'] as String?,
      visitorId: json['visitor_id'] as String?,
      companyId: json['company_id'] as String?,
      isCompany: json['is_company'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'email': email,
      'invited_at': invitedAt,
      'visitor_id': visitorId,
      'company_id': companyId,
      'is_company': isCompany,
    };
  }
}
