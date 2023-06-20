import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Constants/k.dart';
import 'package:flutter_api_integration/Day-03%20(users_model)/Model/user_model.dart';
import 'package:http/http.dart' as http;

class UserModelScreen extends StatefulWidget {
  const UserModelScreen({Key? key}) : super(key: key);

  @override
  State<UserModelScreen> createState() => _UserModelScreenState();
}

class _UserModelScreenState extends State<UserModelScreen> {
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
                return _userModelCard(userModel);
              },
              separatorBuilder: (c, i) {
                return const Divider();
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

  ///UserModelCard Method
  Widget _userModelCard(UserModel userModel) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          ListTile(
            onTap: () {},
            leading: CircleAvatar(
              ///userModel.name!.characters.first
              ///This will pick 0 Index Letter of Name
              child: Text(userModel.name!.characters.first),
            ),
            title: SizedBox(
              height: 50,
              width: double.infinity,
              child: Card(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("Name: ${userModel.name}"),
                  ),
                ),
              ),
            ),
            subtitle: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("Username: ${userModel.username}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("Email: ${userModel.email}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("Phone: ${userModel.phone}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("Website: ${userModel.website}"),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Street: ${userModel.address!.street}")),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("Suite: ${userModel.address!.suite}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("City: ${userModel.address!.city}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("Zipcode: ${userModel.address!.zipcode}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("Latitude: ${userModel.address!.geo!.lat}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("Longitude: ${userModel.address!.geo!.lng}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("Company: ${userModel.company!.name}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                          "Catch Phrase: ${userModel.company!.catchPhrase}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("BS: ${userModel.company!.bs}"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
 userModel.name![index],
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
*/