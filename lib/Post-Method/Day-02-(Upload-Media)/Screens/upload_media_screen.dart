import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Constants/k.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class UploadMediaScreen extends StatefulWidget {
  const UploadMediaScreen({Key? key}) : super(key: key);

  @override
  State<UploadMediaScreen> createState() => _UploadMediaScreenState();
}

class _UploadMediaScreenState extends State<UploadMediaScreen> {
  ///var
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  bool isLoading = false;

  ///get image
  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      try {
        image = File(pickedFile.path);
        setState(() {});
      } catch (e) {
        AppConsts.showMessage(context, "Error", e.toString());
      }
    } else {
      print("No Image Selected!");
    }
  }

  ///upload image method
  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    try {
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image!.length();
      var uri = Uri.parse("https://fakestoreapi.com/products");
      var request = http.MultipartRequest('post', uri);
      request.fields['title'] = "static title";

      var multipart = http.MultipartFile(
        'image',
        stream,
        length,
      );
      request.files.add(multipart);
      var response = await request.send();
      if (response.statusCode == 200) {
        try {
          setState(() {
            showSpinner = false;
          });
          print("Image Uploaded");
        } catch (e) {
          setState(() {
            showSpinner = false;
          });
          AppConsts.showMessage(context, "Error", e.toString());
        }
      }
    } catch (e) {
      AppConsts.showMessage(context, "Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Upload Media to Server'),
            ),
            bottomNavigationBar: Container(
              child: Row(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton.icon(
                            icon: Icon(Icons.file_copy_outlined),
                            label: Text("Pick Image From Gallery"),
                            onPressed: () {
                              getImage();
                            }))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton.icon(
                            icon: Icon(Icons.upload_outlined),
                            label: Text("Upload Image"),
                            onPressed: () {
                              uploadImage();
                            }))),
              ]),
            ),
            body: isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(children: [
                    Container(
                        child: image == null
                            ? Center(
                                child: Text("pick Image"),
                              )
                            : Container(
                                child: Center(
                                    child: Image.file(
                                        File(image!.path).absolute,
                                        height: 250,
                                        width: 250,
                                        fit: BoxFit.cover)))),
                  ])));
  }
}
