import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepal_bank/HomePage/TextFieldContainer.dart';

class DepositCheck extends StatefulWidget {
  @override
  _DepositCheckState createState() => _DepositCheckState();
}

class _DepositCheckState extends State<DepositCheck> {
  File _image;
  File _image2;
  final picker = ImagePicker();

  Future getImage() async {
    final pickerImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickerImage != null) {
        _image = File(pickerImage.path);
      } else {
        print('no image selected');
      }
    });
  }

  Future getImage2() async {
    final pickerImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickerImage != null) {
        _image2 = File(pickerImage.path);
      } else {
        print('no image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Deposit'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFieldContainer(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.mode_comment_outlined,
                          color: Colors.deepPurple,
                        ),
                        hintText: 'Check Number',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFieldContainer(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.payments,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      child: FloatingActionButton.extended(
                        heroTag: 'btn1',
                        label: Text('Front Side'),
                        backgroundColor: Colors.deepPurple[200],
                        onPressed: () {
                          getImage();
                        },
                        icon: Icon(Icons.camera_alt),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      child: FloatingActionButton.extended(
                        heroTag: 'btn2',
                        label: Text('Back Side'),
                        backgroundColor: Colors.deepPurple[200],
                        onPressed: () {
                          getImage2();
                        },
                        icon: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: _image == null ? null : Image.file(_image),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                      child: _image2 == null ? null : Image.file(_image2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'btn3',
        label: Text('Deposit'),
        backgroundColor: Colors.deepPurple[200],
        onPressed: () {},
        icon: Icon(Icons.download_outlined),
      ),
    );
  }
}
