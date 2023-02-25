import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllImages extends StatefulWidget {
  const AllImages({Key? key}) : super(key: key);

  @override
  _AllImagesState createState() => _AllImagesState();
}

class _AllImagesState extends State<AllImages> {
  // late List<Welcome>? _userModel = [];
  List data = [];
  List<String> imgUrl = [];
  bool showimage = false;
  @override
  void initState() {
    super.initState();
    // _getData();
    // getData();
  }

  getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.unsplash.com/photos?client_id=GjfWCbe_J4SIBXKk1D1VfG5uPFXiKQxwFjFyg63e964"));
    data = json.decode(response.body);
    _assign();
    setState(() {
      showimage = true;
    });

    print(data);
  }

  _assign() {
    // print(data.elementAt(1)["urls"]["regular"]);
    for (var i = 0; i < data.length; i++) {
      imgUrl.add(data.elementAt(i)["urls"]["regular"]);
      // data.elementAt(i)["urls"]["regular"];
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                    elevation: 3,
                    child: !showimage
                        ? CircularProgressIndicator()
                        : Image(image: NetworkImage(imgUrl.elementAt(index)))),
              ],
            ),
          );
        });
  }
}
