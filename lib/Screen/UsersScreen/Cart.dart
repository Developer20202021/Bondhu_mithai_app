import 'dart:io';

import 'package:bondhu_mithai_app/Screen/Dashboard/AllCustomer.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/UsersScreen/DeliveryTimeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:badges/badges.dart' as badges;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';






class CustomerCartScreen extends StatefulWidget {

  final CustomerName;
  final CustomerPhoneNumber;



  const CustomerCartScreen({super.key,  required this.CustomerName,required this.CustomerPhoneNumber});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {

  
  var uuid = Uuid();



  TextEditingController DiscountCodeController = TextEditingController();











bool loading = false;

var DataLoad = "";



  int userSelectedFoodCount = 0;

  var selectedData =[];

  var selectedFoodAmount = [];

  double foodAmount = 1.0;
  int selectedFoodIndex = 0;

  List SelectedFoodItem = [];


  var LastUpdatedFood =[];

  var LastUpdatedFoodLength = 0; 

  double CustomerFoodPrice = 0;





// hive database

  final _mybox = Hive.box("mybox");






  void readData() async{

 print(_mybox.get("UserAddToCartFood"));


   
   LastUpdatedFood = _mybox.get("UserAddToCartFood"); 


     if (LastUpdatedFood.length == 0) {
      setState(() {
        DataLoad = "0";
      });
       
     } else {

      for (var i = 0; i < LastUpdatedFood.length; i++) {


        var thisFoodOrderPrice = LastUpdatedFood[i]["ThisFoodOrderPrice"];

        double thisFoodOrderPriceDouble = double.parse(thisFoodOrderPrice.toString());

        setState(() {
          CustomerFoodPrice = CustomerFoodPrice + thisFoodOrderPriceDouble;
        });


        
      }





      setState(() {

     
     LastUpdatedFoodLength = LastUpdatedFood.length;
      LastUpdatedFood = _mybox.get("UserAddToCartFood"); 
       loading = false;
     });
       
     }

        
      
  }




  












 










  Future updateData(List AllOrderFood, String OrderID) async{

    setState(() {
      loading = true;
    });




         final docUser = FirebaseFirestore.instance.collection("CustomerOrderHistory").doc(OrderID);


         // update Data comming soon

                  final UpadateData ={

                      "CustomerName":widget.CustomerName,
                      "CustomerPhoneNumber":widget.CustomerPhoneNumber,
                      "CustomerPersonNumber":"1",
                      "CustomerAddress":"",
                      "OrderDate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                      "OrderTime":"${DateTime.now().toLocal().toIso8601String()}",
                      "OrderMonth":"${DateTime.now().month}/${DateTime.now().year}",
                      "OrderYear":"${DateTime.now().year}",
                      "CustomerID":"",
                      "OrderID":OrderID,
                      "OrderType":"online",
                      "OrderStatus":"open",
                      "CustomerType":"Due",
                      "CashIn":"0.0",
                      "Chairs":["online"],
                      "AllOrderFood":AllOrderFood,
                      "TotalFoodPrice":CustomerFoodPrice.toString(),
                      "WithDeliveryFeeFoodPrice":CustomerFoodPrice.toString(),
                      "DueAmount":CustomerFoodPrice.toString(),
                      "DeliveryStatus":"New"

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    print("Done");

                 

                    
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllCustomer(indexNumber:"1")),
                );

                  setState(() {
                        loading = false;
                      });




                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));



  }















@override
  void initState() {
    // TODO: implement initState
    setState(() {
      loading = true;
    });
    // getData();

    readData();

    super.initState();
  }














  
Future refresh() async{


setState(() {
      
   readData();

    });


  }
























  @override
  Widget build(BuildContext context) {

     var OrderID = uuid.v4();



    return Scaffold(

      floatingActionButton: Container(width: 150, child:TextButton(onPressed: () async{


  
  List myList = List.from(LastUpdatedFood);



  updateData(LastUpdatedFood, OrderID);


  _mybox.delete("UserAddToCartFood");

  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeliveryTimeScreen(CustomerPhoneNumber: widget.CustomerPhoneNumber, OrderID: OrderID, allFood: myList,)));







      }, child: Text("Confirm", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
              ),),),

        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
              automaticallyImplyLeading: false,
               shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(60),
                  ),
                ),



            actions: [
        
        
        
        IconButton(onPressed: (){







  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        
          decoration: BoxDecoration(
              color: Colors.white,
            
              border: Border.all(
                        width: 1,
                        color: Colors.grey
                      ),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))    
             ),
        
      
        child: Column(
          children: [
            Table(
                  border: TableBorder.all(color:Colors.grey),
                  children: [


                  // The first row just contains a phrase 'INVOICE FOR PAYMENT'
                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Name',
                           
                           
                          ),
                          padding: EdgeInsets.all(6),
                        ),

                           Padding(
                          child: Text(
                            '${widget.CustomerName.toString().toUpperCase()}',
                           
                           
                          ),
                          padding: EdgeInsets.all(6),
                        ),
                      ],
                    ),


                



                  TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Address',
                           
                            
                          ),
                          padding: EdgeInsets.all(6),
                        ),


                          Padding(
                          child: Text(
                            '',
                          
                         
                          ),
                          padding: EdgeInsets.all(6),
                        ),




                      ],
                    ),



                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Phone Number',
                           
                         
                          ),
                          padding: EdgeInsets.all(6),
                        ),


                          Padding(
                          child: Text(
                            '${widget.CustomerPhoneNumber}',
                         
                      
                          ),
                          padding: EdgeInsets.all(6),
                        ),




                      ],
                    ),

                    
                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Total Price',
                           
                       
                          ),
                          padding: EdgeInsets.all(6),
                        ),


                          Padding(
                          child: Text(
                            '${CustomerFoodPrice.toString()}৳',
                         
                        
                          ),
                          padding: EdgeInsets.all(6),
                        ),




                      ],
                    ),



                    
                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Delivery Fee',
                           
                     
                          ),
                          padding: EdgeInsets.all(6),
                        ),


                          Padding(
                          child: Text(
                            '0৳',
                         
                          ),
                          padding: EdgeInsets.all(6),
                        ),




                      ],
                    ),



                         
                    


                    



                  





      ]),



      











          ],
        ),);
    });



        }, icon: Icon(Icons.price_check_outlined))
        
        
            ],
            iconTheme: IconThemeData(color: Colors.white),
          
          
             toolbarHeight: 100, 
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                


                Text(
                  "Name: ${widget.CustomerName.toString().toUpperCase()}",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),

                Text(
                  "Phone No: ${widget.CustomerPhoneNumber}",
                  style:
                       TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),


                Text(
                  "Address: Komorgram Joypurhat",
                  style:
                       TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),

                  Text(
                  "Total Price: ${CustomerFoodPrice.toString()}৳",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),



              ],
            ),
            backgroundColor: ColorName().appColor,
            bottomOpacity: 0.0,
            elevation: 0.0,
          ),
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
                 color: ColorName().appColor,
                onRefresh: refresh,
                child: ListView.builder(
                    itemCount: LastUpdatedFoodLength,
                    
                    itemBuilder: (BuildContext context, int index) {
              
              
                     
              
              
                     
              
                      
              
              
              
              
              
                      return Card(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                    child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          leading: Image.network(
                            "${LastUpdatedFood[index]["foodImageUrl"]}",
                          ),
                          title: Text(
                            "${LastUpdatedFood[index]["FoodName"]}",
                            style: TextStyle(
                                color: Color.fromARGB(255, 48, 2, 56),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Text(
                            "${LastUpdatedFood[index]["Foodprice"]} Taka per ${LastUpdatedFood[index]["FoodUnit"]}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
              
              
                        Text(
                            "Order Amount: ${LastUpdatedFood[index]["FoodAmount"]}",
                            style: TextStyle(
                                color: ColorName().appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
              
                            
              
              
                                  SizedBox(
                                  width: 5,
                                ),
              
              
                                 Text(
                            "Order Price: ${LastUpdatedFood[index]["ThisFoodOrderPrice"]}৳",
                            style: TextStyle(
                                color: ColorName().appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
              
              
              
              
              
              
                                
                               
                           
                                SizedBox(
                                  width: 5,
                                ),
                              
              
                          
                              ],
                            ),
              
              
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ))));
                    },
                  ),
              ),



          
                     


                     
       );
  }
}



