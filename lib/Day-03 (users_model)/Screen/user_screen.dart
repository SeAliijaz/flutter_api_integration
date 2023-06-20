import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Constants/k.dart';
import 'package:flutter_api_integration/Day-03%20(users_model)/Model/user_model.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel> userModelList = [];

  Future<List<UserModel>> fetchUserModelData() async {
    const String uri = "http://jsonplaceholder.typicode.com/users";
    final response = await http.get(Uri.parse(uri));
    final data = jsonDecode(response.body) as List<dynamic>;

    try {
      if (response.statusCode == 200) {
        userModelList = data.map((item) => UserModel.fromJson(item)).toList();
        return userModelList;
      } else {
        AppConsts.showMessage("Failed to fetch users");
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      AppConsts.showMessage(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Screen'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: fetchUserModelData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<UserModel>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final List<UserModel> userModelList = snapshot.data!;
            return ListView.separated(
              itemCount: userModelList.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                final userModel = userModelList[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      userModel.name![index],
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  title: Text("Name: ${userModel.name}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username: ${userModel.username}"),
                      Text("Email: ${userModel.email}"),
                      Text("Phone: ${userModel.phone}"),
                      Text("Website: ${userModel.website}"),
                      Text("Street: ${userModel.address!.street}"),
                      Text("Suite: ${userModel.address!.suite}"),
                      Text("City: ${userModel.address!.city}"),
                      Text("Zipcode: ${userModel.address!.zipcode}"),
                      Text("Latitude: ${userModel.address!.geo!.lat}"),
                      Text("Longitude: ${userModel.address!.geo!.lng}"),
                      Text("Company: ${userModel.company!.name}"),
                      Text("Catch Phrase: ${userModel.company!.catchPhrase}"),
                      Text("BS: ${userModel.company!.bs}"),
                    ],
                  ),
                  onTap: () {},
                );
              },
              separatorBuilder: (c, i) {
                return Divider();
              },
            );
          } else {
            return const Center(
              child: Text('No users found.'),
            );
          }
        },
      ),
    );
  }
}
