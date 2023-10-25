import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bondhu_mithai_app/Screen/DeliveryMan/AllCustomer.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;













class InputCustomerOTP extends StatefulWidget {


  final OrderID;
  final CustomerPhoneNumber;





  const InputCustomerOTP({super.key, required this.OrderID, required this.CustomerPhoneNumber});

  @override
  State<InputCustomerOTP> createState() => _InputCustomerOTPState();
}

class _InputCustomerOTPState extends State<InputCustomerOTP> {
  TextEditingController CustomerOTPController = TextEditingController();
  TextEditingController CustomerCashInController = TextEditingController();

  // TextEditingController myPassController = TextEditingController();



  bool loading = false;

  var ServerMsg = "";

  var deliveryManTotalMoneyReceive = "0.0";










  List  AllData = [];


  // CollectionReference _collectionRef =
  //   FirebaseFirestore.instance.collection('customer');

Future<void> getData() async {
    // Get docs from collection reference

      CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('DeliveryMan');



    
      Query CustomerOrderHistoryQuery = _collectionRef.where("DeliveryManEmail", isEqualTo: "delivery@gmail.com");



    QuerySnapshot querySnapshot = await CustomerOrderHistoryQuery.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
     if (AllData.length == 0) {
      setState(() {
        deliveryManTotalMoneyReceive = "0.0";
      });
       
     } else {

      setState(() {
     
      AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

      deliveryManTotalMoneyReceive = AllData[0]["Cash"];

      loading = false;
     });
       
     }
     

    print(AllData);
}

























  Future CheckOTP(String CustomerOTP) async{


    setState(() {
      loading = true;
    });



    







   CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('CustomerOrderHistory');


    
      Query CustomerOrderHistoryQuery = _collectionRef.where("OrderID", isEqualTo: widget.OrderID).where("OrderStatus", isEqualTo: "open").where("CustomerOTP", isEqualTo: CustomerOTP);



    QuerySnapshot querySnapshot = await CustomerOrderHistoryQuery.get();

    // Get data from docs and convert map to List
      var AllData = querySnapshot.docs.map((doc) => doc.data()).toList();



     if (AllData.length == 0) {
      setState(() {

        loading = false;




                final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Wrong OTP!!!!',
                      message:
                          'Hey You Add Wrong OTP!!!',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
        
       





      });
       
     } else {






      setState(() async{






      // Customer Order History Database
     
     final docUser = FirebaseFirestore.instance.collection("CustomerOrderHistory").doc(widget.OrderID);







   // Delivery Man Data Call 

       CollectionReference _collectionDeliveryManRef =
                FirebaseFirestore.instance.collection('DeliveryMan');

      Query DeliveryManQuery = _collectionDeliveryManRef.where("DeliveryManEmail",    isEqualTo: "delivery@gmail.com");


      QuerySnapshot DeliveryManQuerySnapshot = await DeliveryManQuery.get();

      List  DeliveryManData = DeliveryManQuerySnapshot.docs.map((doc) => doc.data()).toList();


      
      var deliveryCountString = DeliveryManData[0]["DeliveryCount"];

      int deliveryCountInt = int.parse(deliveryCountString);















        final docDeliveryMan = FirebaseFirestore.instance.collection("DeliveryMan").doc("delivery@gmail.com");


  




                      var updateData ={


                        "OrderStatus":"close",
                        "DeliveryStatus":"DeliveryComplete",
                        "DeliveryManSetOTP":"Done",
                        "CustomerType":"Paid",
                        "MoneyReceiverEmail":"",
                        "MoneyReceiverName":"",
                        "CashIn":CustomerCashInController.text.trim(),
                        "DueAmount":"0.0",
                        "EarningPoint":double.parse(CustomerCashInController.text.trim().toString()) >= 500 ? "1":"0"

                      };




          

            // Update Delivery Man Data

             var updateDeliveryManData = {

              "Cash":double.parse("deliveryManTotalMoneyReceive") + double.parse(CustomerCashInController.text.trim().toString()),

              "DeliveryCount":deliveryCountInt - 1



             };




                  //     FirebaseAuth.instance
                  //       .authStateChanges()
                  //       .listen((User? user) async{
                  //         if (user == null) {
                  //           print('User is currently signed out!');
                  //         } else {





                  //              var AdminMsg = "Dear Admin, ${myEmailController.text.trim()} Admin ${user.email} Admin এর access off করেছে।";



                  // final response = await http
                  //     .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=01713773514&message=${AdminMsg}'));

                  // if (response.statusCode == 200) {
                  //   // If the server did return a 200 OK response,
                  //   // then parse the JSON.
                  //   print(jsonDecode(response.body));
                    
                  
                  // } else {
                  //   // If the server did not return a 200 OK response,
                  //   // then throw an exception.
                  //   throw Exception('Failed to load album');
                  // }
                

                  //         }
                  //       });




                   












             docUser.update(updateData).then((value) => setState((){


                          

                        docDeliveryMan.update(updateData).then((value) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Successfully Delivery Complete.',
                      message:
                          'Hey Thank You. Good Job',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);

              


                    
                  loading = false;

              
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeliveryManCustomers(indexNumber: "")));








                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Wrong OTP!!!!',
                      message:
                          'Hey You Add Wrong OTP!!!',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);









                          }));
















                        

              


              
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeliveryManCustomers(indexNumber: "")));








                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Wrong OTP!!!!',
                      message:
                          'Hey You Add Wrong OTP!!!',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);









                          }));
      
      
      
      
      
     });
       
     }
     

    print(AllData);





  }






  var otpTextField;



  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
























  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();
 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorName().appColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Input Customer OTP",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
                        secondRingColor: ColorName().appColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ): Container(

        child:  CustomPaint(
          painter: CurvePainter(),

     
              
            
            
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            
                    
               
            
            
            
                    TextField(
                      keyboardType: TextInputType.number,
                     
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Customer OTP',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? ColorName().appColor: Colors.black
                  ),
                          hintText: 'Enter Customer OTP',
            
                          //  enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //     ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3, color: ColorName().appColor),
                              ),
                          
                          
                          ),
                          onChanged: (value) {
                            setState(() {
                              otpTextField = value;
                            });
                          },
                      controller: CustomerOTPController,
                    ),
            
            
            
            
                    SizedBox(
                      height: 10,
                    ),



                     TextField(
                      keyboardType: TextInputType.number,
                     
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Customer Cash',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? ColorName().appColor: Colors.black
                  ),
                          hintText: 'Enter Customer Cash',
            
                          //  enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //     ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3, color: ColorName().appColor),
                              ),
                          
                          
                          ),
                          onChanged: (value) {
                            setState(() {
                              otpTextField = value;
                            });
                          },
                      controller: CustomerCashInController,
                    ),
            
            
            
            
            
            
                 CustomerOTPController.text.isEmpty?Text(""):Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 150, child:TextButton(onPressed: () async{

                          CheckOTP(CustomerOTPController.text.trim());

                          

                        }, child: Text("Done", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
              ),),),



                    




                      ],
                    )
            
            
            
                  ],
                ),
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
    paint.color = ColorName().appColor;
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