import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TableOrder extends StatefulWidget {
  const TableOrder({super.key});

  @override
  State<TableOrder> createState() => _TableOrderState();
}

class _TableOrderState extends State<TableOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.purple),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: Center(
            child: const Text(
              "Book Your Table",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                  Center(
                      child: Lottie.asset(
                      'lib/images/animation_lk8g4ixk.json',
                        fit: BoxFit.cover,
                        width: 300,
                        height: 200
                      ),
                    ),


                    SizedBox(
                                    height: 20,
                                  ),

                                  // Name Section
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Name',

                                      hintText: 'Enter Your Name',

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
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Phone Number',

                                      hintText: 'Enter Your Phone Number',

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
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Person Number',

                                      hintText: 'Enter Your Person Number',

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


                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                            width: 150,
                                            child: TextButton(
                                              onPressed: () {},
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