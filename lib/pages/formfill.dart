import 'package:data_vault/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class FormFillPage extends StatefulWidget {
  const FormFillPage({super.key});

  @override
  State<FormFillPage> createState() => _FormFillPageState();
}

class _FormFillPageState extends State<FormFillPage> {
  TextEditingController nametext = new TextEditingController();
  TextEditingController agetext = new TextEditingController();
  TextEditingController locationtext = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                  TextSpan(text: "Entry"),
                  TextSpan(
                      text: "Manager",
                      style: TextStyle(
                          color: Colors.yellow.shade800,
                          fontSize: 27,
                          fontWeight: FontWeight.bold))
                ]))
          ],
        ),
      ),
      body: Container(
        margin:
            EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
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
                  fontSize: 24.0,
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
                  fontSize: 24.0,
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
              height: 40.0,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    // To get the unique id for each detail we added randomAlphaNumeric which we get from random_string
                    String Id = randomAlphaNumeric(10);
                    // Whenever we will click on the button then the details will be added to the database
                    Map<String, dynamic> InfoMap = {
                      "Name": nametext.text,
                      "Age": agetext.text,
                      "Location": locationtext.text
                    };

                    // This function ensure that after adding the data to the databse a mesage will pop up saying "Data has been added successfully! 🎉"
                    await DatabaseMethods()
                        .addDetails(InfoMap, Id)
                        .then((onValue) {
                          Fluttertoast.showToast(
                              msg: "Data has been added successfully! 🎉",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        });
                  },
                  child: Text("Add",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
