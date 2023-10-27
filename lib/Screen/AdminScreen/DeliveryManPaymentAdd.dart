import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bondhu_mithai_app/Screen/AdminScreen/AllDeliveryMan.dart';
import 'package:bondhu_mithai_app/Screen/FrontScreen/CreateAccountScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';



class DeliveryManPaymnetAdd extends StatefulWidget {


  final TotalCash;
  final DeliveryManEmail;





  const DeliveryManPaymnetAdd({super.key, required this.DeliveryManEmail, required this.TotalCash});

  @override
  State<DeliveryManPaymnetAdd> createState() => _DeliveryManPaymnetAddState();
}

class _DeliveryManPaymnetAddState extends State<DeliveryManPaymnetAdd> {
  TextEditingController TotalCashController = TextEditingController();
  TextEditingController CashController = TextEditingController();


    var uuid = Uuid();
    bool loading = false;








   Future UpdateDeliveryManData(String PaymentID) async{


    setState(() {
      loading = true;
    });



    
final DeliveryManInfo =
    FirebaseFirestore.instance.collection('DeliveryMan').doc(widget.DeliveryManEmail);


  var  DeliveryManData = {

    "Cash":(double.parse(widget.TotalCash)-double.parse(CashController.text.trim()))>=0?(double.parse(widget.TotalCash)-double.parse(CashController.text.trim())):0.0

    };



  final CustomerInfo =
    FirebaseFirestore.instance.collection('DeliveryManCashReceive');


                    var data = {
                      "PaymentID":PaymentID,
                      "DeliveryManEmail":widget.DeliveryManEmail,
                      "CashReceive":CashController.text.trim(),
                      "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                      "Time":"${DateTime.now().toIso8601String()}"


                    };





                      // CustomerInfo Collection Update 
                          CustomerInfo.doc(PaymentID).set(data).then((value) => setState((){


                            print("Done");










                                     // CustomerInfo Collection Update 
                          DeliveryManInfo.update(DeliveryManData).then((value) => setState((){


                            setState(() {
                                  loading = false;
                                });



                  AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Paymnet Add Successfull',
                        desc: 'আপনার Payment Receive সফল হয়েছে।ধন্যবাদ',
                        
                        btnOkOnPress: () {

                        
                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AllDeliveryMan()),
                              );

                        },
                        )..show();




              

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










  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();
    
    var PaymentID = uuid.v4();
 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.purple),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Delivery Man Cash Receive", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        
      ),
      body:loading?Padding(
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
            
              
              // Center(
              //   child: Lottie.asset(
              //   'lib/images/animation_lk8fkoa8.json',
              //     fit: BoxFit.cover,
              //     width: 200,
              //     height: 200
              //   ),
              // ),
            
            SizedBox(
                height: 20,
              ),
            
            
            
              TextField(
                enabled: false,

                keyboardType: TextInputType.number,
                focusNode: myFocusNode,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Total Cash: ${widget.TotalCash}৳',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Colors.purple: Colors.black
            ),
                    hintText: 'Total Cash',
            
                    //  enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //     ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.purple),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                        ),
                    
                    
                    ),
                controller: TotalCashController,
              ),
            
            
            
            
              SizedBox(
                height: 20,
              ),
            
            
            
            
            
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Cash',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Colors.purple: Colors.black
            ),
                    hintText: 'Enter Cash',
                    //  enabledBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //   ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    
                    
                    ),
                controller: CashController,
              ),
            
              SizedBox(
                height: 10,
              ),
            
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 150, child:TextButton(onPressed: () async{


                    UpdateDeliveryManData(PaymentID);




                  }, child: Text("Receive", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
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
    paint.color = Colors.purple;
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

