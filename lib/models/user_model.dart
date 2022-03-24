class UserInformation {
  final String? name;
  final String? phone;
  final String? imageUrl;
  final String? id;
  final String? dateOfBirth;
  final String? state;
  final String? city;
  final String? adhaarNo;
  final String? percentage10;
  final String? percentage12;
  final String? school10;
  final String? school12;
  final bool? isAdhaarVerified;
  final bool? isRegistrationCompleted;
  final String? rollNo;
  UserInformation(
      {this.city,
      this.dateOfBirth,
      this.id,
      this.imageUrl,
      this.name,
      this.phone,
      this.state,
      this.percentage10,
      this.adhaarNo,
      this.percentage12,
      this.school10,
      this.school12,
      this.isAdhaarVerified,
      this.isRegistrationCompleted,
      this.rollNo});
}
