import 'package:bondhu_mithai_app/Screen/Dashboard/CustomerProfile.dart';
import 'package:bondhu_mithai_app/Screen/Dashboard/PaymentAdd.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/UserProfile/UserProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart';



class EveryCustomerAllDueOrder extends StatefulWidget {

  final indexNumber ;
  final CustomerPhoneNumber;



  const EveryCustomerAllDueOrder({super.key, required this.indexNumber, required this.CustomerPhoneNumber});

  @override
  State<EveryCustomerAllDueOrder> createState() => _EveryCustomerAllDueOrderState();
}

class _EveryCustomerAllDueOrderState extends State<EveryCustomerAllDueOrder> {




bool loading = false;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [];




Future<void> getData() async {
    // Get docs from collection reference
      CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('CustomerOrderHistory');

  // all Due Query Count
     Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("CustomerPhoneNumber", isEqualTo: widget.CustomerPhoneNumber).where("CustomerType", isEqualTo: "Due");

     QuerySnapshot queryDueSnapshot = await _CustomerOrderHistoryCollectionRefDueQueryCount.get();

    var AllDueData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();





     if (AllDueData.length == 0) {
      setState(() {
        DataLoad = "0";
      });
       
     } else {

      setState(() {
     
      AllData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();
      loading = false;
     });
       
     }
     

    print(AllData);
}











// Firebase All Customer Data Load








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

 FocusNode myFocusNode = new FocusNode();


   




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
              IconButton(
                enableFeedback: false,
                onPressed: () async{


                  // FirebaseAuth.instance
                  // .authStateChanges()
                  // .listen((User? user) {
                  //   if (user == null) {
                  //     print('User is currently signed out!');
                  //   } else {
                  // // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: user.displayName, userEmail: user.email, indexNumber: "1",)));
                  // //   }
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

                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2")));



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


                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3")));



                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),


              widget.indexNumber == "4"?
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.person_sharp,
                  color: Colors.white,
                  size: 55,
                  fill: 1.0,
                ),
              ): IconButton(
                enableFeedback: false,
                onPressed: () {},
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
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Due Order",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                       
                 decoration: BoxDecoration(
                  color: ColorName().AppBoxBackgroundColor,
     

                  border: Border.all(
                            width: 2,
                            color: ColorName().AppBoxBackgroundColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
      
                    
                    child: ListTile(
                      
                   
                        
                              title: Text("Order No:- ${(index+1).toString()}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              trailing: TextButton(onPressed: (){
      
      
                                      
      
      
                               
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentAdd(SalePrice: AllData[index]["TotalFoodPrice"], CustomerPhoneNumber: AllData[index]["CustomerPhoneNumber"], OrderID: AllData[index]["OrderID"], CustomerID: AllData[index]["CustomerID"])));
      
      
      
      
      
                              }, child: Text("Payment Add", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                               
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),)
      
      ,
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 
                                  Text("Name:${AllData[index]["CustomerName"]}"),
                                  Text("Phone Number:${AllData[index]["CustomerPhoneNumber"]}"),
                  
                                  Text("Order Date: ${AllData[index]["OrderDate"]}"),

                                  Text("Order Type: ${AllData[index]["OrderType"]}"),

                                  Text("Total Price: ${AllData[index]["TotalFoodPrice"]} ৳"),

                                  Text("Due Price: ${AllData[index]["DueAmount"]} ৳"),
                                  
                                

                               

                                


                                   Text("Cash In: ${AllData[index]["CashIn"]} "),


                                  Text("${AllData[index]["CustomerType"]}"),
                                ],
                              ),
                        
                        
                        
                            ),
                  ),
                );
          },
          itemCount: AllData.length,
        ),
      ),
    );
  }
}

void EveryCustomerAllDueOrderPageToCustomerProfile(BuildContext context, String CustomerID, String CustomerPhoneNumber){


  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile(CustomerID: CustomerID, CustomerPhoneNumber: CustomerPhoneNumber,)));
}


void SeeCustomerProfile(BuildContext context, String CustomerPhoneNumber){


  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerProfile(CustomerPhoneNumber: CustomerPhoneNumber)));
}





void EveryPaymentHistory(BuildContext context, String CustomerID, String CustomerPhoneNumber){



  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentHistory(CustomerNID: CustomerNID, CustomerPhoneNumber: CustomerPhoneNumber)));
}








 void CustomerAddPayment(BuildContext context, String CustomerID, String CustomerPhoneNumber, TotalFoodPrice){







  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerPaymentAdd(CustomerNID: CustomerNID, CustomerPhoneNumber: CustomerPhoneNumber, BikePaymentDue: BikePaymentDue,)));
}






