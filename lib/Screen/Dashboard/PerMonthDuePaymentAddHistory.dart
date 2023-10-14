import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';




class PerMonthDuePaymentAddHistory extends StatefulWidget {
  const PerMonthDuePaymentAddHistory({super.key});

  @override
  State<PerMonthDuePaymentAddHistory> createState() => _PerMonthDuePaymentAddHistoryState();
}

class _PerMonthDuePaymentAddHistoryState extends State<PerMonthDuePaymentAddHistory> {



    bool loading = true;

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

          var paymentMonth = "${adminSetMonth}/${adminSetYear}";

          setState(() {
            VisiblePaymentDate = paymentMonth;
          });

          print("${adminSetDay}/${adminSetMonth}/${adminSetYear}");


          getData(paymentMonth);





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



 var PaymentMonth = "${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";


    
  // Firebase All Customer Data Load

List  AllData = [];
    int moneyAdd = 0;
    var DataLoad = "";

  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('DuePaymentAddInfo');

Future<void> getData(String paymentDate) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    Query query = _collectionRef.where("PaymentMonth", isEqualTo: paymentDate);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();


     moneyAdd = 0;


     if (AllData.length == 0) {
       setState(() {
        
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {

        DataLoad = "";
        
      });

      for (var i = 0; i < AllData.length; i++) {

       var money = AllData[i]["Amount"];
      int moneyInt = int.parse(money);

      

      setState(() {
        moneyAdd = moneyAdd + moneyInt;
        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;
      });
       
     }

     print(moneyAdd);
       
     }

     

  

    print(AllData);
}


@override
  void initState() {
   
    // TODO: implement initState
    getData(PaymentMonth);
    super.initState();
  }



   
  Future refresh() async{


    setState(() {
      
  getData(PaymentMonth);

    });




  }


 






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title:  Text("মাসিক বকেয়া টাকা উত্তোলন", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
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
              child: Text("${VisiblePaymentDate} মাসে ${moneyAdd}৳ টাকা উত্তোলিত হয়েছে।", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
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
      body:loading?Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: const Color(0xFF1A1A3F),
          secondRingColor: Theme.of(context).primaryColor,
          thirdRingColor: Colors.white,
          size: 100,
        ),
      ):DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
              itemCount: AllData.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15,),
              itemBuilder: (BuildContext context, int index) {
      
                     DateTime paymentDateTime = (AllData[index]["PaymentDateTime"] as Timestamp).toDate();
      
      
                return   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                             shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ), 
                      
                            title: Text("${AllData[index]["Amount"]}৳", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                            trailing: Text("NID:${AllData[index]["CustomerNID"]}"),
                            subtitle: Column(
      
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
      
                                Text("Phone Numnber:${AllData[index]["CustomerPhoneNumber"]}"),
      
                                Text("Date: ${paymentDateTime}"),
                              ],
                            ),
                      
                      
                      
                          ),
                );
              },
            ),
      ));
  }
}