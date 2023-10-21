import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/OfflineCalculation/BazarList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uuid/uuid.dart';

class createBazarList extends StatefulWidget {
  const createBazarList({super.key});

  @override
  State<createBazarList> createState() => _createBazarListState();
}

class _createBazarListState extends State<createBazarList> {


  
  var uuid = Uuid();
      
  bool loading = false;


  TextEditingController FoodNameController = TextEditingController();
  TextEditingController FoodPriceController = TextEditingController();
  TextEditingController FoodAmountController = TextEditingController();

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

FoodNameController.clear();
FoodAmountController.clear();
FoodPriceController.clear();





  }



  Future DataSendToServer(String ItemID) async{

    setState(() {
      loading =true;
    });


    final docUser = FirebaseFirestore.instance.collection("BazarList");


         var BazarListData ={

                "FoodID":ItemID,
                "FoodName":FoodNameController.text.trim().toLowerCase(),
                "FoodPrice":FoodPriceController.text.trim(),
                "FoodAmount":FoodAmountController.text.trim(),
                "FoodUnit":SelectedValue.toString(),
                "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                "BazarStatus":"open"

           
                };












          docUser.doc(ItemID).set(BazarListData).then((value) =>setState(() async{


              DataCallFromServer();

             

                 


                       final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Successfully Add',
                    message:
                        'Successfully Add',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);





                    })).onError((error, stackTrace) => setState((){


                      
                        





                    }));


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

  var ItemID = uuid.v4();





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
            "Create Bazar List",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          actions: [

            IconButton(onPressed: (){

                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => BazarList()));

            }, icon: Icon(Icons.arrow_forward))



          ],
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
              
              
                 TextField(

                      
                        
                 
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Food Name',
                            
                            hintText: 'Food Name',
                            
                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: ColorName().appColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                            
                            
                            ),
                            controller: FoodNameController,
                 
                      ),


                    SizedBox(height: 11,),
                       TextField(

                        
                        keyboardType: TextInputType.number,
                        
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Food Amount',
                            
                            hintText: 'Food Amount',
                            
                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: ColorName().appColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                            
                            
                            ),

                            controller: FoodAmountController,
                 
                      ),


                SizedBox(height: 11,),

                       TextField(

                          keyboardType: TextInputType.number,
                        
                 
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Food price',
                            
                            hintText: 'Food price',
                            
                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: ColorName().appColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                            
                            
                            ),

                          controller: FoodPriceController,
                 
                      ),

                      SizedBox(height: 11,),


                      Container(
                        height: 70,
                        child: DropdownButton(
                         
                                           
                         
                          hint:  SelectedValue == ""
                              ? Text('Food Unit')
                              : Text(
                                 SelectedValue,
                                  style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                          items: ['Kg', 'gm', 'Pcs', "Plate"].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                 SelectedValue = val!;
                              },
                            );
                          },
                        ),
                      ),



                    SizedBox(height: 11,),


                      

                      
                         Container(width: 150, child:TextButton(onPressed: () async{


                       DataSendToServer(ItemID);




                         }, child: Text("Add", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
              backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                          ),),),
                      




                      
                SizedBox(height: 15,),



    
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

                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => EveryFoodScreen()));
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
