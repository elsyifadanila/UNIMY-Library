import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:unimy_beacon_navigation/model/beacon_estimote_model.dart';
import 'package:unimy_beacon_navigation/model/user_model.dart';
import 'package:unimy_beacon_navigation/provider/root_change_notifier.dart';
import 'package:unimy_beacon_navigation/services/storage_service.dart';
import 'package:unimy_beacon_navigation/viewstate.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference beaconsDataCollection =
      FirebaseFirestore.instance.collection('beaconNavigations');

  final CollectionReference userNavigationDataCollection =
      FirebaseFirestore.instance.collection('usersNavigation');
  Future createUserData({
    required String name,
    required String email,
  }) async {
    await userNavigationDataCollection.doc(uid).set({
      'name': name,
      'email': email,
      'uid': uid,
      'lastSeen': DateTime.now().toUtc(),
    });
  }

  Stream<UserModel> get readUserName {
    return userNavigationDataCollection
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      return _userName(snapshot);
    });
  }

//MAPPING TO USER MODEL
  UserModel _userName(DocumentSnapshot snapshot) {
    // print('Snapshot $snapshot');
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    log("User Data; $data");
    //log('User exist : ${snapshot.data().}');
    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
    );
  }

  Future createBeacon(
      BeaconEstimote beaconEstimote, RootChangeNotifier changeNotifier) async {
    changeNotifier.setState(ViewState.BUSY);
    // final task = await StorageService.uploadFile(
    //     destination:
    //         'beaconsimage/${beaconEstimote.identifier}/${basename(imageFile.path)}',
    //     file: imageFile);
    // beaconEstimote.pictureLink = await task.ref.getDownloadURL();
    await beaconsDataCollection.doc(beaconEstimote.identifier).set({
      'name': beaconEstimote.name,
      'identifier': beaconEstimote.identifier,
      'major': beaconEstimote.major,
      'minor': beaconEstimote.minor,
      'uuid': beaconEstimote.uuid,
      // 'pictureLink': beaconEstimote.pictureLink
    });
    changeNotifier.setState(ViewState.IDLE);
  }

  Future updateBeacon(Map<String, dynamic> dataToUpdate,
      BeaconEstimote beaconEstimote, RootChangeNotifier rootChangeNotifier,
      {File? imageFile}) async {
    rootChangeNotifier.setState(ViewState.BUSY);
    if (imageFile != null) {
      final task = await StorageService.uploadFile(
          destination:
              'beaconsimage/${beaconEstimote.identifier}/${basename(imageFile.path)}',
          file: imageFile);
      dataToUpdate['pictureLink'] = await task.ref.getDownloadURL();
    }
    await beaconsDataCollection
        .doc(beaconEstimote.uuid)
        .update(dataToUpdate)
        .catchError((e) {
      log('Error : $e');
      rootChangeNotifier.setState(ViewState.IDLE);
    }).whenComplete(() => rootChangeNotifier.setState(ViewState.IDLE));
  }

  Stream<List<BeaconEstimote>> get listOfBeacons {
    return beaconsDataCollection
        .snapshots()
        .map((event) => _listBeacons(event));
  }

  List<BeaconEstimote> _listBeacons(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => BeaconEstimote(
              identifier: e['identifier'],
              name: e['name'],
              uuid: e['uuid'],
              major: e['major'],
              minor: e['minor'],
            ))
        .toList();
  }
}
