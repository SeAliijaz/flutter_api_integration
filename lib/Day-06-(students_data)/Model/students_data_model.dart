class StudentsDataModel {
  final int? id;
  final String? name;
  final int? rollNumber;
  final Class? studentsDataModelClass;

  StudentsDataModel({
    this.id,
    this.name,
    this.rollNumber,
    this.studentsDataModelClass,
  });

  StudentsDataModel copyWith({
    int? id,
    String? name,
    int? rollNumber,
    Class? studentsDataModelClass,
  }) =>
      StudentsDataModel(
        id: id ?? this.id,
        name: name ?? this.name,
        rollNumber: rollNumber ?? this.rollNumber,
        studentsDataModelClass:
            studentsDataModelClass ?? this.studentsDataModelClass,
      );

  static fromJson(item) {}
}

class Class {
  final String? degree;
  final Session? session;
  final Section? section;

  Class({
    this.degree,
    this.session,
    this.section,
  });

  Class copyWith({
    String? degree,
    Session? session,
    Section? section,
  }) =>
      Class(
        degree: degree ?? this.degree,
        session: session ?? this.session,
        section: section ?? this.section,
      );
}

enum Section { E2_EVENING_TIME }

enum Session { THE_20202024 }
