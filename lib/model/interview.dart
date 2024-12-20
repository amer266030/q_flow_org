
import 'package:q_flow_organizer/model/queue_entry.dart';

import 'enums/interview_status.dart';

class Interview {
  String? id;
  String? visitorId;
  String? companyId;
  String? createdAt;
  InterviewStatus? status;
  List<QueueEntry>? queue;

  Interview({
    this.id,
    this.visitorId,
    this.companyId,
    this.createdAt,
    this.status,
    this.queue,
  });

  factory Interview.fromJson(Map<String, dynamic> json) {
    return Interview(
      id: json['id'] as String?,
      visitorId: json['visitor_id'] as String?,
      companyId: json['company_id'] as String?,
      createdAt: json['created_at'] as String?,
      status: json['status'] != null
          ? InterviewStatusExtension.fromString(json['status'] as String)
          : null,
      queue: json['queue'] != null
          ? (json['queue'] as List)
              .map((entry) => QueueEntry.fromJson(entry))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitor_id': visitorId,
      'company_id': companyId,
      'status': status?.value,
    };
  }
}
