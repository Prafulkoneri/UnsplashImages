// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/view/Login/sign_in.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class UserMain extends StatefulWidget {
//   UserMain({Key? key}) : super(key: key);

//   @override
//   _UserMainState createState() => _UserMainState();
// }

// class _UserMainState extends State<UserMain> {
//   final storage = FlutterSecureStorage();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Welcome User"),
//               ElevatedButton(
//                 onPressed: () async => {
//                   await FirebaseAuth.instance.signOut(),
//                   await storage.delete(key: "uid"),
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Login(),
//                       ),
//                       (route) => false)
//                 },
//                 child: Text('Logout'),
//                 style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
//               )
//             ],
//           ),
//         ),
//         body: Center(
//           child: Text("ghefghaghafgh"),
//         ));
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/image_model.dart';
import 'package:flutter_application_1/view/All_images/all_images.dart';
import 'package:flutter_application_1/view/Serach_image/search.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Login/sign_in.dart';

class ShowImages extends StatefulWidget {
  @override
  _ShowImagesState createState() => _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages> {
  @override
  void initState() {
    super.initState();
    bloc.init();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Welcome User"),
            ElevatedButton(
              onPressed: () async => {
                await FirebaseAuth.instance.signOut(),
                await storage.delete(key: "uid"),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false)
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            )
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter a word',
                        suffixIcon: Icon(Icons.search)),
                    onChanged: (value) {
                      bloc.changeQuery(value);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: StreamBuilder(
                    stream: bloc.photosList,
                    builder: (context, AsyncSnapshot<Photos> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.results.length,
                            itemBuilder: (context, index) {
                              return listItem(snapshot.data!.results[index]);
                            });
                      } else {
                        return Center(
                          child: AllImages(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(Result result) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10.0,
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Image.network(result.urls.regular),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                // ClipRRect(
                //   child: FadeInImage(
                //       width: 30,
                //       height: 30,
                //       placeholder: '',
                //       image: result.user.profileImage.medium),
                //   borderRadius: BorderRadius.circular(25.0),
                // ),

                SizedBox(width: 10.0),
                Text(result.user.name),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    bloc.shareImage(result.urls.regular);
                  },
                  child: Icon(Icons.share, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
