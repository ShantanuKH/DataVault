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
  TextEditingController nametext = new TextEditingController();
  TextEditingController agetext = new TextEditingController();
  TextEditingController locationtext = new TextEditingController();

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name : " + ds["Name"],
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            ),

                            // So that we can update the data easily
                            GestureDetector(
                              onTap: () {
                                nametext.text = ds["Name"];
                                agetext.text = ds["Age"];
                                locationtext.text = ds["Location"];
                                EditDetail(ds["Id"]);
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),

                        // To show the update butto so user can update the data

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

  Future EditDetail(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(text: "Edit"),
                            TextSpan(
                                text: "Data",
                                style: TextStyle(
                                    color: Colors.yellow.shade800,
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: nametext,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Age",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: agetext,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Location",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: locationtext,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> updateInfo = {
                            "Name": nametext.text,
                            "Age": agetext.text,
                            "Id": id,
                            "Location": locationtext.text
                          };
                          await DatabaseMethods()
                              .updateDetail(id, updateInfo)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: Text("Update"))),
              ],
            )),
          ));
}
