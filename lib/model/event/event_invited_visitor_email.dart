class EventInvitedVisitorEmail {
  String? id;
  String? eventId;
  String? visitorName;
  String? email;
  String? invitedAt;

  EventInvitedVisitorEmail(
      {this.id, this.eventId, this.visitorName, this.email, this.invitedAt});

  factory EventInvitedVisitorEmail.fromJson(Map<String, dynamic> json) {
    return EventInvitedVisitorEmail(
      id: json['id'] as String?,
      eventId: json['event_id'] as String?,
      visitorName: json['visitor_name'] as String?,
      email: json['email'] as String?,
      invitedAt: json['invited_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'visitor_name': visitorName,
      'email': email,
      'invited_at': invitedAt,
    };
  }
}
