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
  final String? _scanner;
  final TemporalDateTime? _day;
  final String? _latitude;
  final String? _longitude;

  String? get scanner {
    return _scanner;
  }
  
  TemporalDateTime? get day {
    return _day;
  }
  
  String? get latitude {
    return _latitude;
  }
  
  String? get longitude {
    return _longitude;
  }
  
  const ScansJSON._internal({scanner, day, latitude, longitude}): _scanner = scanner, _day = day, _latitude = latitude, _longitude = longitude;
  
  factory ScansJSON({String? scanner, TemporalDateTime? day, String? latitude, String? longitude}) {
    return ScansJSON._internal(
      scanner: scanner,
      day: day,
      latitude: latitude,
      longitude: longitude);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScansJSON &&
      _scanner == other._scanner &&
      _day == other._day &&
      _latitude == other._latitude &&
      _longitude == other._longitude;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ScansJSON {");
    buffer.write("scanner=" + "$_scanner" + ", ");
    buffer.write("day=" + (_day != null ? _day!.format() : "null") + ", ");
    buffer.write("latitude=" + "$_latitude" + ", ");
    buffer.write("longitude=" + "$_longitude");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ScansJSON copyWith({String? scanner, TemporalDateTime? day, String? latitude, String? longitude}) {
    return ScansJSON._internal(
      scanner: scanner ?? this.scanner,
      day: day ?? this.day,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude);
  }
  
  ScansJSON.fromJson(Map<String, dynamic> json)  
    : _scanner = json['scanner'],
      _day = json['day'] != null ? TemporalDateTime.fromString(json['day']) : null,
      _latitude = json['latitude'],
      _longitude = json['longitude'];
  
  Map<String, dynamic> toJson() => {
    'scanner': _scanner, 'day': _day?.format(), 'latitude': _latitude, 'longitude': _longitude
  };
  
  Map<String, Object?> toMap() => {
    'scanner': _scanner, 'day': _day, 'latitude': _latitude, 'longitude': _longitude
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ScansJSON";
    modelSchemaDefinition.pluralName = "ScansJSONS";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'scanner',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'day',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'latitude',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'longitude',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}