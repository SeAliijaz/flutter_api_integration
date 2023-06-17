import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Constants/k.dart';
import 'package:flutter_api_integration/Day-01%20(post_model_data)/Models/posts_model.dart';
import 'package:http/io_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Empty list to fetch and assign
  List<PostsModel> postList = [];

  ///Method to FETCH REST API (POSTS)
  Future<List<PostsModel>> getPostApiMethod() async {
    const String url = "https://jsonplaceholder.typicode.com/posts";

    // Create an HttpClient instance with certificate verification disabled
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    // Create an IOClient using the custom HttpClient
    final ioClient = IOClient(httpClient);

    final response = await ioClient.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postList.clear();
      for (var i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      AppConsts.showMessage("Failed to fetch posts");
      debugPrint("Failed to fetch posts");
      throw Exception("Failed to fetch posts");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Post Data Model'),
      ),
      body: FutureBuilder<List<PostsModel>>(
        future: getPostApiMethod(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PostsModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            ///ListView.separated to Display data
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(color: Colors.grey, thickness: 1);
              },
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final value = snapshot.data![index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(5.0),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Id: ${value.id}"),
                      Text("Uid: ${value.userId}"),
                    ],
                  ),
                  title: Text("Title: ${value.title}"),
                  subtitle: Text("Body: ${value.body}"),
                  trailing: const Icon(Icons.message_outlined),
                );
              },
            );
          }
        },
      ),
    );
  }
}
