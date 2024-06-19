import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_vault/pages/formfill.dart';
import 'package:data_vault/services/database.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
// This will check all the data present in the database and will view us with the help of listview builder
// Corrected syntax
  Stream? DataVaultStream;

// This function will load the data present in the database as soon as we open the app
  getonthelaod() async {
    DataVaultStream = await DatabaseMethods().getDetails();
    // This is helpful for passing the details to the ListViewBuilder
    setState(() {});
  }


  // It is the first function that will be execute when the app launches
  @override
  void initState() {
    getonthelaod();
    super.initState();
  }

// To perform Read operation
  Widget allDetails() {
    return StreamBuilder(
      stream: DataVaultStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              // Return your ListTile or other widget here
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name : " + ds["Name"],
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Age : " + ds["Age"],
                          style: TextStyle(
                              color: Colors.yellow.shade800,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Location : " + ds["Location"],
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container(); // Return an empty container if snapshot has no data
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormFillPage()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //   Text("CRUD", style: TextStyle(color:Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            //   Text("Cloud", style: TextStyle(color:Colors.yellow, fontSize: 20, fontWeight: FontWeight.bold),
            // )

            RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                  TextSpan(text: "Data"),
                  TextSpan(
                      text: "Vault",
                      style: TextStyle(
                          color: Colors.yellow.shade800,
                          fontSize: 27,
                          fontWeight: FontWeight.bold))
                ]))
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 25),
        child: Column(
          children: [
            Expanded(child: allDetails()),
          ],
        ),
      ),
    );
  }
}
