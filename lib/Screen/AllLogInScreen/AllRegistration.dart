import 'dart:convert';

import 'package:bondhu_mithai_app/Screen/AllRegistrationScreen/AdminRegistration.dart';
import 'package:bondhu_mithai_app/Screen/AllRegistrationScreen/DeliveryManRegistration.dart';
import 'package:bondhu_mithai_app/Screen/AllRegistrationScreen/ManagerRegistration.dart';
import 'package:bondhu_mithai_app/Screen/AllRegistrationScreen/StaffRegistration.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/Settings/ChangePassword.dart';
import 'package:bondhu_mithai_app/Screen/Settings/DeliveryFeeChange.dart';
import 'package:bondhu_mithai_app/Screen/Settings/SendSMSToAllCustomer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';





class AllRegistration extends StatefulWidget {
  const AllRegistration({super.key});

  @override
  State<AllRegistration> createState() => _AllRegistrationState();
}

class _AllRegistrationState extends State<AllRegistration> {

  bool loading = false;














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("All Registration",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
                        secondRingColor:  Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ):SingleChildScrollView(child: Center(
        child: Column(
      
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
      
      
          children: [








                SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Admin Registration", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminRegistration()));
                
                
                
                
                
                
                
                                            }, child: Text("Registration", style: TextStyle(color: Color.fromARGB(255, 242,133,0)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: Color.fromARGB(255, 242,133,0),
                
                  border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 242,133,0)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
      

      
      
      







  SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Manager Registration", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ManagerRegistration()));
                
                
                
                
                
                
                
                                            }, child: Text("Registration", style: TextStyle(color: ColorName().appColor),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: ColorName().appColor,
                
                  border: Border.all(
                            width: 2,
                            color: ColorName().appColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),







            


            
  SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Staff Registration", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StaffRegistration()));
                
                
                
                
                
                
                
                                            }, child: Text("Registration", style: TextStyle(color: const Color.fromARGB(255,12, 53, 106)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: Color.fromARGB(255,12, 53, 106),
                
                  border: Border.all(
                            width: 2,
                            color:Color.fromARGB(255,12, 53, 106)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
      

      

      SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Delivery Man Registration", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>DeliveryManRegistration()));
                
                
                
                
                
                
                
                                            }, child: Text("Registration", style: TextStyle(color: const Color.fromARGB(255,12, 53, 106)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: Color.fromARGB(255,12, 53, 106),
                
                  border: Border.all(
                            width: 2,
                            color:Color.fromARGB(255,12, 53, 106)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
      

      
      
      






      
      










      
      
          ],
      
      
      
      
      
      
        ),
      )));

  }
}