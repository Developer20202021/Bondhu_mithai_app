import 'package:bondhu_mithai_app/Screen/Dashboard/SendSMSToDueCustomer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_slidable/flutter_slidable.dart';





class DueCustomer extends StatefulWidget {
  const DueCustomer({super.key});

  @override
  State<DueCustomer> createState() => _DueCustomerState();
}

class _DueCustomerState extends State<DueCustomer> {

bool loading = false;

var DataLoad = "";
int moneyAdd =0;
var totalDueCustomer = "";

   // Firebase All Customer Data Load

List  AllData = [];


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('customer');

Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    Query query = _collectionRef.where("CustomerType", isEqualTo: "Due");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();


       if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {


           for (var i = 0; i < AllData.length; i++) {

                var money = AllData[i]["BikePaymentDue"];
                int moneyInt = int.parse(money);

      

                      setState(() {
                        totalDueCustomer = AllData.length.toString();
                        moneyAdd = moneyAdd + moneyInt;
                        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
                      });

       
                  }




     }


    print(AllData);
}









@override
  void initState() {
    // TODO: implement initState
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Due Customers", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
        
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                
                  border: Border.all(
                            width: 1,
                            color: Theme.of(context).primaryColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
            
          
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("আপনার শোরুমে ${totalDueCustomer} জন Customer এর  ${moneyAdd.toString()}৳ টাকা বকেয়া আছে।", style: TextStyle(color: Colors.white, fontSize: 20),),
            ),),



            SizedBox(height: 50,),
            SizedBox(height: 50,),


           
          
        
        ],
      );
    });

        }, icon: Icon(Icons.date_range, color: Theme.of(context).primaryColor,))

      ],
        
      ),
      body: DataLoad == "0"? Center(child: Text("No Data Available")):RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),
      
              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),
      
                // A pane can dismiss the Slidable.
                
      
                // All actions are defined in the children parameter.
                children:  [
                  // A SlidableAction can have an icon and/or a label.
               
                  SlidableAction(
                    onPressed: (context) => DueCustomerPageToCustomerProfile(context,AllData[index]["CustomerNID"]),
                    backgroundColor: Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.info,
                    label: 'All Info',
                  ),
                ],
              ),
      
              // The end action pane is the one at the right or the bottom side.
              endActionPane:  ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (context) => CustomerAddPayment(context,AllData[index]["CustomerNID"] ,AllData[index]["CustomerPhoneNumber"], AllData[index]["BikePaymentDue"]  ),
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.payment,
                    label: 'Add Payment',
                  ),
                  SlidableAction(
                    onPressed: (Context) => EveryPaymentHistory(context,AllData[index]["CustomerNID"] ,AllData[index]["CustomerPhoneNumber"] ),
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.save,
                    label: 'Payment History',
                  ),
                ],
              ),
      
              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child:  ListTile(
                
                   leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text("${AllData[index]["CustomerName"][0].toString().toUpperCase()}",style: TextStyle(color: Colors.white),),
        ),
      
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            Text('NID:${AllData[index]["CustomerNID"]}'),
            Text('Due: ${AllData[index]["BikePaymentDue"]} tk'),
            Text('Phone No:${AllData[index]["CustomerPhoneNumber"]}'),
            Text('${AllData[index]["CustomerType"]}'),
          ],
        ),
        trailing: TextButton(onPressed: () {
      
      
        
      
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendSMSToDueCustomer(CustomerNID: AllData[index]["CustomerNID"], CustomerPhoneNumber: AllData[index]["CustomerPhoneNumber"], BikePaymentDue: AllData[index]["BikePaymentDue"],BikeDuePaymentGivingDay: AllData[index]["DuePaymentGivingDay"],)));
      
      
      
        }, child: Text("Send Message", style: TextStyle(color: Colors.white),), style: ButtonStyle(
         
                  backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                ),),
                
                title: Text('${AllData[index]["CustomerName"]}', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),)),
            );
          },
          itemCount: AllData.length,
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}











void DueCustomerPageToCustomerProfile(BuildContext context, String CustomerNID){
  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerProfile(CustomerNID: CustomerNID)));
}





void EveryPaymentHistory(BuildContext context, String CustomerNID, String CustomerPhoneNumber){



  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentHistory(CustomerNID: CustomerNID, CustomerPhoneNumber: CustomerPhoneNumber)));
}








 void CustomerAddPayment(BuildContext context, String CustomerNID, String CustomerPhoneNumber, String BikePaymentDue){


  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerPaymentAdd(CustomerNID: CustomerNID, CustomerPhoneNumber: CustomerPhoneNumber, BikePaymentDue: BikePaymentDue,)));
}