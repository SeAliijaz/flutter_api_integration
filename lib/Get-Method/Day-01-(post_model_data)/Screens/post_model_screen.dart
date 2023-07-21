import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Constants/k.dart';
import 'package:flutter_api_integration/Get-Method/Day-01-(post_model_data)/Models/posts_model.dart';
import 'package:http/http.dart' as http;

class PostModelScreen extends StatefulWidget {
  const PostModelScreen({Key? key}) : super(key: key);

  @override
  State<PostModelScreen> createState() => _PostModelScreenState();
}

class _PostModelScreenState extends State<PostModelScreen> {
  ///Empty list to fetch and assign
  List<PostsModel> postList = [];

  ///Method to FETCH REST API (POSTS)
  Future<List<PostsModel>> getPostApiMethod() async {
    const String url = "http://jsonplaceholder.typicode.com/posts";

    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());

    try {
      if (response.statusCode == 200) {
        postList.clear();
        for (var i in data) {
          postList.add(PostsModel.fromJson(i));
        }
        return postList;
      } else {
        AppConsts.showMessage(
            context, "Error Message", "Failed to fetch posts");
        debugPrint("Failed to fetch posts");
        throw Exception("Failed to fetch posts");
      }
    } catch (e) {
      AppConsts.showMessage(
        context,
        "Error Message",
        e.toString(),
      );
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Post Data Model'),
        centerTitle: true,
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
