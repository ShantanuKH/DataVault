import 'package:data_vault/pages/formfill.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FormFillPage()));
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
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
