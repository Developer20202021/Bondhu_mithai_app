import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;









class FoodImageUpload extends StatefulWidget {



  final FoodID;





  const FoodImageUpload({super.key,  required this.FoodID});

  @override
  State<FoodImageUpload> createState() => _FoodImageUploadState();
}

class _FoodImageUploadState extends State<FoodImageUpload> {


  int count = 0;

  File? _photo;

  String image64 = "";




  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery(Context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);

        final bytes = File(pickedFile.path).readAsBytesSync();

        setState(() {
          image64 = base64Encode(bytes);
        });

        uploadFile(context);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera(Context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(context);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile(Context) async {
    if (_photo == null) return;
    
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    print(_photo!.path);

    try {



         //create multipart request for POST or PATCH method
  //  var request = http.MultipartRequest("POST", Uri.parse("https://api.imgbb.com/1/upload?key=9a7a4a69d9a602061819c9ee2740be89"));




   var request = await http.post(Uri.parse("https://api.imgbb.com/1/upload?key=9a7a4a69d9a602061819c9ee2740be89"),  body: {
          'image':'$image64',
        } ).then((value) => setState((){


          print(jsonDecode(value.body));

          int imageCount = count + 1;

          count = imageCount;


          var serverData = jsonDecode(value.body);

          var serverImageUrl = serverData["data"]["url"];

          print(serverImageUrl);

          updateData(serverImageUrl);





















        })).onError((error, stackTrace) => print(error));



    // if (request.statusCode==200) {

    //   print("Done");
      
    // }

  



 


   //create multipart using filepath, string or bytes
  //  var pic = await http.MultipartFile.fromPath( "profile_pic" ,_photo!.path );
   //add multipart to request
  //  request.files.add(pic);
  
  //  var response = await request.send();


  




  //  Get the response from the server
  //  var responseData = await response.stream.toBytes();
  //  var responseString = String.fromCharCodes(responseData);
  //  print(responseString);
    
   


    } catch (e) {
      print(e);
    }
  }













  Future updateData(String foodImageUrl) async{




         final docUser = FirebaseFirestore.instance.collection("foodinfo").doc(widget.FoodID);

                  final UpadateData ={

                    "foodImageUrl":foodImageUrl

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    print("Done");



                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));



  }








  




  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title:  Text("Upload Food Image ${count}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:  Column(
        children: <Widget>[
          SizedBox(
            height: 12,
          ),



          Container(

            color: Theme.of(context).primaryColor,
            
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("আপনি ${count} টি Image Upload করেছেন।", style: TextStyle(color: Colors.white),),
            )),




            
          SizedBox(height: 25,),






          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 155,
                backgroundColor: Theme.of(context).primaryColor,
                child: _photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          _photo!,
                          width: 400,
                          height: 400,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5)),
                        width: 400,
                        height: 400,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          ),

          SizedBox(height: 15,),



          


           SizedBox(height: 15,),





            
        



          Container(

            color: Color.fromARGB(255, 245, 201, 42),
            
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("আপনি একাধিক Image Select করতে পারেন। আপনার Image Selection শেষ হলে Done Button এ Click করুন।", style: TextStyle(color: Colors.black),),
            )),


        



          
        ],
      ),)),
                 
                  
                  );
  }




  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

}


