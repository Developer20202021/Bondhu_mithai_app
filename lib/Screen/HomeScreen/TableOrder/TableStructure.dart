
import 'package:bondhu_mithai_app/Screen/HomeScreen/TableOrder/ChooseProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TableStructure extends StatefulWidget {

  final CustomerID;
  final CustomerName;
  final CustomerPhoneNumber;




  const TableStructure({super.key, required this.CustomerID, required this.CustomerName, required this.CustomerPhoneNumber});

  @override
  State<TableStructure> createState() => _TableStructureState();
}

class _TableStructureState extends State<TableStructure> {

   int clickButtonNumber = -1;


   List UserSelectedChair = [];

   bool loading = false;







   
  Future updateData(List Chairs) async{

    setState(() {
      loading = true;
    });




         final docUser = FirebaseFirestore.instance.collection("CustomerOrderHistory").doc(widget.CustomerID);

                  final UpadateData ={

                    "Chairs":Chairs

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    print("Done");

                    UserSelectedChair.clear();

                    
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseProduct(CustomerID: widget.CustomerID, CustomerName: widget.CustomerName, CustomerPhoneNumber: widget.CustomerPhoneNumber,)),
                );

                  setState(() {
                        loading = false;
                      });




                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));



  }








  @override
  Widget build(BuildContext context) {


    final List<Map> myProducts = [
      
      {"tableID":"t1", "TableChair":["t11","t12","t13", "t14"]},
      {"tableID":"t2", "TableChair":["t21","t22","t23", "t24"]},
      {"tableID":"t3", "TableChair":["t31","t32","t33", "t34"]},
      {"tableID":"t4", "TableChair":["t41","t42","t43", "t44"]},
      {"tableID":"t5", "TableChair":["t51","t52","t53", "t54"]},
      {"tableID":"t6", "TableChair":["t61","t62","t63", "t64"]},
      {"tableID":"t7", "TableChair":["t71","t72","t73", "t74"]},
      {"tableID":"t8", "TableChair":["t81","t82","t83", "t84"]},
      {"tableID":"t9", "TableChair":["t91","t92","t93", "t94"]},
      
      
      ];

    var height = MediaQuery.of(context).size.height;
    var width  = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async{


            updateData(UserSelectedChair);





          },
          backgroundColor: Colors.purple,
          child: Text(
            "Next",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.purple),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: const Text(
            "Book Your Table",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
          child: Column(
            children: [



              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                child: Row(
                  children: [
              
                Container(
                      width: width*0.42,
                      child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [



                        //chair 1

                       UserSelectedChair.contains(myProducts[0]["TableChair"][0])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[0]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[0]["TableChair"][0].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[0]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[0]["TableChair"][0].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),




              

              //chair2
              
                              UserSelectedChair.contains(myProducts[0]["TableChair"][1])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[0]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[0]["TableChair"][1].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[0]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[0]["TableChair"][1].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
              
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 202, 143, 212),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("${myProducts[0]["tableID"]}"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [




                          //chair 3

                              UserSelectedChair.contains(myProducts[0]["TableChair"][2])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[0]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[0]["TableChair"][2].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[0]["TableChair"][2]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[0]["TableChair"][2].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),










                          //chair 4

              
                              UserSelectedChair.contains(myProducts[0]["TableChair"][3])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[0]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[0]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[0]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[0]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
                          ],
                        ),
                      ],
                    ),
                    ),



              
                    SizedBox(
                      width: 25,
                    ),
              
                      Container(
                      width: width*0.42,
                      child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [




                          UserSelectedChair.contains(myProducts[1]["TableChair"][0])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[1]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[1]["TableChair"][0].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[1]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[1]["TableChair"][0].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),









              
              
                             UserSelectedChair.contains(myProducts[1]["TableChair"][1])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[1]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[1]["TableChair"][1].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[1]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[1]["TableChair"][1].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
              
                          


                          ],
                        ),
                        Container(
                          width: 300,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 202, 143, 212),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("${myProducts[1]["tableID"]}"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [



                                  UserSelectedChair.contains(myProducts[1]["TableChair"][2])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[1]["TableChair"][2]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[1]["TableChair"][2].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[1]["TableChair"][2]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[1]["TableChair"][2].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),



              
                          UserSelectedChair.contains(myProducts[1]["TableChair"][3])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[1]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[1]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[1]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[1]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
                               

                               



                          ],
                        ),
                      ],
                    ),
                    )
              
                  ],
                ),
              ),



              SizedBox(height: 27,),






            




    // Row 2
            
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                child: Row(
                  children: [
              
                Container(
                      width: width*0.42,
                      child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [



                        //chair 1

                       UserSelectedChair.contains(myProducts[2]["TableChair"][0])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[2]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[2]["TableChair"][0].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[2]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[2]["TableChair"][0].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),




              

              //chair2
              
                              UserSelectedChair.contains(myProducts[0]["TableChair"][1])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[2]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[2]["TableChair"][1].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[2]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[2]["TableChair"][1].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
              
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 202, 143, 212),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("${myProducts[2]["tableID"]}"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [




                          //chair 3

                              UserSelectedChair.contains(myProducts[2]["TableChair"][2])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[2]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[2]["TableChair"][2].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[2]["TableChair"][2]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[2]["TableChair"][2].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),










                          //chair 4

              
                              UserSelectedChair.contains(myProducts[2]["TableChair"][3])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[2]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[2]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[2]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[2]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
                          ],
                        ),
                      ],
                    ),
                    ),


                    
              
                    SizedBox(
                      width: 25,
                    ),
              
                      Container(
                      width: width*0.42,
                      child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [




                          UserSelectedChair.contains(myProducts[3]["TableChair"][0])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[3]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[3]["TableChair"][0].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[3]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[3]["TableChair"][0].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),









              
              
                             UserSelectedChair.contains(myProducts[3]["TableChair"][1])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[3]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[3]["TableChair"][1].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[3]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[3]["TableChair"][1].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
              
                          


                          ],
                        ),
                        Container(
                          width: 300,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 202, 143, 212),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("${myProducts[3]["tableID"]}"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [



                                  UserSelectedChair.contains(myProducts[3]["TableChair"][2])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[3]["TableChair"][2]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[3]["TableChair"][2].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[3]["TableChair"][2]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[3]["TableChair"][2].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),



              
                          UserSelectedChair.contains(myProducts[3]["TableChair"][3])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[3]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[3]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[3]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[3]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
                               

                               



                          ],
                        ),
                      ],
                    ),
                    )
              
                  ],
                ),
              ),







              









              

              SizedBox(height: 27,),










// Row 3
            
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                child: Row(
                  children: [
              
                Container(
                      width: width*0.42,
                      child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [



                        //chair 1

                       UserSelectedChair.contains(myProducts[4]["TableChair"][0])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[4]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[4]["TableChair"][0].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[4]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[4]["TableChair"][0].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),




              

              //chair2
              
                              UserSelectedChair.contains(myProducts[4]["TableChair"][1])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[4]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[4]["TableChair"][1].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[4]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[4]["TableChair"][1].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
              
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 202, 143, 212),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("${myProducts[4]["tableID"]}"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [




                          //chair 3

                              UserSelectedChair.contains(myProducts[4]["TableChair"][2])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[4]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[4]["TableChair"][2].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[4]["TableChair"][2]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[4]["TableChair"][2].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),










                          //chair 4

              
                              UserSelectedChair.contains(myProducts[4]["TableChair"][3])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[4]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[4]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[4]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[4]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
                          ],
                        ),
                      ],
                    ),
                    ),


                    
              
                    SizedBox(
                      width: 25,
                    ),
              
                      Container(
                      width: width*0.42,
                      child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [




                          UserSelectedChair.contains(myProducts[5]["TableChair"][0])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[5]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[5]["TableChair"][0].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[5]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[5]["TableChair"][0].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),









              
              
                             UserSelectedChair.contains(myProducts[5]["TableChair"][1])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[5]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[5]["TableChair"][1].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[5]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[5]["TableChair"][1].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
              
                          


                          ],
                        ),
                        Container(
                          width: 300,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 202, 143, 212),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("${myProducts[5]["tableID"]}"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [



                                  UserSelectedChair.contains(myProducts[5]["TableChair"][2])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[5]["TableChair"][2]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[5]["TableChair"][2].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[5]["TableChair"][2]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[5]["TableChair"][2].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),



              
                          UserSelectedChair.contains(myProducts[5]["TableChair"][3])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[5]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[5]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[5]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[5]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
                               

                               



                          ],
                        ),
                      ],
                    ),
                    )
              
                  ],
                ),
              ),







              









              

              SizedBox(height: 27,),





















// Row 4
            
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                child: Row(
                  children: [
              
                Container(
                      width: width*0.42,
                      child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [



                        //chair 1

                       UserSelectedChair.contains(myProducts[6]["TableChair"][0])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[6]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[6]["TableChair"][0].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[6]["TableChair"][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[6]["TableChair"][0].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),




              

              //chair2
              
                              UserSelectedChair.contains(myProducts[6]["TableChair"][1])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[6]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[6]["TableChair"][1].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[6]["TableChair"][1]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[6]["TableChair"][1].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
              
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 202, 143, 212),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("${myProducts[6]["tableID"]}"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [




                          //chair 3

                              UserSelectedChair.contains(myProducts[6]["TableChair"][2])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[6]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                      UserSelectedChair.remove(myProducts[6]["TableChair"][2].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                  Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[6]["TableChair"][2]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                         setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[6]["TableChair"][2].toString());
                                      

                                    });
                                    
                               
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),










                          //chair 4

              
                              UserSelectedChair.contains(myProducts[6]["TableChair"][3])? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[6]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                      

                                      UserSelectedChair.remove(myProducts[6]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            )   :ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 30,
                                color:
                                     Colors.amber,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: InkWell(
                                  child: Text(
                                    "${myProducts[6]["TableChair"][3]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onHighlightChanged: (value) {},
                                  onTap: () {


                                    setState(() {

                                     UserSelectedChair.insert(UserSelectedChair.length, myProducts[6]["TableChair"][3].toString());
                                      

                                    });
                                    
                                
                                    // print("hello 1");
                                  },
                                ),
                              ),
                            ),
              
                          ],
                        ),
                      ],
                    ),
                    ),


                    
              
                    SizedBox(
                      width: 25,
                    ),
              
                     
              
                  ],
                ),
              ),







              









              

              SizedBox(height: 27,),



















            ],
          ),
        ));
  }
}
