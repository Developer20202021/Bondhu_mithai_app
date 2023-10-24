// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/Delivery/AllPackagingOrder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectDeliveryMan extends StatefulWidget {

  final CustomerNumber;
  final CustomerEmail;
  final OrderID;


 

  const SelectDeliveryMan({super.key, required this.CustomerEmail, required this.CustomerNumber, required this.OrderID});

  @override
  State<SelectDeliveryMan> createState() => _SelectDeliveryManState();
}

class _SelectDeliveryManState extends State<SelectDeliveryMan> {








bool loading = false;

var DataLoad = "";

String CustomerOTP = Random().nextInt(999999).toString().padLeft(6, '0');





// update Customer Order History Data 

Future updateCustomerData(String DeliveryManEmail) async{


         final docUser = FirebaseFirestore.instance.collection("CustomerOrderHistory").doc(widget.OrderID);

                  final UpadateData ={

                    "DeliveryManEmail":DeliveryManEmail,
                    "DeliveryStatus":"packaging",
                    "CustomerOTP":CustomerOTP

                
                };





           

                  docUser.update(UpadateData).then((value) => setState(() async{



                           
                  var CustomerOTPmsg = "বন্ধু মিঠাই, Dear Customer, আপনার OTP ${CustomerOTP}। এটি শুধু Delivery Man কে দিবেন।";



                  final response = await http
                      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=01721915550&message=${CustomerOTPmsg}'));

                  if (response.statusCode == 200) {
                    // If the server did return a 200 OK response,
                    // then parse the JSON.
                    print(jsonDecode(response.body));
                    
                  
                  } else {
                    // If the server did not return a 200 OK response,
                    // then throw an exception.
                    throw Exception('Failed to load album');
                  }








                  // Update Delivery Man Data for New Order

                  updateDeliveryManData(DeliveryManEmail);











              
                final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Successfully Added',
                      message:
                          'Your Delivery Man is Added Successfully',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);


                












                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));


  }










// update delivery Man Data

Future updateDeliveryManData(String DeliveryManEmail) async{



  
      CollectionReference _collectionDeliveryManRef =
                FirebaseFirestore.instance.collection('DeliveryMan');

      Query DeliveryManQuery = _collectionDeliveryManRef.where("DeliveryManEmail",    isEqualTo: DeliveryManEmail);


      QuerySnapshot DeliveryManQuerySnapshot = await DeliveryManQuery.get();

      List  DeliveryManData = DeliveryManQuerySnapshot.docs.map((doc) => doc.data()).toList();


      var deliveryCountString = DeliveryManData[0]["DeliveryCount"];

      int deliveryCountInt = int.parse(deliveryCountString);


  


         final docUser = FirebaseFirestore.instance.collection("DeliveryMan").doc(DeliveryManEmail);

                  final UpadateData ={


                    "DeliveryCount":deliveryCountInt + 1



                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState(() async{







                        
                  var DeliveryManMsg = "Hello Sir, আপনার একটি নতুন Online Order এসেছে। Phone No.${widget.CustomerNumber}";



                  final response = await http
                      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=01721915550&message=${DeliveryManMsg}'));

                  if (response.statusCode == 200) {
                    // If the server did return a 200 OK response,
                    // then parse the JSON.
                    print(jsonDecode(response.body));
                    
                  
                  } else {
                    // If the server did not return a 200 OK response,
                    // then throw an exception.
                    throw Exception('Failed to load album');
                  }









              // all data update and navigate to new screen

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllPackagingorder()));


              
                final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Successfully Added',
                      message:
                          'Your Delivery Man is Added Successfully',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));


  }









 



// // Firebase All Customer Data Load

List  AllData = [];




Future<void> getData() async {

   setState(() {
      loading = true;
    });


  
  CollectionReference _collectionRef = 
    FirebaseFirestore.instance.collection('DeliveryMan');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
     if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
      });
       
     } else {

      setState(() {
     
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
       loading = false;
     });
       
     }
     

    print(AllData);
}





@override
  void initState() {
    // TODO: implement initState
    setState(() {
      loading = true;
    });
    getData();
    super.initState();
  }



  
  Future refresh() async{


    setState(() {
      
  getData();

    });


  }












  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 12),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromRGBO(92, 107, 192, 1),
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
              IconButton(
                enableFeedback: false,
                onPressed: () async{

                  //     FirebaseAuth.instance
                  // .authStateChanges()
                  // .listen((User? user) {
                  //   if (user == null) {
                  //     print('User is currently signed out!');
                  //   } else {
                  // // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: user.displayName, userEmail: user.email, indexNumber: "1",)));
                  //   }
                  // });



                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),



              
              IconButton(
                enableFeedback: false,
                onPressed: () {


                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2")));



                },
                icon: const Icon(
                  Icons.electric_bike_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),






             
           IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.admin_panel_settings_rounded,
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






      appBar:  AppBar(
        
        
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        automaticallyImplyLeading: false,
        title: const Text("Set Delivery Man", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
              ):DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
                color: Color.fromRGBO(92, 107, 192, 1),
                onRefresh: refresh,
                child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          // Specify a key if the Slidable is dismissible.
                          key: const ValueKey(0),
              
                          // The start action pane is the one at the left or the top side.
                          startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),
              
                // A pane can dismiss the Slidable.
             
              
                // All actions are defined in the children parameter.
                children: const [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color.fromRGBO(92, 107, 192, 1),
                    foregroundColor: Colors.white,
                    icon: Icons.info,
                    label: 'All Info',
                  ),
                ],
                          ),
              
                          // The end action pane is the one at the right or the bottom side.
                          endActionPane:  ActionPane(
                motion: ScrollMotion(),
                children: [


                       SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (context)=>updateCustomerData(AllData[index]["DeliveryManEmail"]),
                    backgroundColor: Color.fromRGBO(92, 107, 192, 1),
                    foregroundColor: Colors.white,
                    icon: Icons.payment,
                    label: 'Select',
                  ),





                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: BlockYourUser,
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.payment,
                    label: 'Send SMS',
                  ),
                
                ],
                          ),
              
                          // The child of the Slidable is what the user sees when the
                          // component is not dragged.
                          child:  ListTile(
                
                   leading: CircleAvatar(
                      backgroundColor: Color.fromRGBO(92, 107, 192, 1),
                      child: Text("${AllData[index]["DeliveryManName"][0].toString().toUpperCase()}",style: TextStyle(color: Colors.white)),
                    ),
              
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AllData[index]["DeliveryManEmail"]}'),
                        Text('Phone: ${AllData[index]["DeliveryManPhoneNumber"]}'),
                      ],
                    ),
                    trailing: Text("${AllData[index]["DeliveryStatus"]}", style: TextStyle(color:  AllData[index]["DeliveryStatus"]=="open"?Colors.green[600]:Colors.red[600]),),
                
                title: Text('${AllData[index]["DeliveryManName"].toString().toUpperCase()}', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),)),
                        );
                      },
                      itemCount: AllData.length,
                    ),
              ),
    );
  }
}



void doNothing(BuildContext context) {


// updateCustomerData(String DeliveryManEmail)

}


void SendFoodForDelivery(BuildContext context) {




}

void EveryPaymentHistory(BuildContext context){
  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentHistory()));
}





void BlockYourUser(BuildContext context){
  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlockAdmin()));
}