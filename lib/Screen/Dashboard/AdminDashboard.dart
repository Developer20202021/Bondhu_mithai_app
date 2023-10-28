import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:popover/popover.dart';


class AdminDashboard extends StatefulWidget {

  final userName;
  final userEmail;
  final indexNumber;
  



  const AdminDashboard({super.key, required this.userName, required this.userEmail, required this.indexNumber});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {








   // Firebase All Customer Data Load

List  AllDueCustomerData = [];




Future<void> getDueCustomerData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

  CollectionReference _collectionDueCustomerRef =
    FirebaseFirestore.instance.collection('CustomerInfo');
    Query DueCustomerquery = _collectionDueCustomerRef.where("CustomerType", isEqualTo: "Due");
    QuerySnapshot DueCustomerquerySnapshot = await DueCustomerquery.get();

    // Get data from docs and convert map to List
     AllDueCustomerData = DueCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllDueCustomerData = DueCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();
     });

    // print(AllData);
}





 // Firebase All Customer Data Load

List  AllPaidCustomerData = [];




Future<void> getPaidCustomerData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

  CollectionReference _collectionPaidCustomerRef =
    FirebaseFirestore.instance.collection('CustomerInfo');
    Query PaidCustomerquery = _collectionPaidCustomerRef.where("CustomerType", isEqualTo: "Paid");
    QuerySnapshot PaidCustomerquerySnapshot = await PaidCustomerquery.get();

    // Get data from docs and convert map to List
     AllPaidCustomerData = PaidCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllPaidCustomerData = PaidCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();
     });

    // print(AllData);
}



















  var PaymentDate = "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";


    
  // Firebase All Customer Data Load

List  AllData = [0];
    int moneyAdd = 0;

  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('DuePaymentAddInfo');

Future<void> getData(String paymentDate) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    Query query = _collectionRef.where("PaymentDate", isEqualTo: paymentDate);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();


     moneyAdd = 0;

     for (var i = 0; i < AllData.length; i++) {

       var money = AllData[i]["Amount"];
      int moneyInt = int.parse(money);

      

      setState(() {
        moneyAdd = moneyAdd + moneyInt;
      });
       
     }

     print(moneyAdd);

     setState(() {
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
     });

    print(AllData);
}


















   var DataLoad = ""; 
  // Firebase All Customer Data Load









List  AllCustomerOrderData = [];
double CustomerOrderMoneyAdd = 0.0;



// box add হয় নাই। 

Future<void> getPerDaySalesData(String OrderDate) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
  CollectionReference _CustomerOrdercollectionRef =
    FirebaseFirestore.instance.collection('CustomerOrderHistory');

    Query CustomerOrderQuery = _CustomerOrdercollectionRef.where("OrderDate", isEqualTo: OrderDate);
    QuerySnapshot CustomerOrderQuerySnapshot = await CustomerOrderQuery.get();

    // Get data from docs and convert map to List
     AllCustomerOrderData = CustomerOrderQuerySnapshot.docs.map((doc) => doc.data()).toList();


     CustomerOrderMoneyAdd = 0.0;




     if (AllCustomerOrderData.length == 0) {
       setState(() {
        DataLoad = "0";
      });
       
     } else {

      setState(() {
        DataLoad = "";
      });

      for (var i = 0; i < AllCustomerOrderData.length; i++) {

       var money = AllData[i]["TotalFoodPrice"];
      double moneydouble = double.parse(money);

      

      setState(() {
        CustomerOrderMoneyAdd = CustomerOrderMoneyAdd + moneydouble;
           AllCustomerOrderData = CustomerOrderQuerySnapshot.docs.map((doc) => doc.data()).toList();
      });
       
     }

    //  print(moneyAdd);
       
     }



}
















List  AllOnlineCustomerOrderData = [];
double OnlineCustomerOrderMoneyAdd = 0.0;



// box add হয় নাই। 

Future<void> getPerDayOnlineSalesData(String OrderDate) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
  CollectionReference _CustomerOrdercollectionRef =
    FirebaseFirestore.instance.collection('CustomerOrderHistory');

    Query CustomerOrderQuery = _CustomerOrdercollectionRef.where("OrderDate", isEqualTo: OrderDate).where("OrderType", isEqualTo: "online");
    QuerySnapshot CustomerOrderQuerySnapshot = await CustomerOrderQuery.get();

    // Get data from docs and convert map to List
     AllOnlineCustomerOrderData = CustomerOrderQuerySnapshot.docs.map((doc) => doc.data()).toList();


     OnlineCustomerOrderMoneyAdd = 0.0;




     if (AllOnlineCustomerOrderData.length == 0) {
       setState(() {
        DataLoad = "0";
      });
       
     } else {

      setState(() {
        DataLoad = "";
      });

      for (var i = 0; i <  AllOnlineCustomerOrderData.length; i++) {

       var money = AllData[i]["TotalFoodPrice"];
      double moneydouble = double.parse(money);

      

      setState(() {
        OnlineCustomerOrderMoneyAdd = OnlineCustomerOrderMoneyAdd + moneydouble;
           AllOnlineCustomerOrderData = CustomerOrderQuerySnapshot.docs.map((doc) => doc.data()).toList();
      });
       
     }

    //  print(moneyAdd);
       
     }



}

















@override
  void initState() {
    // TODO: implement initState
    getPaidCustomerData();
    getPerDaySalesData(PaymentDate);
    getDueCustomerData();
    getData(PaymentDate);
    super.initState();





  
    

  // FlutterNativeSplash.remove();
  
  
  }











  
  Future refresh() async{


    setState(() {
      
    getPaidCustomerData();
    getDueCustomerData();
    getData(PaymentDate);

    });




  }




















  @override
  Widget build(BuildContext context) {


    return Scaffold(


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
      
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [


           widget.indexNumber == "1"?
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.home_sharp,
                  color: Colors.white,
                  size: 55,
                  fill: 1.0,
                ),
              ): IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.home_sharp,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2",)));


                },
                icon: const Icon(
                  Icons.electric_bike_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)));



                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),



              IconButton(
                enableFeedback: false,
                onPressed: () {

                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "4")));




                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),),
      ),







      backgroundColor: Colors.white,
      
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
       automaticallyImplyLeading: false,
        title: const Text("Dashboard", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        actions: [



          PopupMenuButton(
          onSelected: (value) {
            // your logic
          },
          itemBuilder: (BuildContext context) {
            return  [


               PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen()));




                },
                child: Center(
                  child: Column(
                    children: [
                    Center(
                      child:  CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png",
                        ),
                      ),
                    ),


                    Text("Name:${widget.userName}"),
                    Text("Email:${widget.userEmail}"),




                    ],
                  ),
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





              PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2",)));




                },
                child: Row(
                  children: [
                    Icon(Icons.electric_bike),
                    SizedBox(width: 5,),
                    Text("All Bikes"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





               PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "4")));




                },
                child: Row(
                  children: [
                    Icon(Icons.person_4),
                    SizedBox(width: 5,),
                    Text("All Customers"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





               PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DueCustomer()));




                },
                child: Row(
                  children: [
                    Icon(Icons.person_3_rounded),
                    SizedBox(width: 5,),
                    Text("Due Customers"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),








              
               PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDuePaymentAddHistory()));


                },
                child: Row(
                  children: [
                    Icon(Icons.payment),
                    SizedBox(width: 5,),
                    Text("Today Due Add"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),






              PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerMonthDuePaymentAddHistory()));




                },
                child: Row(
                  children: [
                    Icon(Icons.payments_rounded),
                    SizedBox(width: 5,),
                    Text("Monthly Due Add"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),











              
               PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDueCustomer()));




                },
                child: Row(
                  children: [
                    Icon(Icons.person_4),
                    SizedBox(width: 5,),
                    Text("Today Due Customers"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),






               



              
                 PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDaySalesHistory()));




                },
                child: Row(
                  children: [
                    Icon(Icons.sell),
                    SizedBox(width: 5,),
                    Text("Today Sales"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),



               PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerMonthSalesHistory()));




                },
                child: Row(
                  children: [
                    Icon(Icons.sell_sharp),
                    SizedBox(width: 5,),
                    Text("Monthly Sales"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),



              PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>PerMonthNagadBillPay()));




                },
                child: Row(
                  children: [
                    Icon(Icons.account_balance_rounded),
                    SizedBox(width: 5,),
                    Text("Monthly Cash"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),










               PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AccessoriesScreen()));




                },
                child: Row(
                  children: [
                    Icon(Icons.preview_outlined),
                    SizedBox(width: 5,),
                    Text("Accessories"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),














                  PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => UploadProduct()));




                },
                child: Row(
                  children: [
                    Icon(Icons.upload),
                    SizedBox(width: 5,),
                    Text("Upload Bike"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),




               PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => UploadAccessories()));




                },
                child: Row(
                  children: [
                    Icon(Icons.upload_file),
                    SizedBox(width: 5,),
                    Text("Upload Accessories"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              




              PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerMonthAccessoriesSalesHistory()));




                },
                child: Row(
                  children: [
                    Icon(Icons.history),
                    SizedBox(width: 5,),
                    Text("Accessories Sales"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



              

              


              

              


              



                PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)));




                },
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings),
                    SizedBox(width: 5,),
                    Text("All Admin"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



          PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MakeAdmin()));




                },
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings),
                    SizedBox(width: 5,),
                    Text("Make Admin"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



               PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword()));




                },
                child: Row(
                  children: [
                    Icon(Icons.password),
                    SizedBox(width: 5,),
                    Text("Change Password"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





                PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SMSInfo()));




                },
                child: Row(
                  children: [
                    Icon(Icons.sms_rounded),
                    SizedBox(width: 5,),
                    Text("SMS info"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              
              



PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeveloperInfo()));




                },
                child: Row(
                  children: [
                    Icon(Icons.developer_board),
                    SizedBox(width: 5,),
                    Text("Developer"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              





           PopupMenuItem(
                onTap: () async{

                          FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) async{
                              if (user == null) {
                                
                      //  Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const LogInScreen()),
                      // );
                                print('User is currently signed out!');
                              } else {
                                print('User is signed in!');
                                await FirebaseAuth.instance.signOut();
                                          
                      //  Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const LogInScreen()),
                      // );
                              }
                            });
                  




                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 5,),
                    Text("LogOut"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



              






              

              






              
             
            ];
          },
        )
                ],
        
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
      
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                
                
                     Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  height: 200,
                  child: Center(
                    child: Text("Total Paid Customers: ${AllPaidCustomerData.length.toString()}", style: TextStyle(
                    
                            fontSize: 20,
                            color: Colors.white,
                            overflow: TextOverflow.clip
                          ),),
                
                
                  ),
                       
                 decoration: BoxDecoration(
                  color: Color(0xF0B75CFF),
                
                  border: Border.all(
                            width: 2,
                            color: Color(0xF0B75CFF)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
                
                
                 SizedBox(
                  height: 10,
                 ),
                
                
                
                
                
                
                 
                     Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Total Due Customers: ${AllDueCustomerData.length.toString()}", style: TextStyle(
                    
                            fontSize: 20,
                            color: Colors.white,
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
                                            
                                            
                                          Container(width: 100, child:TextButton(onPressed: (){
                
                
                                                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDueCustomer()));
                
                
                
                
                
                                          }, child: Text("View", style: TextStyle(color: Theme.of(context).primaryColor),), style: ButtonStyle(
                               
                                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                        ),),),
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                              ],),
                          )
                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                
                  border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
                
                
                 SizedBox(
                  height: 10,
                 ),
                
                
                
                
                
                 
                     Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Today Due Payment Add:${moneyAdd.toString()}৳", style: TextStyle(
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
                                              
                                              
                                            Container(width: 100, child:TextButton(onPressed: (){
                
                
                
                                                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDuePaymentAddHistory()));
                
                
                
                
                
                
                
                                            }, child: Text("View", style: TextStyle(color: Color.fromARGB(255, 242,133,0)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),
                                              
                                              
                                              
                                              
                                              
                                              
                                              
                                              
                                              
                                              
                                ],),
                            )
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242,133,0),
                
                  border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 242,133,0)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
                
                
                 SizedBox(
                  height: 10,
                 ),
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
              
                    ]))),
      ));
  }
}
