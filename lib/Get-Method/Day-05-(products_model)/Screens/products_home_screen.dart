import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Constants/k.dart';
import 'package:flutter_api_integration/Get-Method/Day-05-(products_model)/Model/products_model.dart';
import 'package:http/http.dart' as http;

class ProductsHomeScreen extends StatefulWidget {
  const ProductsHomeScreen({Key? key}) : super(key: key);

  @override
  State<ProductsHomeScreen> createState() => _ProductsHomeScreenState();
}

class _ProductsHomeScreenState extends State<ProductsHomeScreen> {
  ///Body loader
  bool isLoading = false;

  ///Method to fetch products
  Future<ProductsModel> fetchProducts() async {
    const String uri =
        "http://webhook.site/c1ac43a5-d4a8-437e-9e6c-b2cd5e76182f";
    final response = await http.get(Uri.parse(uri));
    var data = jsonDecode(response.body.toString());

    try {
      if (response.statusCode == 200) {
        return ProductsModel.fromJson(data);
      } else {
        return ProductsModel.fromJson(data);
      }
    } catch (e) {
      AppConsts.showMessage(context, "Error Message", e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ///Size
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Shop'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())

          /// FutureBuilder<ProductsModel>
          /// future: fetchProducts(),
          : FutureBuilder<ProductsModel>(
              future: fetchProducts(),
              builder: (
                BuildContext context,
                AsyncSnapshot<ProductsModel> snapshot,
              ) {
                ///Connection statuses
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none) {
                  return Center(child: CircularProgressIndicator());
                }

                ///If Snapshot has data then response
                if (snapshot.hasData) {
                  return ListView.builder(
                    /// itemCount: snapshot.data!.data!.length,
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Shop Title
                          _shopInfoCard(size, snapshot, index),

                          ///Product Card
                          Container(
                            height: size.height * 0.3,
                            width: size.width * 1,

                            ///ListView.builder
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,

                              ///fetching_images
                              itemCount:
                                  snapshot.data!.data![index].images!.length,
                              itemBuilder: (
                                BuildContext context,
                                int positionedIndex,
                              ) {
                                ///Here we'll Make UI
                                ///Fethcing Data from Data
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    height: size.height * 0.3,
                                    width: size.width * 1,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,

                                        ///Fetching Image in Background
                                        image: NetworkImage(
                                          snapshot.data!.data![index]
                                              .images![positionedIndex].url
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,

                                        ///Wishlist icon
                                        child: Icon(
                                          snapshot.data!.data![index]
                                                      .inWishlist ==
                                                  false
                                              ? Icons.favorite
                                              : Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("Failed to fetch data"),
                  );
                }
              },
            ),
    );
  }

  Widget _shopInfoCard(
    Size size,
    AsyncSnapshot<ProductsModel> snapshot,
    int index,
  ) {
    return Container(
      height: size.height * 0.1,
      width: size.width,
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                snapshot.data!.data![index].shop!.image.toString()),
          ),
          title: Text(
              "Shop Name: ${snapshot.data!.data![index].shop!.name.toString()}"),
          subtitle: Text(
              "Email: ${snapshot.data!.data![index].shop!.shopemail.toString()}"),
          trailing: Icon(Icons.contact_mail_outlined),
        ),
      ),
    );
  }
}
