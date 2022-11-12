import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/recognization_page.dart';
import 'package:ocr/image_cropper.dart';
import 'package:ocr/image_picker.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Recognition',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Text Recognition'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Text recognition'),
        backgroundColor: Colors.yellow,
      ),
      body: Image(image: AssetImage('images/ocr1.jpg')),
      bottomNavigationBar: GNav(
          backgroundColor: Colors.yellow,
          color: Colors.black,
          activeColor: Colors.black,
          hoverColor: Color.fromARGB(255, 236, 210, 241),
          gap: 8,
          tabs: [
            GButton(
                icon: Icons.camera,
                text: 'Camera',
                onPressed: () {
                  log("Camera");
                  pickImage(source: ImageSource.camera).then((value) {
                    if (value != '') {
                      imageCropperView(value, context).then((value) {
                        if (value != '') {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => RecognizePage(
                                path: value,
                              ),
                            ),
                          );
                        }
                      });
                    }
                  });
                }),
            GButton(
              icon: Icons.browse_gallery,
              text: 'Browse Gallery',
              onPressed: () {
                log("Gallery");
                pickImage(source: ImageSource.gallery).then((value) {
                  if (value != '') {
                    imageCropperView(value, context).then((value) {
                      if (value != '') {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => RecognizePage(
                              path: value,
                            ),
                          ),
                        );
                      }
                    });
                  }
                });
              },
            )
          ]),
    );
  }
}
