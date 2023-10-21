import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/OfflineCalculation/EditBazarList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uuid/uuid.dart';

class BazarList extends StatefulWidget {
  const BazarList({super.key});

  @override
  State<BazarList> createState() => _BazarListState();
}

class _BazarListState extends State<BazarList> {


  

      
  bool loading = false;



  String SelectedValue = ""; 


var DataLoad = "";

List  AllData = [];




  Future DataCallFromServer() async {


    setState(() {
      loading = true;
    });
      CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('BazarList');

    Query _CollectionRefQuery = _collectionRef.where("BazarStatus", isEqualTo: "open");



        QuerySnapshot querySnapshot = await _CollectionRefQuery.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
     if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
     
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
      loading = false;
     });
       
     }

print(AllData);







  }









  Future DataBazarStatusClose() async{

    setState(() {
      loading = true;
    });

    
try {


  
    for (var i = 0; i < AllData.length; i++) {


      

         final docUser = FirebaseFirestore.instance.collection("BazarList").doc(AllData[i]["FoodID"]);

                  final UpadateData ={

                      "BazarStatus":"close"

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    print("Done");

                 
                  DataCallFromServer();
                    
             

                 




                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));




      
    }













  
} catch (e) {
  
}








  }




  


  @override
  void initState() {

    setState(() {
      DataCallFromServer();
    });
    // TODO: implement initState
    super.initState();
  }







  @override
  Widget build(BuildContext context) {







    return Scaffold(
      floatingActionButton:  FloatingActionButton(onPressed: ()async{

                  DataBazarStatusClose();

      },

      child: Text("Clear", style: TextStyle(fontWeight: FontWeight.bold),),
      
      
      ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorName().appColor),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: const Text(
            "Bazar List",
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
            size: 30,
          ),
        ):SingleChildScrollView(
          child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                
                
                children: [
              
              
                 

    
          for(var item in AllData)

       Padding(
                
                  padding: const EdgeInsets.all(8.0),
                  child: PhysicalModel(

                        color: Colors.white,
                        elevation: 18,
                        shadowColor: ColorName().appColor,
                        borderRadius: BorderRadius.circular(20),
                    child: ListTile(

                      onLongPress: () {

                          showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                          title: Text('Delete This Item?'),
                          content: Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            
                            children: [


                               Container(width: 100, child:TextButton(onPressed: () async{

                setState(() {
                  loading = true;
                });
                final docUser = FirebaseFirestore.instance.collection("BazarList").doc(item["FoodID"]).delete().then((value) => print("Delete"));


                DataCallFromServer();


                         }, child: Text("Delete", style: TextStyle(color: Colors.white, fontSize: 13),), style: ButtonStyle(
                   
              backgroundColor: MaterialStatePropertyAll<Color>(const Color.fromARGB(220,218, 44, 56)),
                          ),),),


                          ],),
                      )
                  );
                        

                      },





                      onTap: () {

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditBazarList(ItemID: item["FoodID"], FoodAmount: item["FoodAmount"], FoodName: item["FoodName"], FoodPrice: item["FoodPrice"], FoodUnit: item["FoodUnit"])));
                      },
                  
                    
                        
                        
                              title: Text("${item["FoodName"]}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              
                              subtitle: Column(
                        
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Amount: ${item["FoodAmount"]} ${item["FoodUnit"]}", style: TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                  
                                  Text("Food Price: ${item["FoodPrice"]}৳", style: TextStyle(fontWeight: FontWeight.bold),),

                                  Text("Bazar Date: ${item["Date"]}", style: TextStyle(fontWeight: FontWeight.bold),),

                                  Text("Bazar Status: ${item["BazarStatus"]}", style: TextStyle(fontWeight: FontWeight.bold),),

                              

                  
                                ],
                              ),
                        
                        
                        
                            ),
                  ),
                )


    // "FoodID":ItemID,
    //             "FoodName":FoodNameController.text.trim().toLowerCase(),
    //             "FoodPrice":FoodPriceController.text.trim(),
    //             "FoodAmount":FoodAmountController.text.trim(),
    //             "FoodUnit":SelectedValue.toString(),
    //             "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
    //             "BazarStatus":"open"





              
              
              
              
                  
                         
              
              
              
                        
                        
                        
              
              
              
              
              
              
              
              
              
              
              
              
                         
              ])),
        ));
  }
}
