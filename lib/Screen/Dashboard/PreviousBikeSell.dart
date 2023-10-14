import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';

class PreviousBikeSell extends StatefulWidget {

  final BikeName;
  final BikeColor;





  const PreviousBikeSell({super.key, required this.BikeName, required this.BikeColor});

  @override
  State<PreviousBikeSell> createState() => _PreviousBikeSellState();
}

class _PreviousBikeSellState extends State<PreviousBikeSell> {


  // Firebase All Customer Data Load

List  AllData = [];
var DataLoad = "";




  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('BikeSaleInfo');

Future<void> getData(String BikeName) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    Query query = _collectionRef.where("BikeName", isEqualTo: BikeName);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

       if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
      });
       
     } else {

      setState(() {
      
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
     });
       
     }

    print(AllData);
}


@override
  void initState() {
    // TODO: implement initState
    getData(widget.BikeName);
    super.initState();
  }




    Future refresh() async{


    setState(() {
      
        getData(widget.BikeName);

    });


  }

















  @override
  Widget build(BuildContext context) {


    









    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Previous Sales", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
              itemCount: AllData.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 25,),
              itemBuilder: (BuildContext context, int index) {
      
                late DateTime paymentDateTime = (AllData[index]["PaymentDateTime"] as Timestamp).toDate();
      
      
                return   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                       
                 decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 250, 230, 250),
      
                  border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
      
                    
                    child: ListTile(
                      
                   
                        
                              title: Text("${AllData[index]["BikeName"]}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              trailing: Text("NID:${AllData[index]["CustomerNID"]}"),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                  
                                  Text("Name:${AllData[index]["CustomerName"].toString().toUpperCase()}"),
                                  Text("Phone Number:${AllData[index]["CustomerPhoneNumber"]}"),
                  
                                  Text("Date: ${AllData[index]["BikeSaleDate"]}"),

                                   Text("Eng No: ${AllData[index]["BikeEngineNo"]}"),
                                   Text("Chassis No: ${AllData[index]["BikeChassisNo"]}"),

                                   Text("DeliveryNo: ${AllData[index]["BikeDeliveryNo"]}"),

                                   Text("Sale Price: ${AllData[index]["BikeSalePrice"]}"),
                                  //  BikeConditionMonth
// BikeDeliveryNo
                                   Text("Condition: ${AllData[index]["BikeConditionMonth"]} month"),
                                   Text("Color: ${AllData[index]["BikeColor"]}"),


                                   Text("Cash In: ${AllData[index]["BikeBillPay"]} "),
                                ],
                              ),
                        
                        
                        
                            ),
                  ),
                );
              },
            ),
      ));
  }
}






    