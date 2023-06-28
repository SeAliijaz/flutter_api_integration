import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Day-06-(students_data)/Model/students_data_model.dart';
import 'package:http/http.dart' as http;

class StudentDataHomeScreen extends StatefulWidget {
  const StudentDataHomeScreen({Key? key}) : super(key: key);

  @override
  State<StudentDataHomeScreen> createState() => _StudentDataHomeScreenState();
}

class _StudentDataHomeScreenState extends State<StudentDataHomeScreen> {
  List<StudentsDataModel> studentsModelList = [];

  Future<List<StudentsDataModel>> fetchStudentsData() async {
    const String uri =
        "http://webhook.site/430f9f03-6953-4deb-8f7b-c66eb0cc3498";
    final response = await http.get(Uri.parse(uri));
    debugPrint(response.body);

    try {
      if (response.statusCode == 200) {
        var data = json.decode(response.body.toString());
        studentsModelList =
            data.map((item) => StudentsDataModel.fromJson(item)).toList();
        return studentsModelList;
      } else {
        throw Exception('Failed to fetch students data');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students Data'),
      ),
      body: FutureBuilder<List<StudentsDataModel>>(
        future: fetchStudentsData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<StudentsDataModel>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<StudentsDataModel> studentsModel = snapshot.data!;
            return ListView.builder(
              itemCount: studentsModel.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                final value = studentsModel[index];
                return Card(
                  child: Text("${value.id}"),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
