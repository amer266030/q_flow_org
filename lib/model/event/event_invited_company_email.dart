class EventInvitedCompanyEmail {
  String? id;
  String? eventId;
  String? companyName;
  String? email;
  String? invitedAt;

  EventInvitedCompanyEmail(
      {this.id, this.eventId, this.companyName, this.email, this.invitedAt});

  factory EventInvitedCompanyEmail.fromJson(Map<String, dynamic> json) {
    return EventInvitedCompanyEmail(
      id: json['id'] as String?,
      eventId: json['event_id'] as String?,
      companyName: json['company_name'] as String?,
      email: json['email'] as String?,
      invitedAt: json['invited_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'company_name': companyName,
      'email': email,
      'invited_at': invitedAt,
    };
  }
}
