import 'package:bondhu_mithai_app/Screen/HomeScreen/TableOrder/TableStructure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';

class TableOrder extends StatefulWidget {
  const TableOrder({super.key});

  @override
  State<TableOrder> createState() => _TableOrderState();
}

class _TableOrderState extends State<TableOrder> {

  var uuid = Uuid();
      
  bool loading = false;

  List  AllData = [];

  bool  ButtonVisibleBool = true;


  TextEditingController CustomerNameController = TextEditingController();

  TextEditingController CustomerPhoneNumberController = TextEditingController();

  TextEditingController CustomerPersonNumberController = TextEditingController();










  @override
  Widget build(BuildContext context) {

     var CustomerID = uuid.v4();





    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.purple),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: const Text(
            "Book Your Table",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
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
              ):SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                  // Center(
                  //     child: Lottie.asset(
                  //     'lib/images/animation_lk8g4ixk.json',
                  //       fit: BoxFit.cover,
                  //       width: 300,
                  //       height: 200
                  //     ),
                  //   ),


                    SizedBox(
                                    height: 20,
                                  ),

                                  // Name Section
                                  TextField(
                                    controller: CustomerNameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Customer Name',

                                      hintText: 'Enter Customer Name',

                                      //  enabledBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                      //     ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.purple),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Color.fromARGB(
                                                255, 66, 125, 145)),
                                      ),
                                    ),
                                  ),


                    

                             SizedBox(
                                    height: 20,
                                  ),

                                  // Name Section
                                  TextField(
                                    keyboardType: TextInputType.phone,
                                    controller: CustomerPhoneNumberController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Customer Phone No',

                                      hintText: 'Enter Customer Phone No',

                                      //  enabledBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                      //     ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.purple),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Color.fromARGB(
                                                255, 66, 125, 145)),
                                      ),
                                    ),
                                  ),



                                  SizedBox(
                                    height: 20,
                                  ),

                                  

                                  // Name Section
                                  TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        ButtonVisibleBool = CustomerPersonNumberController.text.trim().isEmpty;
                                      });
                                    },
                                    controller: CustomerPersonNumberController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Customer Person No',

                                      hintText: 'Enter Customer Person No',

                                      //  enabledBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                      //     ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.purple),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Color.fromARGB(
                                                255, 66, 125, 145)),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 14,),

                                  Container(
                                  margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.purple)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("Choose Booking Date",style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 16),),
                                      SfDateRangePicker(),
                                    ],
                                  ),
                                ),
                              ),


                              SizedBox(height: 14,),


                              ButtonVisibleBool?Text(""):Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                            width: 150,
                                            child: TextButton(
                                              onPressed: () async{










            setState(() {
                      loading = true;
                    });


          try {
            
       

        final docUser = FirebaseFirestore.instance.collection("CustomerInfo");
        final CustomerOrderHistoryCollection = FirebaseFirestore.instance.collection("CustomerOrderHistory");


        Query query = docUser.where("CustomerPhoneNumber", isEqualTo: "${CustomerPhoneNumberController.text.trim().toLowerCase()}");
            QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
         AllData = querySnapshot.docs.map((doc) => doc.data()).toList();


        if (AllData.length == 0) {



          
                var CustomerData ={

                  "CustomerName":CustomerNameController.text.trim().toLowerCase(),
                  "CustomerPhoneNumber":CustomerPhoneNumberController.text.trim().toLowerCase(),
                  "FirstOrderDate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  "FirstOrderTime":"${DateTime.now().toLocal().toIso8601String()}",
                  "FirstOrderMonth":"${DateTime.now().month}",
                  "FirstOrderYear":"${DateTime.now().year}",
                  "CustomerID":CustomerID,
                  "CustomerImageURL":"https://e7.pngegg.com/pngimages/18/809/png-clipart-user-computer-icons-person-icon-cdr-logo-thumbnail.png",
                  "CustomerType":"Due",
                  "CustomerEmail":"customer@customer.com",
                  

           
                };


                
                var CustomerOrderHistory ={

                  "CustomerName":CustomerNameController.text.trim().toLowerCase(),
                  "CustomerPhoneNumber":CustomerPhoneNumberController.text.trim().toLowerCase(),
                  "CustomerPersonNumber":CustomerPersonNumberController.text.trim().toLowerCase(),
                  "OrderDate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  "OrderTime":"${DateTime.now().toLocal().toIso8601String()}",
                  "OrderMonth":"${DateTime.now().month}",
                  "OrderYear":"${DateTime.now().year}",
                  "CustomerID":CustomerID,
                  "OrderType":"offline",
                  "OrderStatus":"open",
                  "CustomerType":"Due"
           
                };





         CustomerOrderHistoryCollection.doc(CustomerID).set(CustomerOrderHistory).then((value) =>setState((){



                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TableStructure()),
                // );





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





          docUser.doc(CustomerID).set(CustomerData).then((value) =>setState((){



                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TableStructure(CustomerID: CustomerID, CustomerName: CustomerNameController.text.trim().toLowerCase(), CustomerPhoneNumber: CustomerPhoneNumberController.text.trim().toLowerCase(),)),
                );


                    setState(() {
                      loading = false;
                    });



                   CustomerNameController.clear();
                    CustomerPhoneNumberController.clear();
                    CustomerPersonNumberController.clear();


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



          
      
       
           } else {

            




                var CustomerOrderHistory ={

                  "CustomerName":CustomerNameController.text.trim().toLowerCase(),
                  "CustomerPhoneNumber":CustomerPhoneNumberController.text.trim().toLowerCase(),
                  "CustomerPersonNumber":CustomerPersonNumberController.text.trim().toLowerCase(),
                  "OrderDate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  "OrderTime":"${DateTime.now().toLocal().toIso8601String()}",
                  "OrderMonth":"${DateTime.now().month}",
                  "OrderYear":"${DateTime.now().year}",
                  "CustomerID":CustomerID,
                  "OrderType":"offline",
                  "OrderStatus":"open",
                  "CustomerType":"Due"
           
                };


          
      



                
         CustomerOrderHistoryCollection.doc(CustomerID).set(CustomerOrderHistory).then((value) =>setState((){



                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TableStructure(CustomerID: CustomerID, CustomerName: CustomerNameController.text.trim().toLowerCase(), CustomerPhoneNumber: CustomerPhoneNumberController.text.trim().toLowerCase(),)),
                );


                    setState(() {
                      loading = false;
                    });

                    CustomerNameController.clear();
                    CustomerPhoneNumberController.clear();
                    CustomerPersonNumberController.clear();





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




      
       }


          } catch (e) {
            
          }










      





























                                              },
                                              child: Text(
                                                "Next",
                                                style:
                                                    TextStyle(color: Colors.white),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll<Color>(
                                                        Colors.purple),
                                              ),
                                            ),
                                          ),
                                ],
                              ),




              ]))));
  }
}