import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';




class PerMonthBazarListCost extends StatefulWidget {
  const PerMonthBazarListCost({super.key});

  @override
  State<PerMonthBazarListCost> createState() => _PerMonthBazarListCostState();
}

class _PerMonthBazarListCostState extends State<PerMonthBazarListCost> {


  // এখানে Date দিয়ে Data fetch করতে হবে। 

  var VisiblePaymentDate = "${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";
  


     void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      // TODO: implement your code here

          if (args.value is PickerDateRange) {

            try {
          final DateTime rangeStartDate = args.value.startDate;
          var adminSetDay = rangeStartDate.day;
          var adminSetMonth = rangeStartDate.month;
          var adminSetYear = rangeStartDate.year;

          var paymentDate = "${adminSetMonth}/${adminSetYear}";

          VisiblePaymentDate = paymentDate;

          print("${adminSetDay}/${adminSetMonth}/${adminSetYear}");


          getData(paymentDate);





          final DateTime rangeEndDate = args.value.endDate;
              
            } catch (e) {
              
            }
         
        } else if (args.value is DateTime) {
          final DateTime selectedDate = args.value;
          print(selectedDate);
        } else if (args.value is List<DateTime>) {
          final List<DateTime> selectedDates = args.value;
          print(selectedDates);
        } else {
          final List<PickerDateRange> selectedRanges = args.value;
          print(selectedRanges);
        }




      
      
    }



 var PaymentDate = "${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";


   var DataLoad = ""; 
  // Firebase All Customer Data Load









List  AllData = [];
double moneyAdd = 0.0;

  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('BazarList');

Future<void> getData(String OrderDate) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    Query query = _collectionRef.where("month", isEqualTo: OrderDate);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();


     moneyAdd = 0.0;




     if (AllData.length == 0) {
       setState(() {
        DataLoad = "0";
      });
       
     } else {

      setState(() {
        DataLoad = "";
      });

      for (var i = 0; i < AllData.length; i++) {

       var money = AllData[i]["TotalFoodPrice"];
      double moneydouble = double.parse(money);

      

      setState(() {
        moneyAdd = moneyAdd + moneydouble;
        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
       
     }

     print(moneyAdd);
       
     }









    //  for (var i = 0; i < AllData.length; i++) {

    //    var money = AllData[i]["SalePrice"];
    //   int moneyInt = int.parse(money);

      

    //   setState(() {
    //     moneyAdd = moneyAdd + moneyInt;
    //   });
       
    //  }

    //  print(moneyAdd);

    //  setState(() {
    //    AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //  });

    print(AllData);
}


@override
  void initState() {
    // TODO: implement initState
    getData(PaymentDate);
    super.initState();
  }

 


   Future refresh() async{


    setState(() {
      
         getData(PaymentDate);

    });

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title:  Text("Per Month Bazar History", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
         actions: [
        IconButton(onPressed: (){


          showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Container(
            
            color:Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${VisiblePaymentDate} তারিখে ${moneyAdd}৳ টাকা ক্রয় করেছেন।", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),),


            SizedBox(height: 10,),


          Container(
                child: SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  todayHighlightColor: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
          
        
        ],
      );
    });

        }, icon: Icon(Icons.date_range, color: Theme.of(context).primaryColor,))

      ],
        
      ),
      body:DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          
              itemCount: AllData.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15,),
              itemBuilder: (BuildContext context, int index) {
      
                    //  DateTime paymentDateTime = (AllData[index]["PaymentDateTime"] as Timestamp).toDate();
      
      
                return   Padding(
                
                  padding: const EdgeInsets.all(8.0),
                  child: PhysicalModel(

                        color: Colors.white,
                        elevation: 18,
                        shadowColor: ColorName().appColor,
                        borderRadius: BorderRadius.circular(20),
                    child: ListTile(
                  
                    
                    
                        
                              title: Text("Total Price: ${AllData[index]["TotalFoodPrice"]}৳", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              
                              subtitle: Column(
                        
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${AllData[index]["FoodName"].toString().toUpperCase()}", style: TextStyle(fontWeight: FontWeight.bold),),
                  
                                  Text("${AllData[index]["FoodAmount"]} ${AllData[index]["FoodUnit"]}"),

                                  Text("Per ${AllData[index]["FoodUnit"]} Price ${AllData[index]["FoodPrice"]} ৳"),
                  

                        
                                  Text("Date: ${AllData[index]["Date"]}"),
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