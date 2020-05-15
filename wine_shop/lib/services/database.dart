import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wine_shop/models/user.dart';
import 'package:wine_shop/models/wine.dart';


class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  
   // collection refrence //

   final CollectionReference wineCollection = Firestore.instance.collection('Wines');

   Future updateUserData(String wines,String name,int strength)async{

     return await wineCollection.document(uid).setData({
       'wines' : wines,
       'name' : name,
       'strength' : strength
     });
   }

   // wine list from snapshot //
   List<Wine> _wineListFromSnapshot(QuerySnapshot snapshot){
     return snapshot.documents.map((doc){
       return Wine(
         name: doc.data['name'] ?? '',
         strength: doc.data['strength'] ?? 0,
         wines: doc.data['wines'] ?? '0',
       );
     }).toList(); 
   }

   // userData from snapshot
   UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
      return UserData(
        uid: uid,
        name: snapshot.data['name'],
        wine: snapshot.data['wine'],
        strength: snapshot.data['strength'],
      );
   }

   // get wine stream //

  Stream<List<Wine>> get wines {
    return wineCollection.snapshots()
    .map(_wineListFromSnapshot);
  }

  // user doc stream
  Stream<UserData> get userData {
    return wineCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}