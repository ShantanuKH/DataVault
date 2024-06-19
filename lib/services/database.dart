import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //This will be called when user click on add button
  // Map<String, dynamic> => This will help to store the user form to the cloud firestore easily
  // We use id here as there will be the seperate and unique id for each of the info in the database
  Future addDetails(Map<String, dynamic> InfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("DataVault")
        .doc(id)
        .set(InfoMap);
    // The collection name will be CRUDCloud, To upload the specific InfoMap we use .set method
  }

// QuerySnapshot => Will help to read all the data from the respective databse collection
  Future<Stream<QuerySnapshot>> getDetails() async {
    // This will take the data from the collection DataVault and will return us the data so that we can read the data 
    return await FirebaseFirestore.instance.collection("DataVault").snapshots();
  }
}
