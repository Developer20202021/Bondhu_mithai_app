
import 'dart:async';

import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserOrderHistory extends StatefulWidget {






  const UserOrderHistory({super.key});

  @override
  State<UserOrderHistory> createState() => _UserOrderHistoryState();
}

class _UserOrderHistoryState extends State<UserOrderHistory> {








   List AllData = [];

  var DataLoad = "1";

  bool loading = true;




  // double averagerating = 0.0;




Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });




    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('CustomerOrderHistory');
      
      Query FoodReviewQuery = _collectionRef.where("CustomerPhoneNumber", isEqualTo: "949494");



    QuerySnapshot querySnapshot = await FoodReviewQuery.get();


    

    // Get data from docs and convert map to List
      setState(() {
         AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
      });


       if (AllData.length == 0) {

      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {


   



          setState(() {
              DataLoad = "1";
               AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
               loading = false;
          });




     }


    print(AllData);
}















  Future updateData( String OrderID) async{

    setState(() {
      loading = true;
    });




         final docUser = FirebaseFirestore.instance.collection("CustomerOrderHistory").doc(OrderID);


         // update Data comming soon

                  final UpadateData ={

                      "OrderStatus":"close",
                      "CustomerType":"Paid",
                      "DeliveryStatus":"Cancel"

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    print("Done");

                 

                   getData();

                  setState(() {
                        loading = false;
                      });




                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));



  }




















Timer? timer;






@override
  void initState() {
    // TODO: implement initState
    getData();

    timer = Timer.periodic(Duration(seconds: 60), (Timer t) => getData());
    
    super.initState();
  }



  @override
void dispose() {
  timer?.cancel();
  super.dispose();
}






  
  List UserAllOrderHistory = [

    {
      "orderNumber":"Order#45654",
      "orderType":"Complete",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },





{
      "orderNumber":"Order#45654",
      "orderType":"Complete",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },





    {
      "orderNumber":"Order#45654",
      "orderType":"Complete",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },




    {
      "orderNumber":"Order#45654",
      "orderType":"Complete",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },




    {
      "orderNumber":"Order#45654",
      "orderType":"Complete",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },




    {
      "orderNumber":"Order#45654",
      "orderType":"Complete",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },





    {
      "orderNumber":"Order#45654",
      "orderType":"Complete",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },


    {
      "orderNumber":"Order#45654",
      "orderType":"Complete",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },


    {
      "orderNumber":"Order#45654",
      "orderType":"Cancel",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },


    {
      "orderNumber":"Order#45654",
      "orderType":"Cooking",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },


    {
      "orderNumber":"Order#45654",
      "orderType":"Shipped",
      "LastOrderHistoryTime":"21-01-2023",
      "SubtotalPrice":"10",
      "DeliveryFee":"10",
      "OrderTotalPrice":"10",
      "UserName":"Mahadi Hasan",
      "UserPhoneNumber":"+8801767298388",
      "UserEmail":"mahadi@gmail.com",
      "UserAddress":"Joypurhat Rajshahi Bangladesh",



      "AllProduct":[
        {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },


           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },

           {
          "ProductName":"Burger Tasty Food",
          "ProductImageURL":"https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000",
          "OrderRating":"5",
          "OrderAmount":"/1kg / 120 Kcal",
          "OrderSelection":"1",
          "OrderPrice":"15",
        },



      ]

    },



     



  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.purple),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: const Text(
            "My Orders",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: loading?Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: const Color(0xFF1A1A3F),
          secondRingColor: Theme.of(context).primaryColor,
          thirdRingColor: Colors.white,
          size: 100,
        ),
      ):SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Center(
                //   child: Text(
                //     "Order History ",
                //     style: TextStyle(
                //         color: Color.fromARGB(255, 48, 2, 56),
                //         fontWeight: FontWeight.bold,
                //         fontSize: 24),
                //   ),
                // ),

          
                // SizedBox(
                //   height: 20,
                // ),


      if(DataLoad =="1")...[
        for(var item in AllData )
                Card(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 16.0,  bottom: 6.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        leading: Icon(Icons.food_bank, color: Colors.purple,
                        size: 40,
                        ),
                        title: Text(
                          '${item["OrderID"]}',
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                              color: Color.fromARGB(255, 48, 2, 56),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        subtitle: Row(
                          children: [
                          item["DeliveryStatus"] =="DeliveryComplete"?  Icon(
                              Icons.check,
                              color: Colors.green,
                            ):Text(""),

                            item["DeliveryStatus"] =="OnTheRoad"?  Icon(
                              Icons.local_shipping,
                              color: Colors.purple,
                            ):Text(""),

                            item["DeliveryStatus"] =="packaging"?  Icon(
                              Icons.kitchen,
                              color: Colors.purple,
                            ):Text(""),

                             item["DeliveryStatus"] =="Cancel"?  Icon(
                              Icons.close,
                              color: Colors.red,
                            ):Text(""),

                          





                           item["DeliveryStatus"] =="DeliveryComplete"? Text("Complete"):Text(""),

                           item["DeliveryStatus"] =="OnTheRoad"? Text("Road"):Text(""),

                           item["DeliveryStatus"] =="packaging"? Text("Packaging"):Text(""),

                           item["DeliveryStatus"] =="New"? Text("New"):Text(""),
                           item["DeliveryStatus"] =="Cancel"? Text("Cancel"):Text(""),


                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${item["OrderDate"]}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Container(
                              child: DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashGradient: [Colors.grey, Colors.purple],
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapGradient: [Colors.grey, Colors.purple],
                            dashGapRadius: 0.0,
                          )),

                          SizedBox(
                            height: 30,
                          ),
            //  for (int j = 0; j < item["AllProduct"].; j++)
             for(var product in item["AllOrderFood"])
                          Row(
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(58), // Image radius
                                    child: Image.network(
                                      '${product["foodImageUrl"]}',
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product["FoodName"]}",
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                 
                                      Text(
                                        "Per ${product["FoodUnit"]} price ${product["Foodprice"]}৳",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${product["FoodAmount"]}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "${product["Foodprice"]}৳",
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),

                                    Text(
                                        " = ",
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),


                                    Text(
                                        "${product["ThisFoodOrderPrice"]}৳",
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),

                                    
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          // Row(
                          //   children: [
                          //     Center(
                          //       child: ClipRRect(
                          //         borderRadius: BorderRadius.circular(20.0),
                          //         child: SizedBox.fromSize(
                          //           size: Size.fromRadius(58), // Image radius
                          //           child: Image.network(
                          //             'https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000',
                          //             width: 50,
                          //             height: 50,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Column(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           "Burger Tasty Food",
                          //           style: TextStyle(
                          //               color: Colors.purple,
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: 16),
                          //         ),
                          //         SizedBox(
                          //           height: 5,
                          //         ),
                          //         Row(
                          //           children: [
                          //             Icon(
                          //               Icons.star,
                          //               color: Colors.purple,
                          //             ),
                          //             Text("5"),
                          //             Text(
                          //               "/1kg / 120 Kcal",
                          //               style: TextStyle(
                          //                   color: Colors.grey,
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 13),
                          //             ),
                          //           ],
                          //         ),
                          //         SizedBox(
                          //           height: 5,
                          //         ),
                          //         Row(
                          //           children: [
                          //             Text(
                          //               "1",
                          //               style: TextStyle(
                          //                   color: Colors.grey,
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 20),
                          //             ),
                          //             Icon(
                          //               Icons.close,
                          //               color: Colors.grey,
                          //             ),
                          //             Text(
                          //               "15",
                          //               style: TextStyle(
                          //                   color: Colors.purple,
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 20),
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     )
                          //   ],
                          // ),

                          // SizedBox(
                          //   height: 30,
                          // ),

                          Container(
                              child: DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashGradient: [Colors.grey, Colors.purple],
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapGradient: [Colors.grey, Colors.purple],
                            dashGapRadius: 0.0,
                          )),

                          SizedBox(
                            height: 30,
                          ),

                          Row(
                            children: [
                              Text(
                                "Subtotal",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "--------------------------",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${item["TotalFoodPrice"]}৳",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          // Calculation Section
                          Row(
                            children: [
                              Text(
                                "Delivery",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "--------------------------",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${item["DeliveryFee"]}৳",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "--------------------------",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${(double.parse(item["TotalFoodPrice"]))+(double.parse(item["DeliveryFee"]))}",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.purple,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Information",
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),

                                  Text(
                                    "Name: ${item["CustomerName"]} ${item["CustomerPhoneNumber"]}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),

                                  Text(
                                    "Email: ${item["CustomerEmail"]}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),

                                  // Address Section
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.purple,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Address",
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),

                                  Text(
                                    "${item["CustomerAddress"]}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),

                              
                                ],
                              ),
                            ],
                          ),






                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                    item["DeliveryStatus"] =="New"?  Container(width: 100, child:TextButton(onPressed: () async{


                              updateData(item["OrderID"]);
                          
                          
                                  
                           
                          
                          
                                                   }, child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 13),), style: ButtonStyle(
                                             
                                        backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                            ),),):Text("")





                          ],
                        )









                        ],
                      ),
                    ),
                  ),
                )]




                else ...[

                  Center(child: Text("No Order Yet..."))
                ]





              ],
            ),
          ),
        ));
  }
}
