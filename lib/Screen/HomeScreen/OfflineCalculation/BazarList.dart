import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class BazarList extends StatefulWidget {
  const BazarList({super.key});

  @override
  State<BazarList> createState() => _BazarListState();
}

class _BazarListState extends State<BazarList> {
  String UserType = "Admi";

  List BazarList = [
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
    {"productName": "Product Name", "Product Amount": "120 kg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.purple),
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
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                for (var item in BazarList)
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.store),

                        subtitle: UserType =="Admin"?Text("10"):  TextField(

                          keyboardType: TextInputType.number,
                        
                 
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Product price',
                            
                            hintText: 'Product price',
                            
                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Colors.purple),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                            
                            
                            ),
                 
                      ),
                      // { UserType == "Admin"? subtitle: Text("Product Name"):subtitle: }
                        title: Text("Product Name"),
                        trailing: Text("140kg"),
                      ),



                      
                         Container(width: 150, child:TextButton(onPressed: (){


                           final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Successfully Added',
                    message:
                        'Your Product Price is Added Successfully',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);




                         }, child: Text("Add", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
                          ),),),
                      Divider(thickness: 2, height: 30,color: Colors.purple,)
                    ],
                  ),

                  
              ])),
        ));
  }
}
