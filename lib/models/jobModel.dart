import 'dart:convert';

class JobModel {
  String? jobTitle;
  String? salary;
  String? location;
  bool? isPartTime;
  String? expReq;
  String? company;
  JobModel({
    this.jobTitle,
    this.salary,
    this.location,
    this.isPartTime,
    this.expReq,
    this.company,
  });

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'salary': salary,
      'location': location,
      'isPartTime': isPartTime,
      'expReq': expReq,
      'company': company,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      jobTitle: map['jobTitle'],
      salary: map['salary'],
      location: map['location'],
      isPartTime: map['isPartTime'],
      expReq: map['expReq'],
      company: map['company'],
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) => JobModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JobModel(jobTitle: $jobTitle, salary: $salary, location: $location, isPartTime: $isPartTime, expReq: $expReq, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is JobModel &&
      other.jobTitle == jobTitle &&
      other.salary == salary &&
      other.location == location &&
      other.isPartTime == isPartTime &&
      other.expReq == expReq &&
      other.company == company;
  }

}
