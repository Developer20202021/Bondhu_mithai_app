import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bondhu_mithai_app/Screen/Dashboard/AllCustomer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;












class PaymentAdd extends StatefulWidget {


final SalePrice; 
final CustomerPhoneNumber;
final OrderID;
final CustomerID;




  const PaymentAdd({super.key, required this.SalePrice, required this.CustomerPhoneNumber, required this.OrderID, required this.CustomerID});

  @override
  State<PaymentAdd> createState() => _PaymentAddState();
}

class _PaymentAddState extends State<PaymentAdd> {
  TextEditingController CustomerPhoneNumberController = TextEditingController();
  TextEditingController SalePriceController = TextEditingController();



  bool loading = false;

  var ServerMsg = "";








  Future CustomerPaymentAddFunction(String MoneyReceiverEmail, String MoneyReceiverName) async{

    setState(() {
      loading = true;
    });


    double DuePayment = double.parse(widget.SalePrice) - double.parse(SalePriceController.text.trim().toString());





    CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('CustomerOrderHistory');

  // all Due Query Count
     Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("CustomerPhoneNumber", isEqualTo: widget.CustomerPhoneNumber).where("CustomerType", isEqualTo: "Due");

     QuerySnapshot queryDueSnapshot = await _CustomerOrderHistoryCollectionRefDueQueryCount.get();

    var AllDueData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();















    final docUser =
    FirebaseFirestore.instance.collection('CustomerOrderHistory').doc(widget.OrderID);
   
   
    final CustomerInfo =
    FirebaseFirestore.instance.collection('CustomerInfo').doc(widget.CustomerID);
    
    // Query CustomerOrderHistoryQuery = _collectionRef.where("OrderID", isEqualTo: widget.OrderID).where("CustomerPhoneNumber", isEqualTo: widget.CustomerPhoneNumber);


   


    if (DuePayment <= 0.0) {

      if (AllDueData.length <= 1) {


         var updateCustomerInfo = {

                                "CustomerType":"Paid",

                              };







                // CustomerInfo Collection Update 
                          CustomerInfo.update(updateCustomerInfo).then((value) => setState((){




              

                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);




                          }));



        
      } 

  
    }









        if (DuePayment <= 0.0) {


          
                var updateData ={


                        "CashIn":SalePriceController.text.trim(),
                        "DueAmount":DuePayment.toString(),
                        "CustomerType":"Paid",
                        "OrderStatus":"close",
                        "MoneyReceiverEmail":MoneyReceiverEmail,
                        "MoneyReceiverName":MoneyReceiverName


                      };



                   





                
              // CustomerOrderHistory Collection Update 
                
                          docUser.update(updateData).then((value) => setState((){




                              final snackBar = SnackBar(
                 
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Payment Add Successfull',
                      message:
                          'Hey Thank You. Good Job',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);

              


              
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "")));



                         setState(() {
                            loading = false;
                          });





                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);






                   setState(() {
                            loading = false;
                          });


                          }));













                   



          
        } else {




          
          
                var updateData ={


                        "CashIn":SalePriceController.text.trim(),
                        "DueAmount":DuePayment.toString(),
                        "CustomerType":"Due",
                        "OrderStatus":"close",
                        "MoneyReceiverEmail":MoneyReceiverEmail,
                        "MoneyReceiverName":MoneyReceiverName


                      };






                

                
                          docUser.update(updateData).then((value) => setState((){


                              setState(() {
                                  loading = false;
                                });

                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Payment Add Successfull',
                      message:
                          'Hey Thank You. Good Job',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);

              


              
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "")));








                          })).onError((error, stackTrace) => setState((){


                          setState(() {
                                  loading = false;
                                });

                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);









                          }));














          
        }










  }













  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();

    CustomerPhoneNumberController.text = widget.CustomerPhoneNumber;
    SalePriceController.text = widget.SalePrice;
 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Payment Add",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
                        secondRingColor: Color.fromRGBO(92, 107, 192, 1),
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
               keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Customer Phone No',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Color.fromRGBO(92, 107, 192, 1): Colors.black
            ),
                    hintText: 'Enter Customer Phone No',
            
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
                controller: CustomerPhoneNumberController,
              ),
            
            
            
            
              SizedBox(
                height: 10,
              ),



              TextField(
               keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Amount',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Color.fromRGBO(92, 107, 192, 1): Colors.black
            ),
                    hintText: 'Enter Amount',
            
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
                controller: SalePriceController,
              ),
            
            
            
            
              SizedBox(
                height: 10,
              ),
            
            
            
            
            
            
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 150, child:TextButton(onPressed: () async{

                    setState(() {
                      loading = true;
                    });

            //        final docUser = FirebaseFirestore.instance.collection("admin").doc(myEmailController.text.trim());


            //     var updateData ={


            //       "AdminApprove":"false"
            //     };


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




             












            //         docUser.update(updateData).then((value) =>      Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)),
            //     )).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   backgroundColor: Colors.red,
            //             content: const Text('Something Wrong'),
            //             action: SnackBarAction(
            //               label: 'Undo',
            //               onPressed: () {
            //                 // Some code to undo the change.
            //               },
            //             ),
            //           )));





                     

          












                              CustomerPaymentAddFunction("manager@Gmail.com", "mahadi");






                  }, child: Text("Money Receive", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
          backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(92, 107, 192, 1)),
        ),),),



              




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
    paint.color = Color.fromRGBO(92, 107, 192, 1);
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