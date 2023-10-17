import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'doctor.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Doctor {
  Doctor(this.id, this.name, this.title, this.address, this.phone);
  final int id;
  final String name;
  String title;
  String address;
  String phone;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$DoctorToJson(this);
  @override
  String toString() {
    return 'Doctor{id: $id, name:$name, title:$title, address:$address, phone: $phone}';
  }
}
