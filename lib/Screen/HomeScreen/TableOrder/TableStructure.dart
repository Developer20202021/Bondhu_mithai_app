import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/TableOrder/ChooseProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TableStructure extends StatefulWidget {
  final CustomerID;
  final CustomerName;
  final CustomerPhoneNumber;

  const TableStructure(
      {super.key,
      required this.CustomerID,
      required this.CustomerName,
      required this.CustomerPhoneNumber});

  @override
  State<TableStructure> createState() => _TableStructureState();
}

class _TableStructureState extends State<TableStructure> {
  int clickButtonNumber = -1;

  List UserSelectedChair = [];

  List BookedChair = [];

  bool loading = false;
  var DataLoad = "";

  // Firebase All Customer Data Load

  List AllData = [];

  Future<void> getData() async {
    // Get docs from collection reference

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('CustomerOrderHistory');

    Query CustomerOrderHistoryQuery = _collectionRef
        .where("OrderStatus", isEqualTo: "open")
        .where("OrderType", isEqualTo: "offline");
    QuerySnapshot querySnapshot = await CustomerOrderHistoryQuery.get();

    // Get data from docs and convert map to List
    AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
    if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
    } else {
      for (var i = 0; i < AllData.length; i++) {
        for (var index = 0; index < AllData[i]["Chairs"].length; index++) {
          setState(() {
            BookedChair.insert(BookedChair.length, AllData[i]["Chairs"][index]);
          });

          print(BookedChair);
        }
      }

      setState(() {
        // BookedChair = List.from(AllData);

        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;
      });
    }

    print(AllData);
  }









  

  var ChairDataLoad = "";

  List ChairsData = [];

  Future<void> getChairsData(String ChairNo) async {
    // Get docs from collection reference

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('CustomerOrderHistory');

    Query CustomerOrderHistoryQuery = _collectionRef
        .where("OrderStatus", isEqualTo: "open")
        .where("OrderType", isEqualTo: "offline")
        .where("Chairs", arrayContainsAny: [ChairNo]);
    QuerySnapshot querySnapshot = await CustomerOrderHistoryQuery.get();

    // Get data from docs and convert map to List
    ChairsData = querySnapshot.docs.map((doc) => doc.data()).toList();
    if (ChairsData.length == 0) {
      setState(() {
        ChairDataLoad = "0";
        loading = false;
      });
    } else {
      setState(() {
        ChairsData = querySnapshot.docs.map((doc) => doc.data()).toList();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: '${ChairsData[0]["CustomerName"]}',
            desc: 'Customer All Order Here...',
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var product in ChairsData[0]["AllOrderFood"])
                  Row(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            '${product["foodImageUrl"]}',
                            width: 100,
                            height: 100,
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
                                color: ColorName().appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),


                          Row(
                            children: [
                              Text(
                                "${product["FoodAmount"]}",
                                style: TextStyle(
                                    color: ColorName().appColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Icon(
                                Icons.close,
                                color: Colors.grey,
                              ),
                              Text(
                                "${product["Foodprice"]}",
                                style: TextStyle(
                                    color: ColorName().appColor,
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
              ],
            ),
            btnOkOnPress: () {},
          ).show();
        });

        loading = false;
      });

      print(ChairsData);

      setState(() {
        // BookedChair = List.from(AllData);

        //  AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        //  loading = false;
      });
    }

    // print(AllData);
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

  Future refresh() async {
    setState(() {
      // loading = true;
      getData();
    });

    // getData();
  }

  Future updateData(List Chairs) async {
    setState(() {
      loading = true;
    });

    final docUser = FirebaseFirestore.instance
        .collection("CustomerOrderHistory")
        .doc(widget.CustomerID);

    final UpadateData = {"Chairs": Chairs};

    // user Data Update and show snackbar

    docUser
        .update(UpadateData)
        .then((value) => setState(() async {
              print("Done");

              try {
                var CustomerMsg =
                    "Dear Customer, আপনি Table No:${UserSelectedChair[0][0]} তে ${UserSelectedChair} Chair এ বসুন. Thank You. Bondhu Mithai";

                final response = await http.get(Uri.parse(
                    'https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=${widget.CustomerPhoneNumber}&message=${CustomerMsg}'));

                if (response.statusCode == 200) {
                  // If the server did return a 200 OK response,
                  // then parse the JSON.
                  print(jsonDecode(response.body));

                  UserSelectedChair.clear();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChooseProduct(
                              CustomerID: widget.CustomerID,
                              CustomerName: widget.CustomerName,
                              CustomerPhoneNumber: widget.CustomerPhoneNumber,
                            )),
                  );

                  setState(() {
                    loading = false;
                  });
                } else {
                  setState(() {
                    loading = false;
                  });
                  // If the server did not return a 200 OK response,
                  // then throw an exception.
                  throw Exception('Failed to load album');
                }
              } catch (e) {}

              setState(() {
                loading = false;
              });
            }))
        .onError((error, stackTrace) => setState(() {
              print(error);
            }));
  }

  @override
  Widget build(BuildContext context) {
    final List<Map> myProducts = [
      {
        "tableID": "T1",
        "TableChair": ["11", "12", "13", "14"]
      },
      {
        "tableID": "T2",
        "TableChair": ["21", "22", "23", "24"]
      },
      {
        "tableID": "T3",
        "TableChair": ["31", "32", "33", "34"]
      },
      {
        "tableID": "T4",
        "TableChair": ["41", "42", "43", "44"]
      },
      {
        "tableID": "T5",
        "TableChair": ["51", "52", "53", "54"]
      },
      {
        "tableID": "T6",
        "TableChair": ["61", "62", "63", "64"]
      },
      {
        "tableID": "T7",
        "TableChair": ["71", "72", "73", "74"]
      },
      {
        "tableID": "T8",
        "TableChair": ["81", "82", "83", "84"]
      },
      {
        "tableID": "T9",
        "TableChair": ["91", "92", "93", "94"]
      },
      {
        "tableID": "T10",
        "TableChair": ["101", "102", "103", "104", "105", "106"]
      },
      {
        "tableID": "T11",
        "TableChair": ["111", "112", "113", "114"]
      },
      {
        "tableID": "T12",
        "TableChair": ["121", "122", "123", "124", "125", "126"]
      },
      {
        "tableID": "T13",
        "TableChair": ["131", "132", "133", "134", "135", "136"]
      },
      {
        "tableID": "T14",
        "TableChair": ["141", "142", "143", "144", "145", "146"]
      },
    ];

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            updateData(UserSelectedChair);
          },
          backgroundColor: ColorName().appColor,
          child: Text(
            "Next",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorName().appColor),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: const Text(
            "Book Your Table",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: loading
            ? Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    color: const Color(0xFF1A1A3F),
                    secondRingColor: Theme.of(context).primaryColor,
                    thirdRingColor: Colors.white,
                    size: 100,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: ColorName().AppBoxBackgroundColor,
                                border: Border.all(
                                    width: 2,
                                    color: ColorName().AppBoxBackgroundColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "নিচের দিকে Scroll করলে আপনি বাহিরে যাওয়ার দিক পাবেন। উপরে Scroll করলে ভিতরের দিক যেতে পারবেন।",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ))),

                    // Kitchen
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Text(
                            'Kitchen',
                            textScaleFactor: 2,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: ColorName().appColor, spreadRadius: 2),
                          ],
                        ),
                        height: 150,
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    // Row 5

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 1

                             

                              BookedChair.contains(
                                            myProducts[8]["TableChair"][0])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[8]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[8]["TableChair"][0]);

                                            },
                                          )
                                        : UserSelectedChair.contains(
                                                myProducts[8]["TableChair"][0])
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  color: Colors.red,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(2),
                                                  child: InkWell(
                                                    child: Text(
                                                      "${myProducts[8]["TableChair"][0]}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    onHighlightChanged:
                                                        (value) {},
                                                    onTap: () {
                                                      setState(() {
                                                        // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                        UserSelectedChair
                                                            .remove(myProducts[
                                                                        8][
                                                                    "TableChair"][0]
                                                                .toString());
                                                      });

                                                      // print("hello 1");
                                                    },
                                                  ),
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  color: ColorName().appColor,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(2),
                                                  child: InkWell(
                                                    child: Text(
                                                      "${myProducts[8]["TableChair"][0]}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    onHighlightChanged:
                                                        (value) {},
                                                    onTap: () {
                                                      setState(() {
                                                        UserSelectedChair.insert(
                                                            UserSelectedChair
                                                                .length,
                                                            myProducts[8][
                                                                    "TableChair"][0]
                                                                .toString());
                                                      });

                                                      // print("hello 1");
                                                    },
                                                  ),
                                                ),
                                              ),

                                    //chair2

                                            BookedChair.contains(
                                            myProducts[8]["TableChair"][1])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[8]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[8]["TableChair"][1]);

                                            },
                                          )
                                        : UserSelectedChair.contains(
                                            myProducts[8]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[8]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[8][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[8]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[8][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[8]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 3

                                             BookedChair.contains(
                                            myProducts[8]["TableChair"][2])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[8]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[8]["TableChair"][2]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[8]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[8]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[8][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[8]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[8][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair 4

                                            BookedChair.contains(
                                            myProducts[8]["TableChair"][3])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[8]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[8]["TableChair"][3]);

                                            },
                                          )
                                        : UserSelectedChair.contains(
                                            myProducts[8]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[8]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[8][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[8]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[8][
                                                                "TableChair"][3]
                                                            .toString());
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

                    SizedBox(
                      height: 27,
                    ),

// Row

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.42,
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //chair 1

                                             BookedChair.contains(
                                            myProducts[9]["TableChair"][0])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[9]["TableChair"][0]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[9]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[9][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[9][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    SizedBox(
                                      height: 40,
                                    ),

                                    //chair2

                                            BookedChair.contains(
                                            myProducts[9]["TableChair"][1])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[9]["TableChair"][1]);

                                            },
                                          )
                                        : UserSelectedChair.contains(
                                            myProducts[9]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[9][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[9][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    SizedBox(
                                      height: 40,
                                    ),

                                    //chair 1

                                             BookedChair.contains(
                                            myProducts[9]["TableChair"][2])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[9]["TableChair"][2]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[9]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[9][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[9][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 55,
                                  height: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[9]["tableID"]}"),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //chair 1

                                             BookedChair.contains(
                                            myProducts[9]["TableChair"][3])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[9]["TableChair"][3]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[9]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[9][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[9][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    SizedBox(
                                      height: 40,
                                    ),

                                    //chair2

                                             BookedChair.contains(
                                            myProducts[9]["TableChair"][4])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][4]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[9]["TableChair"][4]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[9]["TableChair"][4])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][4]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[9][
                                                                "TableChair"][4]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][4]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[9][
                                                                "TableChair"][4]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    SizedBox(
                                      height: 40,
                                    ),

                                    //chair 1

                                             BookedChair.contains(
                                            myProducts[9]["TableChair"][5])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][5]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[9]["TableChair"][5]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[9]["TableChair"][5])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][5]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[9][
                                                                "TableChair"][5]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[9]["TableChair"][5]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[9][
                                                                "TableChair"][5]
                                                            .toString());
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
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [


                                             BookedChair.contains(
                                            myProducts[10]["TableChair"][0])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[10]["TableChair"][0]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[10]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[10][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[10][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),





                                            BookedChair.contains(
                                            myProducts[10]["TableChair"][1])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[10]["TableChair"][1]);

                                            },
                                          )
                                        : UserSelectedChair.contains(
                                            myProducts[10]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[10][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[10][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),

                                // Comming Soon

                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[10]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [



                                             BookedChair.contains(
                                            myProducts[10]["TableChair"][2])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[10]["TableChair"][2]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[10]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[10][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[10][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),



                                             BookedChair.contains(
                                            myProducts[10]["TableChair"][3])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[10]["TableChair"][3]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[10]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[10][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[10]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[10][
                                                                "TableChair"][3]
                                                            .toString());
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

                    SizedBox(
                      height: 27,
                    ),

// Row

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.42,
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //chair 1

                                             BookedChair.contains(
                                            myProducts[11]["TableChair"][0])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[11]["TableChair"][0]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[11]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[11][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[11][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    SizedBox(
                                      height: 40,
                                    ),

                                    //chair2

                                             BookedChair.contains(
                                            myProducts[11]["TableChair"][1])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[11]["TableChair"][1]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[11]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[11][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[11][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    SizedBox(
                                      height: 40,
                                    ),

                                    //chair 1

                                           BookedChair.contains(
                                            myProducts[11]["TableChair"][2])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[11]["TableChair"][2]);

                                            },
                                          )
                                        :  UserSelectedChair.contains(
                                            myProducts[11]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[11][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[11][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 55,
                                  height: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[11]["tableID"]}"),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //chair 1

                                            BookedChair.contains(
                                            myProducts[11]["TableChair"][3])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[11]["TableChair"][3]);

                                            },
                                          )
                                        : UserSelectedChair.contains(
                                            myProducts[11]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[11][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[11][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    SizedBox(
                                      height: 40,
                                    ),

                                    //chair2

                                             BookedChair.contains(
                                            myProducts[11]["TableChair"][4])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][4]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[11]["TableChair"][4]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[11]["TableChair"][4])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][4]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[11][
                                                                "TableChair"][4]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][4]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[11][
                                                                "TableChair"][4]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    SizedBox(
                                      height: 40,
                                    ),

                                    //chair 1

                                             BookedChair.contains(
                                            myProducts[11]["TableChair"][5])
                                        ? InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][5]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onHighlightChanged: (value) {},
                                            onTap: () {
                    getChairsData(myProducts[11]["TableChair"][5]);

                                            },
                                          )
                                        :UserSelectedChair.contains(
                                            myProducts[11]["TableChair"][5])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][5]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[11][
                                                                "TableChair"][5]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[11]["TableChair"][5]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[11][
                                                                "TableChair"][5]
                                                            .toString());
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

























































                  // Comming Soon 











                          Container(
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    UserSelectedChair.contains(
                                            myProducts[12]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[12]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[12][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[12]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[12][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                    UserSelectedChair.contains(
                                            myProducts[12]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[12]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[12][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[12]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[12][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[12]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    UserSelectedChair.contains(
                                            myProducts[12]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[12]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[12][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[12]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[12][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                    UserSelectedChair.contains(
                                            myProducts[12]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[12]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[12][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[12]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[12][
                                                                "TableChair"][3]
                                                            .toString());
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

                    SizedBox(
                      height: 27,
                    ),

// Washroom

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'Washroom1',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                height: 150,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorName().appColor,
                                        spreadRadius: 2),
                                  ],
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Text(
                                    'Washroom2',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                width: 100,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorName().appColor,
                                        spreadRadius: 2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        height: 150,
                      ),
                    ),

                    // Container(
                    //         child: DottedLine(
                    //       direction: Axis.horizontal,
                    //       alignment: WrapAlignment.center,
                    //       lineLength: double.infinity,
                    //       lineThickness: 1.0,
                    //       dashLength: 4.0,
                    //       dashColor: Colors.black,
                    //       dashGradient: [Colors.grey, ColorName().appColor],
                    //       dashRadius: 0.0,
                    //       dashGapLength: 4.0,
                    //       dashGapColor: Colors.transparent,
                    //       dashGapGradient: [Colors.grey, ColorName().appColor],
                    //       dashGapRadius: 0.0,
                    //     )),

                    SizedBox(
                      height: 25,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 1

                                    UserSelectedChair.contains(
                                            myProducts[0]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[0]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[0][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[0]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[0][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair2

                                    UserSelectedChair.contains(
                                            myProducts[0]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[0]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[0][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[0]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[0][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[0]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 3

                                    UserSelectedChair.contains(
                                            myProducts[0]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[0]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[0][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[0]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[0][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair 4

                                    UserSelectedChair.contains(
                                            myProducts[0]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[0]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[0][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[0]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[0][
                                                                "TableChair"][3]
                                                            .toString());
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
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    UserSelectedChair.contains(
                                            myProducts[1]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[1]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[1][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[1]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[1][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                    UserSelectedChair.contains(
                                            myProducts[1]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[1]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[1][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[1]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[1][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[1]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    UserSelectedChair.contains(
                                            myProducts[1]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[1]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[1][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[1]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[1][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                    UserSelectedChair.contains(
                                            myProducts[1]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[1]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[1][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[1]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[1][
                                                                "TableChair"][3]
                                                            .toString());
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

                    SizedBox(
                      height: 27,
                    ),

                    // Row 2

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 1

                                    UserSelectedChair.contains(
                                            myProducts[2]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[2]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[2][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[2]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[2][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair2

                                    UserSelectedChair.contains(
                                            myProducts[0]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[2]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[2][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[2]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[2][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[2]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 3

                                    UserSelectedChair.contains(
                                            myProducts[2]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[2]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[2][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[2]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[2][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair 4

                                    UserSelectedChair.contains(
                                            myProducts[2]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[2]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[2][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[2]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[2][
                                                                "TableChair"][3]
                                                            .toString());
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
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    UserSelectedChair.contains(
                                            myProducts[3]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[3]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[3][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[3]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[3][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                    UserSelectedChair.contains(
                                            myProducts[3]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[3]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[3][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[3]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[3][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[3]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    UserSelectedChair.contains(
                                            myProducts[3]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[3]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[3][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[3]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[3][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                    UserSelectedChair.contains(
                                            myProducts[3]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[3]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[3][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[3]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[3][
                                                                "TableChair"][3]
                                                            .toString());
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

                    SizedBox(
                      height: 27,
                    ),

// Row 3

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 1

                                    UserSelectedChair.contains(
                                            myProducts[4]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[4]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[4][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[4]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[4][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair2

                                    UserSelectedChair.contains(
                                            myProducts[4]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[4]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[4][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[4]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[4][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[4]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 3

                                    UserSelectedChair.contains(
                                            myProducts[4]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[4]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[4][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[4]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[4][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair 4

                                    UserSelectedChair.contains(
                                            myProducts[4]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[4]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[4][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[4]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[4][
                                                                "TableChair"][3]
                                                            .toString());
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
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    UserSelectedChair.contains(
                                            myProducts[5]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[5]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[5][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[5]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[5][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                    UserSelectedChair.contains(
                                            myProducts[5]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[5]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[5][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[5]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[5][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[5]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    UserSelectedChair.contains(
                                            myProducts[5]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[5]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[5][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[5]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[5][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                    UserSelectedChair.contains(
                                            myProducts[5]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[5]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[5][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[5]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[5][
                                                                "TableChair"][3]
                                                            .toString());
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

                    SizedBox(
                      height: 27,
                    ),

// Row 4

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 1

                                    UserSelectedChair.contains(
                                            myProducts[6]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[6]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[6][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[6]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[6][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair2

                                    UserSelectedChair.contains(
                                            myProducts[6]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[6]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[6][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[6]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[6][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[6]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //issue

                                    //chair 3

                                    UserSelectedChair.contains(
                                            myProducts[6]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[6]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[6][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[6]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[6][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair 4

                                    UserSelectedChair.contains(
                                            myProducts[6]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[6]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[6][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[6]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[6][
                                                                "TableChair"][3]
                                                            .toString());
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

                    SizedBox(
                      height: 27,
                    ),

// Row 5

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.42,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 1

                                    UserSelectedChair.contains(
                                            myProducts[7]["TableChair"][0])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[7]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[6][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[7]["TableChair"][0]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[7][
                                                                "TableChair"][0]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair2

                                    UserSelectedChair.contains(
                                            myProducts[7]["TableChair"][1])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[7]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[7][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[7]["TableChair"][1]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[7][
                                                                "TableChair"][1]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Container(
                                  width: 400,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorName().AppBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text("${myProducts[7]["tableID"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //chair 3

                                    UserSelectedChair.contains(
                                            myProducts[7]["TableChair"][2])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[7]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    // myProducts.insert(myProducts.length, myProducts[0]["TableChair"][3]);

                                                    UserSelectedChair.remove(
                                                        myProducts[7][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[7]["TableChair"][2]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[7][
                                                                "TableChair"][2]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          ),

                                    //chair 4

                                    UserSelectedChair.contains(
                                            myProducts[7]["TableChair"][3])
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[7]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.remove(
                                                        myProducts[7][
                                                                "TableChair"][3]
                                                            .toString());
                                                  });

                                                  // print("hello 1");
                                                },
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: ColorName().appColor,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                child: Text(
                                                  "${myProducts[7]["TableChair"][3]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                onHighlightChanged: (value) {},
                                                onTap: () {
                                                  setState(() {
                                                    UserSelectedChair.insert(
                                                        UserSelectedChair
                                                            .length,
                                                        myProducts[7][
                                                                "TableChair"][3]
                                                            .toString());
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

                    SizedBox(
                      height: 27,
                    ),

                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: ColorName().AppBoxBackgroundColor,
                                border: Border.all(
                                    width: 2,
                                    color: ColorName().AppBoxBackgroundColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "প্রবেশ পথ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            )))),
                  ],
                ),
              ));
  }
}
