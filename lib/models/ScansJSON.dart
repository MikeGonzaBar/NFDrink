/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ScansJSON type in your schema. */
@immutable
class ScansJSON {
  final String? _scannerName;
  final String? _scannerAge;
  final String? _scannerSex;
  final String? _longitude;
  final String? _latitude;
  final TemporalDateTime? _day;

  String? get scannerName {
    return _scannerName;
  }
  
  String? get scannerAge {
    return _scannerAge;
  }
  
  String? get scannerSex {
    return _scannerSex;
  }
  
  String? get longitude {
    return _longitude;
  }
  
  String? get latitude {
    return _latitude;
  }
  
  TemporalDateTime? get day {
    return _day;
  }
  
  const ScansJSON._internal({scannerName, scannerAge, scannerSex, longitude, latitude, day}): _scannerName = scannerName, _scannerAge = scannerAge, _scannerSex = scannerSex, _longitude = longitude, _latitude = latitude, _day = day;
  
  factory ScansJSON({String? scannerName, String? scannerAge, String? scannerSex, String? longitude, String? latitude, TemporalDateTime? day}) {
    return ScansJSON._internal(
      scannerName: scannerName,
      scannerAge: scannerAge,
      scannerSex: scannerSex,
      longitude: longitude,
      latitude: latitude,
      day: day);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScansJSON &&
      _scannerName == other._scannerName &&
      _scannerAge == other._scannerAge &&
      _scannerSex == other._scannerSex &&
      _longitude == other._longitude &&
      _latitude == other._latitude &&
      _day == other._day;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ScansJSON {");
    buffer.write("scannerName=" + "$_scannerName" + ", ");
    buffer.write("scannerAge=" + "$_scannerAge" + ", ");
    buffer.write("scannerSex=" + "$_scannerSex" + ", ");
    buffer.write("longitude=" + "$_longitude" + ", ");
    buffer.write("latitude=" + "$_latitude" + ", ");
    buffer.write("day=" + (_day != null ? _day!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ScansJSON copyWith({String? scannerName, String? scannerAge, String? scannerSex, String? longitude, String? latitude, TemporalDateTime? day}) {
    return ScansJSON._internal(
      scannerName: scannerName ?? this.scannerName,
      scannerAge: scannerAge ?? this.scannerAge,
      scannerSex: scannerSex ?? this.scannerSex,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      day: day ?? this.day);
  }
  
  ScansJSON.fromJson(Map<String, dynamic> json)  
    : _scannerName = json['scannerName'],
      _scannerAge = json['scannerAge'],
      _scannerSex = json['scannerSex'],
      _longitude = json['longitude'],
      _latitude = json['latitude'],
      _day = json['day'] != null ? TemporalDateTime.fromString(json['day']) : null;
  
  Map<String, dynamic> toJson() => {
    'scannerName': _scannerName, 'scannerAge': _scannerAge, 'scannerSex': _scannerSex, 'longitude': _longitude, 'latitude': _latitude, 'day': _day?.format()
  };
  
  Map<String, Object?> toMap() => {
    'scannerName': _scannerName, 'scannerAge': _scannerAge, 'scannerSex': _scannerSex, 'longitude': _longitude, 'latitude': _latitude, 'day': _day
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ScansJSON";
    modelSchemaDefinition.pluralName = "ScansJSONS";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'scannerName',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'scannerAge',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'scannerSex',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'longitude',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'latitude',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'day',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}