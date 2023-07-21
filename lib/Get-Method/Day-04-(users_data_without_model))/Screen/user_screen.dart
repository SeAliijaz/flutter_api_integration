import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Constants/k.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  ///Global Variable /*data*/
  ///So We Can Access it in Body and can assign value in function
  var data;

  ///Method To Fetch API
  Future<void> getUsersData() async {
    const String uri = "http://jsonplaceholder.typicode.com/users";
    final response = await http.get(Uri.parse(uri));

    try {
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
      } else {
        throw Exception();
      }
    } catch (e) {
      AppConsts.showMessage(context, "Error Message", e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Data Without User Model',
            overflow: TextOverflow.ellipsis),
        centerTitle: true,
        leading: const Icon(Icons.menu_outlined),
      ),
      body: FutureBuilder(
        future: getUsersData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: [
                      ReUsableRow(
                        title: "Id",
                        value: "${data[index]["id"]}",
                      ),
                      ReUsableRow(
                        title: "Name",
                        value: "${data[index]["name"]}",
                      ),
                      ReUsableRow(
                        title: "UserName",
                        value: "${data[index]["username"]}",
                      ),
                      ReUsableRow(
                        title: "Email",
                        value: "${data[index]["email"]}",
                      ),
                      ReUsableRow(
                        title: "Address",
                        value: "${data[index]["address"]["street"]}",
                      ),
                      ReUsableRow(
                        title: "Suite",
                        value: "${data[index]["address"]["suite"]}",
                      ),
                      ReUsableRow(
                        title: "City",
                        value: "${data[index]["address"]["city"]}",
                      ),
                      ReUsableRow(
                        title: "ZipCode",
                        value: "${data[index]["address"]["zipcode"]}",
                      ),
                      ReUsableRow(
                        title: "Geo-Lat",
                        value: "${data[index]["address"]["geo"]["lat"]}",
                      ),
                      ReUsableRow(
                        title: "Geo-Lng",
                        value: "${data[index]["address"]["geo"]["lng"]}",
                      ),
                      ReUsableRow(
                        title: "Phone",
                        value: "${data[index]["phone"]}",
                      ),
                      ReUsableRow(
                        title: "Website",
                        value: "${data[index]["website"]}",
                      ),
                      ReUsableRow(
                        title: "Company Name",
                        value: "${data[index]["company"]["name"]}",
                      ),
                      ReUsableRow(
                        title: "CatchPhrase",
                        value: "${data[index]["company"]["catchPhrase"]}",
                      ),
                      ReUsableRow(
                        title: "Business",
                        value: "${data[index]["company"]["bs"]}",
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  final String? title, value;

  const ReUsableRow({
    Key? key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${title ?? "title"}:",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value ?? "value",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}
