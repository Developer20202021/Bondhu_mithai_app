import 'dart:convert';

import 'package:bondhu_mithai_app/Screen/HomeScreen/FoodUploadScreen/FoodImageUpload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';




class FoodUploadScreen extends StatefulWidget {
  const FoodUploadScreen({super.key});

  @override
  State<FoodUploadScreen> createState() => _FoodUploadScreenState();
}

class _FoodUploadScreenState extends State<FoodUploadScreen> {

    var uuid = Uuid();
 
  TextEditingController FoodSalePriceController = TextEditingController();
  TextEditingController FoodNameController = TextEditingController();
  TextEditingController FoodDiscountPriceController = TextEditingController();
  TextEditingController FoodUnitController = TextEditingController();
  TextEditingController FoodDescriptionController = TextEditingController();
  TextEditingController FoodTagController = TextEditingController();


  




  bool loading = false;

  bool buttonVisible = false;



  bool checkedValue = false;








  @override
  void initState() {
    // TODO: implement initState
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      var FoodID = uuid.v4();

    FocusNode myFocusNode = new FocusNode();
 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Upload Food",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor: Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ): SingleChildScrollView(

        child:  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              
         
            
            
            
              TextField(
               
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Food Name (English)',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Food Name (English)',
            
                    //  enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //     ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                        ),
                    
                    
                    ),
                controller: FoodNameController,
              ),


              SizedBox(height: 9,),

              TextField(
                keyboardType: TextInputType.number,
               
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Food Sale Price',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Food Sale Price',
            
                    //  enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //     ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                        ),
                    
                    
                    ),
                controller: FoodSalePriceController,
              ),




              SizedBox(height: 9,),

              TextField(
                
               
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Food Description',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Food Description',
            
                    //  enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //     ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                        ),
                    
                    
                    ),
                maxLines: 4,
                controller: FoodDescriptionController,
              ),



               SizedBox(height: 9,),

              TextField(
                
               
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Food Tag',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Food Tag',
            
                    //  enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //     ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                        ),
                    
                    
                    ),
                maxLines: 4,
                controller: FoodTagController,
              ),








             


              SizedBox(height: 8,),

             checkedValue? TextField(
                
                keyboardType: TextInputType.number,
               
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Discount Price',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Discount price',
            
                    //  enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //     ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                        ),
                    
                    
                    ),
                controller: FoodDiscountPriceController,
              ):SizedBox(height: 1,),



              SizedBox(height: 8,),




              TextField(
             

               onChanged: (value) {


                if (value.isEmpty || value == null) {

                  setState(() {
                    buttonVisible = false;
                  });
                  
                }

                else{


                   setState(() {
                    buttonVisible = true;
                  });



                }
                



                 print(value);
               },

               
               
               
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Food Unit',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Food Unit',
            
                    //  enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //     ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                        ),
                    
                    
                    ),
                controller: FoodUnitController,
              ),




               CheckboxListTile(
                    title: Text("Discount Available?"),
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue!;
                        print(newValue);
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  ),

            
            
            
            
            
            
            
            
            
            
              SizedBox(
                height: 10,
              ),
            
            
            
            
            
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 150, child:buttonVisible? TextButton(onPressed: () async{

                    setState(() {
                      loading = true;
                    });




                    final FoodTag= FoodTagController.text.trim().toLowerCase();
                    final splitTag= FoodTag.split(',').map((x) => x.trim()).where((element) => element.isNotEmpty).toList();
                    List splitList =[];

                      for (int i = 0; i < splitTag.length; i++){
                        splitList.add(splitTag[i]);
                    }

                    print("_____________________________________________________________________________________${splitList}");






                    final docUser = FirebaseFirestore.instance.collection("foodinfo");


                var FoodData ={

                  "FoodName":FoodNameController.text.trim().toLowerCase(),
                  "FoodSalePrice":FoodSalePriceController.text.trim(),
                  "FoodDiscountPrice":FoodDiscountPriceController.text.trim(),
                  "FoodUnit":FoodUnitController.text.trim(),
                  "FoodID":FoodID.toString(),
                  "DiscountAvailable":checkedValue,
                  "FoodDescription":FoodDescriptionController.text.trim(),
                  "FoodTag":splitList,
                  "FoodPublicVisible":"yes"


               
                };









                 












                    docUser.doc(FoodID).set(FoodData).then((value) =>setState((){



                      loading = false;




                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodImageUpload(FoodID: FoodID,)),
                );





                    })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
                        content: const Text('Something Wrong'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      )));










                  }, child: Text("Upload", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
          backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
        ),):Text(""),),



              




                ],
              )
            
            
            
            ],
          ),
        ),
        ),
      
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xf08f00ff);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
