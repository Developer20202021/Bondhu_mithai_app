

import 'package:flutter/material.dart';

class TableStructure extends StatefulWidget {
  const TableStructure({super.key});

  @override
  State<TableStructure> createState() => _TableStructureState();
}

class _TableStructureState extends State<TableStructure> {

   int clickButtonNumber = -1;
  @override
  Widget build(BuildContext context) {
    final List<Map> myProducts = List.generate(
        100000, (index) => {"id": index, "name": "Table No $index"}).toList();

   

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
          title: Center(
            child: const Text(
              "Book Your Table",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 50,
                    mainAxisSpacing: 100),
                itemCount: myProducts.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 30,
                              width: 30,
                              color:
                                  myProducts[index]["id"] == clickButtonNumber
                                      ? Colors.red
                                      : Colors.amber,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: InkWell(
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onHighlightChanged: (value) {},
                                onTap: () {
                                  
                                  setState(() {
                                    clickButtonNumber = myProducts[index]["id"];
                                  });
                                  // print("hello 1");
                                },
                              ),
                            ),
                          ),


                            ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 30,
                              width: 30,
                              color:
                                  myProducts[index]["id"] == clickButtonNumber
                                      ? Colors.red
                                      : Colors.amber,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: InkWell(
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onHighlightChanged: (value) {},
                                onTap: () {
                                  
                                  setState(() {
                                    clickButtonNumber = myProducts[index]["id"];
                                  });
                                  // print("hello 1");
                                },
                              ),
                            ),
                          ),



                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 30,
                              width: 30,
                              color:
                                  myProducts[index]["id"] == clickButtonNumber
                                      ? Colors.red
                                      : Colors.amber,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: InkWell(
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onHighlightChanged: (value) {},
                                onTap: () {
                                  
                                  setState(() {
                                    clickButtonNumber = myProducts[index]["id"];
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
                        child: Text(myProducts[index]["name"]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                                 ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 30,
                              width: 30,
                              color:
                                  myProducts[index]["id"] == clickButtonNumber
                                      ? Colors.red
                                      : Colors.amber,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: InkWell(
                                child: Text(
                                  "4",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onHighlightChanged: (value) {},
                                onTap: () {
                                  
                                  setState(() {
                                    clickButtonNumber = myProducts[index]["id"];
                                  });
                                  // print("hello 1");
                                },
                              ),
                            ),
                          ),

                                  ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 30,
                              width: 30,
                              color:
                                  myProducts[index]["id"] == clickButtonNumber
                                      ? Colors.red
                                      : Colors.amber,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: InkWell(
                                child: Text(
                                  "5",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onHighlightChanged: (value) {},
                                onTap: () {
                                  
                                  setState(() {
                                    clickButtonNumber = myProducts[index]["id"];
                                  });
                                  // print("hello 1");
                                },
                              ),
                            ),
                          ),

                                 ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 30,
                              width: 30,
                              color:
                                  myProducts[index]["id"] == clickButtonNumber
                                      ? Colors.red
                                      : Colors.amber,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: InkWell(
                                child: Text(
                                  "6",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onHighlightChanged: (value) {},
                                onTap: () {
                                  
                                  setState(() {
                                    clickButtonNumber = myProducts[index]["id"];
                                  });
                                  // print("hello 1");
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                })));
  }
}
