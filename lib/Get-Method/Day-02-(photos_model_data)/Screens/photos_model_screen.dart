import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Constants/k.dart';
import 'package:flutter_api_integration/Get-Method/Day-02-(photos_model_data)/Models/photos_model.dart';
import 'package:http/http.dart' as http;

class PhotosModelScreen extends StatefulWidget {
  const PhotosModelScreen({Key? key}) : super(key: key);

  @override
  State<PhotosModelScreen> createState() => _PhotosModelScreenState();
}

class _PhotosModelScreenState extends State<PhotosModelScreen> {
  List<PhotosModel> photosList = [];

  ///Method
  Future<List<PhotosModel>> getPhotosModel() async {
    const String uri = "http://jsonplaceholder.typicode.com/photos";
    final response = await http.get(Uri.parse(uri));
    final data = jsonDecode(response.body.toString());
    try {
      debugPrint(data);
      if (response.statusCode == 200) {
        for (Map<String, dynamic> i in data) {
          PhotosModel photos = PhotosModel(
            id: i["id"],
            albumId: i["albumId"],
            title: i["title"],
            url: i["url"],
            thumbnailUrl: i["thumbnailUrl"],
          );
          photosList.add(photos);
        }
        return photosList;
      } else {
        return photosList;
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
        title: const Text('Photos Model Screen'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<PhotosModel>>(
        future: getPhotosModel(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<PhotosModel>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final List<PhotosModel> imageList = snapshot.data!;
          return ListView.builder(
            itemCount: imageList.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(imageList[index].url.toString()),
                ),
                title: Text("Title: ${imageList[index].title.toString()}"),
                subtitle: Text(
                  "AlbumID: ${imageList[index].albumId.toString()} & ID: ${imageList[index].id.toString()}",
                ),
              );
            },
          );
        },
      ),
    );
  }
}
