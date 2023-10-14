import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';





class SendSMSToDueCustomer extends StatefulWidget {


  final CustomerNID;
  final CustomerPhoneNumber;
  final BikePaymentDue;
  final BikeDuePaymentGivingDay;
  
  const SendSMSToDueCustomer({super.key, required this.CustomerNID, required this.CustomerPhoneNumber, required this.BikePaymentDue, required this.BikeDuePaymentGivingDay});

  @override
  State<SendSMSToDueCustomer> createState() => _SendSMSToDueCustomerState();
}

class _SendSMSToDueCustomerState extends State<SendSMSToDueCustomer> {
  TextEditingController DueCustomerMsgController = TextEditingController();
  TextEditingController myPassController = TextEditingController();

  bool loading = false;

  var msgSend = '';





   

  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();

 
  DueCustomerMsgController.text = "Dear Customer,Kalai Tvs Center ${widget.CustomerPhoneNumber} Ac No. এ ${widget.BikePaymentDue}৳ টাকা বকেয়া আছে। ${widget.BikeDuePaymentGivingDay}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()} তারিখের মধ্যে পরিশোধ করুন। ধন্যবাদ";

   









 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Send Message",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: const Color(0xFF1A1A3F),
          secondRingColor: Theme.of(context).primaryColor,
          thirdRingColor: Colors.white,
          size: 100,
        ),
      ):Container(

        child:  CustomPaint(
          painter: CurvePainter(),

     
              
            
            
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            
                    
               
            
            msgSend == "success"?
            
                    Center(
                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                    
                    
                                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check, color: Colors.green,),
                          Text("Message Sent Successfull!!!"),
                        ],
                      ),
                                      ),
                       
                                   decoration: BoxDecoration(
                                    color: Colors.red[100],
                    
                                    border: Border.all(
                            width: 2,
                            color: Colors.white

                            
                          ),
                                    borderRadius: BorderRadius.circular(10)      
                                   ),)),
                    ):Text(""),




                    msgSend == "fail"?
            
                    Center(
                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                    
                    
                                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.close, color: Colors.red,),
                          Text("Message Sent Fail!!!"),
                        ],
                      ),
                                      ),
                       
                                   decoration: BoxDecoration(
                                    color: Colors.red[100],
                    
                                    border: Border.all(
                            width: 2,
                            color: Colors.white

                            
                          ),
                                    borderRadius: BorderRadius.circular(10)      
                                   ),)),
                    ):Text(""),
            
            
            
            
            
            
            
            
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Message',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Your Message',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: DueCustomerMsgController,
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


                          Future SendSMSToCustomer(context, String CustomerNID, String CustomerPhoneNumber, String BikePaymentDue, String DueCustomerMsg) async {




                            final response = await http
                                .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=${CustomerPhoneNumber}&message=${DueCustomerMsg}'));

                                    Navigator.pop(context);

                            if (response.statusCode == 200) {
                              // If the server did return a 200 OK response,
                              // then parse the JSON.
                              print(jsonDecode(response.body));
                              setState(() {
                                msgSend = "success";
                                loading = false;
                              });
                            
                            } else {

                               setState(() {
                                msgSend = "fail";
                                loading = false;
                              });
                              // If the server did not return a 200 OK response,
                              // then throw an exception.
                              throw Exception('Failed to load album');
                            }
                          }


                          SendSMSToCustomer(context, widget.CustomerNID, widget.CustomerPhoneNumber, widget.BikePaymentDue, DueCustomerMsgController.text);



                        }, child: Text("Send", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
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




