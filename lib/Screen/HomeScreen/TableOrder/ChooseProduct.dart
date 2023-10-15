import 'dart:io';

import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/TableOrder/Cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:badges/badges.dart' as badges;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';

class ChooseProduct extends StatefulWidget {

  final CustomerID;
  final CustomerName;
  final CustomerPhoneNumber;



  const ChooseProduct({super.key, required this.CustomerID, required this.CustomerName, required this.CustomerPhoneNumber});

  @override
  State<ChooseProduct> createState() => _ChooseProductState();
}

class _ChooseProductState extends State<ChooseProduct> {






  int userSelectedFoodCount = 0;

  var selectedData =[];

  var selectedFoodAmount = [];

  double foodAmount = 1.0;
  int selectedFoodIndex = 0;



  List SelectedFoodItem = [];









// hive database

  final _mybox = Hive.box("mybox");



  void writeData( List WriteData){


    _mybox.put("UserAddToCartFood", WriteData);
    print(_mybox.get("UserAddToCartFood"));

     Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen(CustomerID: widget.CustomerID, CustomerName: widget.CustomerName, CustomerPhoneNumber: widget.CustomerPhoneNumber,)));



  }



  void readData(){




  }












  bool loading = false;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [];
var collection;




  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('foodinfo');

Future<void> getData() async {

 Directory appDocDirectory = await getApplicationDocumentsDirectory();

     
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

    _mybox.delete("UserAddToCartFood");

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
        appBar: AppBar(
          actions: [



    badges.Badge(
      badgeContent: Text('${userSelectedFoodCount.toString()}'),
      child: IconButton(onPressed: (){

        writeData(SelectedFoodItem);



      }, icon: Icon(Icons.shopping_cart, size: 31,)),
      position: badges.BadgePosition.topStart(),
    )


          ],
          iconTheme: IconThemeData(color: ColorName().appColor),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: Center(
            child: const Text(
              "Choose Food",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
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
                    itemCount: AllData.length,
                    
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
                            "${AllData[index]["foodImageUrl"]}",
                          ),
                          title: Text(
                            "${AllData[index]["FoodName"]}",
                            style: TextStyle(
                                color: Color.fromARGB(255, 48, 2, 56),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Text(
                            "${AllData[index]["FoodSalePrice"]} Taka per ${AllData[index]["FoodUnit"]}",
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
              
              
              
                               selectedData.contains(index)?Icon(Icons.check_circle_outline, color: Colors.green[700],): InputQty(
                                    maxVal: 100,
                                    initVal: 0,
                                    minVal: 0,
                                    steps: 0.5,
                                    onQtyChanged: (val) {
                                      print(val);
              
                                     setState(() {
                                        selectedFoodIndex = index;
                                        foodAmount = double.parse(val.toString());
                                     });
              
                                    
                                    },
                                decoration: QtyDecorationProps(btnColor: ColorName().appColor ),
                                  ),
              
              
                                  SizedBox(
                                  width: 5,
                                ),
              
              
                                 Text(
                            "Price: ${selectedFoodIndex==index?double.parse("${AllData[index]["FoodSalePrice"]}")*foodAmount:AllData[index]["FoodSalePrice"]}৳",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
              
              
              
              
              
              
                                
                               
                           
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 70,
                                  child: selectedData.contains(index)?Icon(Icons.check_circle_outline, color: Colors.green[700],):TextButton(
                                    onPressed: () async{

                                





              
              
                                      setState(() {
                                        userSelectedFoodCount = userSelectedFoodCount + 1;
              
              
                                        selectedData.insert(selectedData.length, index);



                                        SelectedFoodItem.insert(SelectedFoodItem.length,{'FoodName': '${AllData[index]["FoodName"]}', 'FoodAmount': foodAmount, "Foodprice":"${AllData[index]["FoodSalePrice"]}", "FoodID":"${AllData[index]["FoodID"]}", "ThisFoodOrderPrice":"${double.parse("${AllData[index]["FoodSalePrice"]}")*foodAmount}", "foodImageUrl":"${AllData[index]["foodImageUrl"]}", "FoodUnit":"${AllData[index]["FoodUnit"]}"});





              
                                        print(selectedData);
              
              
              
              
              
                                      });
              
              
              
              
              
                                    },
                                    child: Text(
                                      "Done",
                                      style:
                                          TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              ColorName().appColor),
                                    ),
                                  ),
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



