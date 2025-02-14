// To parse this JSON data, do
//
//     final people = peopleFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
// import 'package:harmony_hub/shared/secrets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'people.g.dart';

People peopleFromJson(String str) => People.fromJson(json.decode(str));

String peopleToJson(People data) => json.encode(data.toJson());

@riverpod
Future<People> members(Ref ref) async {
// getSecretAsync(ref, secretName, secretVersion)

  final response = await http.get(
      Uri.parse(
          'https://api.planningcenteronline.com/people/v2/lists/3971241?include=people'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer empty'});

  final json = jsonDecode(response.body) as Map<String, dynamic>;

  return People.fromJson(json);
}

class People {
  Data data;
  List<Included> included;
  Meta meta;

  People({
    required this.data,
    required this.included,
    required this.meta,
  });

  factory People.fromJson(Map<String, dynamic> json) => People(
        data: Data.fromJson(json["data"]),
        included: List<Included>.from(
            json["included"].map((x) => Included.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "included": List<dynamic>.from(included.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Data {
  String type;
  String id;
  DataAttributes attributes;
  DataLinks links;
  DataRelationships relationships;

  Data({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
    required this.relationships,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        id: json["id"],
        attributes: DataAttributes.fromJson(json["attributes"]),
        links: DataLinks.fromJson(json["links"]),
        relationships: DataRelationships.fromJson(json["relationships"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes.toJson(),
        "links": links.toJson(),
        "relationships": relationships.toJson(),
      };
}

class DataAttributes {
  bool autoRefresh;
  String autoRefreshFrequency;
  bool automationsActive;
  int automationsCount;
  DateTime batchCompletedAt;
  DateTime createdAt;
  String description;
  bool hasInactiveResults;
  bool includeInactive;
  bool invalid;
  String name;
  String nameOrDescription;
  int pausedAutomationsCount;
  bool recentlyViewed;
  DateTime refreshedAt;
  bool returnOriginalIfNone;
  String returns;
  bool starred;
  String status;
  String subset;
  int totalPeople;
  DateTime updatedAt;

  DataAttributes({
    required this.autoRefresh,
    required this.autoRefreshFrequency,
    required this.automationsActive,
    required this.automationsCount,
    required this.batchCompletedAt,
    required this.createdAt,
    required this.description,
    required this.hasInactiveResults,
    required this.includeInactive,
    required this.invalid,
    required this.name,
    required this.nameOrDescription,
    required this.pausedAutomationsCount,
    required this.recentlyViewed,
    required this.refreshedAt,
    required this.returnOriginalIfNone,
    required this.returns,
    required this.starred,
    required this.status,
    required this.subset,
    required this.totalPeople,
    required this.updatedAt,
  });

  factory DataAttributes.fromJson(Map<String, dynamic> json) => DataAttributes(
        autoRefresh: json["auto_refresh"],
        autoRefreshFrequency: json["auto_refresh_frequency"],
        automationsActive: json["automations_active"],
        automationsCount: json["automations_count"],
        batchCompletedAt: DateTime.parse(json["batch_completed_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        description: json["description"],
        hasInactiveResults: json["has_inactive_results"],
        includeInactive: json["include_inactive"],
        invalid: json["invalid"],
        name: json["name"],
        nameOrDescription: json["name_or_description"],
        pausedAutomationsCount: json["paused_automations_count"],
        recentlyViewed: json["recently_viewed"],
        refreshedAt: DateTime.parse(json["refreshed_at"]),
        returnOriginalIfNone: json["return_original_if_none"],
        returns: json["returns"],
        starred: json["starred"],
        status: json["status"],
        subset: json["subset"],
        totalPeople: json["total_people"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "auto_refresh": autoRefresh,
        "auto_refresh_frequency": autoRefreshFrequency,
        "automations_active": automationsActive,
        "automations_count": automationsCount,
        "batch_completed_at": batchCompletedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "description": description,
        "has_inactive_results": hasInactiveResults,
        "include_inactive": includeInactive,
        "invalid": invalid,
        "name": name,
        "name_or_description": nameOrDescription,
        "paused_automations_count": pausedAutomationsCount,
        "recently_viewed": recentlyViewed,
        "refreshed_at": refreshedAt.toIso8601String(),
        "return_original_if_none": returnOriginalIfNone,
        "returns": returns,
        "starred": starred,
        "status": status,
        "subset": subset,
        "total_people": totalPeople,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class DataLinks {
  dynamic campus;
  dynamic category;
  String createdBy;
  String listResults;
  String mailchimpSync;
  dynamic mailchimpSyncStatus;
  String people;
  String rules;
  String run;
  String shares;
  String star;
  String updatedBy;
  String self;
  String html;

  DataLinks({
    required this.campus,
    required this.category,
    required this.createdBy,
    required this.listResults,
    required this.mailchimpSync,
    required this.mailchimpSyncStatus,
    required this.people,
    required this.rules,
    required this.run,
    required this.shares,
    required this.star,
    required this.updatedBy,
    required this.self,
    required this.html,
  });

  factory DataLinks.fromJson(Map<String, dynamic> json) => DataLinks(
        campus: json["campus"],
        category: json["category"],
        createdBy: json["created_by"],
        listResults: json["list_results"],
        mailchimpSync: json["mailchimp_sync"],
        mailchimpSyncStatus: json["mailchimp_sync_status"],
        people: json["people"],
        rules: json["rules"],
        run: json["run"],
        shares: json["shares"],
        star: json["star"],
        updatedBy: json["updated_by"],
        self: json["self"],
        html: json["html"],
      );

  Map<String, dynamic> toJson() => {
        "campus": campus,
        "category": category,
        "created_by": createdBy,
        "list_results": listResults,
        "mailchimp_sync": mailchimpSync,
        "mailchimp_sync_status": mailchimpSyncStatus,
        "people": people,
        "rules": rules,
        "run": run,
        "shares": shares,
        "star": star,
        "updated_by": updatedBy,
        "self": self,
        "html": html,
      };
}

class DataRelationships {
  PeopleClass people;

  DataRelationships({
    required this.people,
  });

  factory DataRelationships.fromJson(Map<String, dynamic> json) =>
      DataRelationships(
        people: PeopleClass.fromJson(json["people"]),
      );

  Map<String, dynamic> toJson() => {
        "people": people.toJson(),
      };
}

class PeopleClass {
  PeopleLinks links;
  List<Parent> data;

  PeopleClass({
    required this.links,
    required this.data,
  });

  factory PeopleClass.fromJson(Map<String, dynamic> json) => PeopleClass(
        links: PeopleLinks.fromJson(json["links"]),
        data: List<Parent>.from(json["data"].map((x) => Parent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "links": links.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Parent {
  String type;
  String id;

  Parent({
    required this.type,
    required this.id,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
      };
}

class PeopleLinks {
  String related;

  PeopleLinks({
    required this.related,
  });

  factory PeopleLinks.fromJson(Map<String, dynamic> json) => PeopleLinks(
        related: json["related"],
      );

  Map<String, dynamic> toJson() => {
        "related": related,
      };
}

class Included {
  String type;
  String id;
  IncludedAttributes attributes;
  IncludedRelationships relationships;
  IncludedLinks links;

  Included({
    required this.type,
    required this.id,
    required this.attributes,
    required this.relationships,
    required this.links,
  });

  factory Included.fromJson(Map<String, dynamic> json) => Included(
        type: json["type"],
        id: json["id"],
        attributes: IncludedAttributes.fromJson(json["attributes"]),
        relationships: IncludedRelationships.fromJson(json["relationships"]),
        links: IncludedLinks.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes.toJson(),
        "relationships": relationships.toJson(),
        "links": links.toJson(),
      };
}

class IncludedAttributes {
  bool accountingAdministrator;
  dynamic anniversary;
  String avatar;
  DateTime birthdate;
  bool canCreateForms;
  bool canEmailLists;
  bool child;
  DateTime createdAt;
  String demographicAvatarUrl;
  String directoryStatus;
  String firstName;
  String gender;
  String? givenName;
  dynamic grade;
  dynamic graduationYear;
  dynamic inactivatedAt;
  String lastName;
  String loginIdentifier;
  dynamic medicalNotes;
  String? membership;
  dynamic middleName;
  String name;
  dynamic nickname;
  bool passedBackgroundCheck;
  String peoplePermissions;
  dynamic remoteId;
  ResourcePermissionFlags resourcePermissionFlags;
  dynamic schoolType;
  bool siteAdministrator;
  String status;
  DateTime updatedAt;

  IncludedAttributes({
    required this.accountingAdministrator,
    required this.anniversary,
    required this.avatar,
    required this.birthdate,
    required this.canCreateForms,
    required this.canEmailLists,
    required this.child,
    required this.createdAt,
    required this.demographicAvatarUrl,
    required this.directoryStatus,
    required this.firstName,
    required this.gender,
    required this.givenName,
    required this.grade,
    required this.graduationYear,
    required this.inactivatedAt,
    required this.lastName,
    required this.loginIdentifier,
    required this.medicalNotes,
    required this.membership,
    required this.middleName,
    required this.name,
    required this.nickname,
    required this.passedBackgroundCheck,
    required this.peoplePermissions,
    required this.remoteId,
    required this.resourcePermissionFlags,
    required this.schoolType,
    required this.siteAdministrator,
    required this.status,
    required this.updatedAt,
  });

  factory IncludedAttributes.fromJson(Map<String, dynamic> json) =>
      IncludedAttributes(
        accountingAdministrator: json["accounting_administrator"],
        anniversary: json["anniversary"],
        avatar: json["avatar"],
        birthdate: DateTime.parse(json["birthdate"]),
        canCreateForms: json["can_create_forms"],
        canEmailLists: json["can_email_lists"],
        child: json["child"],
        createdAt: DateTime.parse(json["created_at"]),
        demographicAvatarUrl: json["demographic_avatar_url"],
        directoryStatus: json["directory_status"],
        firstName: json["first_name"],
        gender: json["gender"],
        givenName: json["given_name"],
        grade: json["grade"],
        graduationYear: json["graduation_year"],
        inactivatedAt: json["inactivated_at"],
        lastName: json["last_name"],
        loginIdentifier: json["login_identifier"],
        medicalNotes: json["medical_notes"],
        membership: json["membership"],
        middleName: json["middle_name"],
        name: json["name"],
        nickname: json["nickname"],
        passedBackgroundCheck: json["passed_background_check"],
        peoplePermissions: json["people_permissions"],
        remoteId: json["remote_id"],
        resourcePermissionFlags:
            ResourcePermissionFlags.fromJson(json["resource_permission_flags"]),
        schoolType: json["school_type"],
        siteAdministrator: json["site_administrator"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "accounting_administrator": accountingAdministrator,
        "anniversary": anniversary,
        "avatar": avatar,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "can_create_forms": canCreateForms,
        "can_email_lists": canEmailLists,
        "child": child,
        "created_at": createdAt.toIso8601String(),
        "demographic_avatar_url": demographicAvatarUrl,
        "directory_status": directoryStatus,
        "first_name": firstName,
        "gender": gender,
        "given_name": givenName,
        "grade": grade,
        "graduation_year": graduationYear,
        "inactivated_at": inactivatedAt,
        "last_name": lastName,
        "login_identifier": loginIdentifier,
        "medical_notes": medicalNotes,
        "membership": membership,
        "middle_name": middleName,
        "name": name,
        "nickname": nickname,
        "passed_background_check": passedBackgroundCheck,
        "people_permissions": peoplePermissions,
        "remote_id": remoteId,
        "resource_permission_flags": resourcePermissionFlags.toJson(),
        "school_type": schoolType,
        "site_administrator": siteAdministrator,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ResourcePermissionFlags {
  bool canAccessWorkflows;

  ResourcePermissionFlags({
    required this.canAccessWorkflows,
  });

  factory ResourcePermissionFlags.fromJson(Map<String, dynamic> json) =>
      ResourcePermissionFlags(
        canAccessWorkflows: json["can_access_workflows"],
      );

  Map<String, dynamic> toJson() => {
        "can_access_workflows": canAccessWorkflows,
      };
}

class IncludedLinks {
  String self;
  String html;

  IncludedLinks({
    required this.self,
    required this.html,
  });

  factory IncludedLinks.fromJson(Map<String, dynamic> json) => IncludedLinks(
        self: json["self"],
        html: json["html"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
      };
}

class IncludedRelationships {
  Gender primaryCampus;
  Gender gender;

  IncludedRelationships({
    required this.primaryCampus,
    required this.gender,
  });

  factory IncludedRelationships.fromJson(Map<String, dynamic> json) =>
      IncludedRelationships(
        primaryCampus: Gender.fromJson(json["primary_campus"]),
        gender: Gender.fromJson(json["gender"]),
      );

  Map<String, dynamic> toJson() => {
        "primary_campus": primaryCampus.toJson(),
        "gender": gender.toJson(),
      };
}

class Gender {
  Parent? data;

  Gender({
    required this.data,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        data: json["data"] == null ? null : Parent.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Meta {
  List<String> canInclude;
  Parent parent;

  Meta({
    required this.canInclude,
    required this.parent,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        canInclude: List<String>.from(json["can_include"].map((x) => x)),
        parent: Parent.fromJson(json["parent"]),
      );

  Map<String, dynamic> toJson() => {
        "can_include": List<dynamic>.from(canInclude.map((x) => x)),
        "parent": parent.toJson(),
      };
}
