import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/OfflineCalculation/BazarList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class EditBazarList extends StatefulWidget {

  final ItemID;
  final FoodName; 
  final FoodPrice;
  final FoodAmount;
  final FoodUnit;




  const EditBazarList({super.key, required this.ItemID, required this.FoodAmount, required this.FoodName, required this.FoodPrice, required this.FoodUnit});

  @override
  State<EditBazarList> createState() => _EditBazarListState();
}

class _EditBazarListState extends State<EditBazarList> {


  

      
  bool loading = false;


  TextEditingController FoodNameController = TextEditingController();
  TextEditingController FoodPriceController = TextEditingController();
  TextEditingController FoodAmountController = TextEditingController();

  String SelectedValue = ""; 


var DataLoad = "";

List  AllData = [];








  Future DataSendToServer(String ItemID) async{




    setState(() {
      loading =true;
    });


    final docUser = FirebaseFirestore.instance.collection("BazarList").doc(ItemID);


         var BazarListData ={

                
                "FoodName":FoodNameController.text.trim().toLowerCase(),
                "FoodPrice":FoodPriceController.text.trim(),
                "FoodAmount":FoodAmountController.text.trim(),
                "FoodUnit":SelectedValue.toString(),
                "BazarStatus":"open"

           
                };








        print(BazarListData);







          docUser.update(BazarListData).then((value) =>setState(() async{



             
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => BazarList()));
                 


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








  



  @override
  void initState() {

    setState(() {
      SelectedValue = widget.FoodUnit;
    });
    // TODO: implement initState
    super.initState();
  }







  @override
  Widget build(BuildContext context) {


    FoodAmountController.text = widget.FoodAmount;
    FoodNameController.text = widget.FoodName;
    FoodPriceController.text = widget.FoodPrice;

    









    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorName().appColor),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: const Text(
            "Edit Bazar List",
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

                      
                      print("_____________________________________________________________________${widget.ItemID}");

                       DataSendToServer(widget.ItemID);




                         }, child: Text("Edit", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
              backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                          ),),),
                      




                      
                SizedBox(height: 15,),



    



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
