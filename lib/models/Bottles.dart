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

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Bottles type in your schema. */
@immutable
class Bottles extends Model {
  static const classType = const _BottlesModelType();
  final String id;
  final String? _year;
  final ScansJSON? _scans;
  final String? _products_id;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get year {
    return _year;
  }
  
  ScansJSON? get scans {
    return _scans;
  }
  
  String? get products_id {
    return _products_id;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Bottles._internal({required this.id, year, scans, products_id, createdAt, updatedAt}): _year = year, _scans = scans, _products_id = products_id, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Bottles({String? id, String? year, ScansJSON? scans, String? products_id}) {
    return Bottles._internal(
      id: id == null ? UUID.getUUID() : id,
      year: year,
      scans: scans,
      products_id: products_id);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bottles &&
      id == other.id &&
      _year == other._year &&
      _scans == other._scans &&
      _products_id == other._products_id;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Bottles {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("year=" + "$_year" + ", ");
    buffer.write("scans=" + (_scans != null ? _scans!.toString() : "null") + ", ");
    buffer.write("products_id=" + "$_products_id" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Bottles copyWith({String? id, String? year, ScansJSON? scans, String? products_id}) {
    return Bottles._internal(
      id: id ?? this.id,
      year: year ?? this.year,
      scans: scans ?? this.scans,
      products_id: products_id ?? this.products_id);
  }
  
  Bottles.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _year = json['year'],
      _scans = json['scans']?['serializedData'] != null
        ? ScansJSON.fromJson(new Map<String, dynamic>.from(json['scans']['serializedData']))
        : null,
      _products_id = json['products_id'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'year': _year, 'scans': _scans?.toJson(), 'products_id': _products_id, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'year': _year, 'scans': _scans, 'products_id': _products_id, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField YEAR = QueryField(fieldName: "year");
  static final QueryField SCANS = QueryField(fieldName: "scans");
  static final QueryField PRODUCTS_ID = QueryField(fieldName: "products_id");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Bottles";
    modelSchemaDefinition.pluralName = "Bottles";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bottles.YEAR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'scans',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'ScansJSON')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bottles.PRODUCTS_ID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _BottlesModelType extends ModelType<Bottles> {
  const _BottlesModelType();
  
  @override
  Bottles fromJson(Map<String, dynamic> jsonData) {
    return Bottles.fromJson(jsonData);
  }
}