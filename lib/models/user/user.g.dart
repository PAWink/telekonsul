// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel()
    ..uid = json['doc_id'] as String?
    ..name = json['name'] as String?
    ..email = json['email'] as String?
    ..phoneNumber = json['phone_number'] as String?
    ..address = json['address'] as String?
    //เพิ่มแล้ว2
    ..start = json['start'] as String? //
    ..finish = json['finish'] as String? //
    ..profileUrl = json['profile_url'] as String?;
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'doc_id': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      //เพิ่มแล้ว2
      'start': instance.start, //
      'finish': instance.finish, //
      'profile_url': instance.profileUrl,
    };
