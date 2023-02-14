import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: ((snapshot, option) =>
                MyUser.fromJson(snapshot.data()!)),
            toFirestore: (user, options) => user.toJson());
  }

  static Future<void> registerUser(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }
  //static Future<void> saveData(MyUser user) async{
  //   return getCollectionFromFireBase().doc(user.id).set(user);
  //    }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc()
        .collection(Message.collectionName)
        .withConverter<Message>(
            fromFirestore: ((snapshot, option) =>
                Message.fromJson(snapshot.data()!)),
            toFirestore: (message, options) => message.toJson());
  }

  static Future<MyUser?> getUser(String userId) async {
    var documentSnapShot = await getUserCollection().doc(userId).get();
    return documentSnapShot.data();
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: ((snapshot, option) =>
                Room.fromJson(snapshot.data()!)),
            toFirestore: (room, options) => room.toJson());
  }

  static Future<void> addRoomToFirestore(Room room) async {
    var docRef = getRoomCollection().doc();
    room.roomId = docRef.id;
    return docRef.set(room);
  }

  static Stream<QuerySnapshot<Room>> getRooms() {
    return getRoomCollection().snapshots();
  }

  static Future<void> insertMessage(Message message) {
    var messageCollection = getMessageCollection(message.roomId);
    var docRef = messageCollection.doc();
    message.id = docRef.id;
    return docRef.set(message);
  }
  static Stream<QuerySnapshot<Message>> getMessageFromFireStore(String roomId){
  return  getMessageCollection(roomId).orderBy('date_time').snapshots();

  }
}
