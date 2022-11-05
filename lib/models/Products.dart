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

/** This is an auto generated class representing the Products type in your schema. */
@immutable
class Products extends Model {
  static const classType = const _ProductsModelType();
  final String id;
  final String? _product_name;
  final double? _net_content;
  final String? _admin_users_ID;
  final String? _image_s3_key;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  String? get product_name {
    return _product_name;
  }

  double? get net_content {
    return _net_content;
  }

  String? get admin_users_ID {
    return _admin_users_ID;
  }

  String? get image_s3_key {
    return _image_s3_key;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const Products._internal(
      {required this.id,
      product_name,
      net_content,
      admin_users_ID,
      image_s3_key,
      createdAt,
      updatedAt})
      : _product_name = product_name,
        _net_content = net_content,
        _admin_users_ID = admin_users_ID,
        _image_s3_key = image_s3_key,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory Products(
      {String? id,
      String? product_name,
      double? net_content,
      String? admin_users_ID,
      String? image_s3_key}) {
    return Products._internal(
        id: id == null ? UUID.getUUID() : id,
        product_name: product_name,
        net_content: net_content,
        admin_users_ID: admin_users_ID,
        image_s3_key: image_s3_key);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Products &&
        id == other.id &&
        _product_name == other._product_name &&
        _net_content == other._net_content &&
        _admin_users_ID == other._admin_users_ID &&
        _image_s3_key == other._image_s3_key;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Products {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("product_name=" + "$_product_name" + ", ");
    buffer.write("net_content=" +
        (_net_content != null ? _net_content!.toString() : "null") +
        ", ");
    buffer.write("admin_users_ID=" + "$_admin_users_ID" + ", ");
    buffer.write("image_s3_key=" + "$_image_s3_key" + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Products copyWith(
      {String? id,
      String? product_name,
      double? net_content,
      String? admin_users_ID,
      String? image_s3_key}) {
    return Products._internal(
        id: id ?? this.id,
        product_name: product_name ?? this.product_name,
        net_content: net_content ?? this.net_content,
        admin_users_ID: admin_users_ID ?? this.admin_users_ID,
        image_s3_key: image_s3_key ?? this.image_s3_key);
  }

  Products.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _product_name = json['product_name'],
        _net_content = (json['net_content'] as num?)?.toDouble(),
        _admin_users_ID = json['admin_users_ID'],
        _image_s3_key = json['image_s3_key'],
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_name': _product_name,
        'net_content': _net_content,
        'admin_users_ID': _admin_users_ID,
        'image_s3_key': _image_s3_key,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'product_name': _product_name,
        'net_content': _net_content,
        'admin_users_ID': _admin_users_ID,
        'image_s3_key': _image_s3_key,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField PRODUCT_NAME = QueryField(fieldName: "product_name");
  static final QueryField NET_CONTENT = QueryField(fieldName: "net_content");
  static final QueryField ADMIN_USERS_ID =
      QueryField(fieldName: "admin_users_ID");
  static final QueryField IMAGE_S3_KEY = QueryField(fieldName: "image_s3_key");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Products";
    modelSchemaDefinition.pluralName = "Products";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: const [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Products.PRODUCT_NAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Products.NET_CONTENT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Products.ADMIN_USERS_ID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Products.IMAGE_S3_KEY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _ProductsModelType extends ModelType<Products> {
  const _ProductsModelType();

  @override
  Products fromJson(Map<String, dynamic> jsonData) {
    return Products.fromJson(jsonData);
  }
}
