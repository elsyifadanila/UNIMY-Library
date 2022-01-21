import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:unimy_beacon_navigation/constant.dart';
import 'package:unimy_beacon_navigation/model/beacon_view_model.dart';
import 'package:unimy_beacon_navigation/rssi_signal_helper.dart';
import 'package:unimy_beacon_navigation/widget/custom_text_form_field_widget.dart';

import 'add_beacon_screen.dart';
import '../../model/beacon_view_model.dart';

class NavigationBeaconScreen extends StatefulWidget {
  // final Map<RegionViewModel, List<BeaconViewModel>> regionBeacons;
  final Map<Region, List<BeaconViewModel>> regionBeacons;
  final bool isLoading;
  const NavigationBeaconScreen(
      {Key? key, required this.regionBeacons, required this.isLoading})
      : super(key: key);

  @override
  _NavigationBeaconScreenState createState() => _NavigationBeaconScreenState();
}

class _NavigationBeaconScreenState extends State<NavigationBeaconScreen>
    with WidgetsBindingObserver {
  bool isCheckedBook = false;
  var searchController = TextEditingController();
  bool isCheckedSubject = false;
  @override
  void initState() {
    super.initState();
  }
  // var listBeaconsGlobal = <BeaconEstimote>[];
  // final controller = Get.find<RequirementStateController>();
  // StreamSubscription<BluetoothState>? streamBluetooth;
  // StreamSubscription<RangingResult>? streamRanging;
  // final regionBeacons = <Region, List<BeaconViewModel>>{};
  // var beacons = <BeaconViewModel>[];
  // var regions = <Region>[];

  // bool _isLoading = true;
  // @override
  // void initState() {
  //   WidgetsBinding.instance?.addObserver(this);

  //   listeningBluetoothState();
  //   print('Controller initialized : ${controller.initialized}');
  //   controller.startStream.listen((flag) {
  //     printInfo(info: 'start stream $flag');
  //     if (flag == true) {
  //       initScanBeacon();
  //     }
  //   }, onDone: () {
  //     print('Done start subscription');
  //   });

  //   controller.pauseStream.listen((flag) {
  //     printInfo(info: 'pause stream $flag');
  //     if (flag == true) {
  //       pauseScanBeacon();
  //     }
  //   }, onDone: () {
  //     print('Done pause subscription');
  //   });
  //   print('INIT STATE');
  //   super.initState();
  // }

  // getFromDatabase() {
  //   DatabaseService().listOfBeacons.listen((listBeacons) {
  //     print('listBeacons $listBeacons');
  //     if (listBeacons.isNotEmpty) {
  //       setState(() {
  //         listBeaconsGlobal = listBeacons;
  //       });
  //       for (var e in listBeacons) {
  //         regions.add(Region(
  //             identifier: e.identifier!,
  //             proximityUUID: e.uuid,
  //             major: e.major,
  //             minor: e.minor));
  //       }
  //       controller.updateRegionsList(regions);
  //     } else {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   });
  // }

  // initScanBeacon() async {
  //   print('INITSCANNING');
  //   await flutterBeacon.initializeScanning;
  //   print('Test: '
  //       'RETURNED, authorizationStatusOk=${controller.authorizationStatusOk}, '
  //       'locationServiceEnabled=${controller.locationServiceEnabled}, '
  //       'bluetoothEnabled=${controller.bluetoothEnabled}');
  //   if (!controller.authorizationStatusOk ||
  //       !controller.locationServiceEnabled ||
  //       !controller.bluetoothEnabled) {
  //     print(
  //         'RETURNED, authorizationStatusOk=${controller.authorizationStatusOk}, '
  //         'locationServiceEnabled=${controller.locationServiceEnabled}, '
  //         'bluetoothEnabled=${controller.bluetoothEnabled}');
  //     return;
  //   }

  //   if (streamRanging != null) {
  //     if (streamRanging!.isPaused) {
  //       streamRanging?.resume();
  //       return;
  //     }
  //   }

  //   controller.regionList.listen((event) {
  //     if (event.isNotEmpty) {
  //       streamRanging =
  //           flutterBeacon.ranging(event).listen((RangingResult result) {
  //         print('Ranging Result $result');
  //         if (mounted) {
  //           setState(() {
  //             var _name = listBeaconsGlobal
  //                 .firstWhere(
  //                     (element) =>
  //                         element.identifier == result.region.identifier,
  //                     orElse: () => BeaconEstimote(name: null))
  //                 .name;
  //             if (_name != null) {
  //               beacons = result.beacons
  //                   .map((e) => BeaconViewModel(beacon: e, name: _name))
  //                   .toList();
  //               regionBeacons[result.region] = beacons;
  //               print('Map Region beacons $regionBeacons');
  //             }
  //           });
  //         }
  //       }, onError: (e) {
  //         printError(info: 'Error listening to region list $e');
  //       }, cancelOnError: true);
  //       print(streamRanging!.reactive.value);
  //     }
  //   });

  //   getFromDatabase();
  // }

  // pauseScanBeacon() async {
  //   streamRanging?.pause();
  //   if (beacons.isNotEmpty) {
  //     setState(() {
  //       beacons.clear();
  //     });
  //   }
  // }

  // @override
  // void dispose() async {
  //   // await flutterBeacon.close;

  //   streamBluetooth?.cancel();
  //   streamRanging?.cancel();
  //   print('DISPOSE');
  //   super.dispose();
  // }

  // listeningBluetoothState() async {
  //   print('Listening to bluetooth state');
  //   streamBluetooth = flutterBeacon
  //       .bluetoothStateChanged()
  //       .listen((BluetoothState state) async {
  //     print('Bluetooth ${state.toString()}');
  //     controller.updateBluetoothState(state);
  //     await checkAllRequirements();
  //   });
  // }

  // checkAllRequirements() async {
  //   final bluetoothState = await flutterBeacon.bluetoothState;
  //   controller.updateBluetoothState(bluetoothState);
  //   print('BLUETOOTH $bluetoothState');
  //   if (bluetoothState == BluetoothState.stateOff) {
  //     handleOpenBluetooth();
  //   }

  //   final authorizationStatus = await flutterBeacon.authorizationStatus;
  //   controller.updateAuthorizationStatus(authorizationStatus);
  //   print('AUTHORIZATION $authorizationStatus');
  //   if (authorizationStatus == AuthorizationStatus.notDetermined) {
  //     await flutterBeacon.requestAuthorization;
  //   }

  //   final locationServiceEnabled =
  //       await flutterBeacon.checkLocationServicesIfEnabled;
  //   controller.updateLocationService(locationServiceEnabled);
  //   print('LOCATION SERVICE $locationServiceEnabled');
  //   if (!locationServiceEnabled) {
  //     handleOpenLocationSettings();
  //   }
  //   if (controller.bluetoothEnabled &&
  //       controller.authorizationStatusOk &&
  //       controller.locationServiceEnabled) {
  //     print('STATE READY');

  //     print('SCANNING');
  //     controller.startScanning();
  //     // initScanBeacon();
  //   } else {
  //     print('STATE NOT READY');
  //     controller.pauseScanning();
  //   }
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   print('AppLifecycleState = $state');
  //   if (state == AppLifecycleState.resumed) {
  //     if (streamBluetooth != null) {
  //       if (streamBluetooth!.isPaused) {
  //         streamBluetooth?.resume();
  //       }
  //     }
  //     await checkAllRequirements();
  //   } else if (state == AppLifecycleState.paused) {
  //     streamBluetooth?.pause();
  //   }
  // }

  // handleOpenBluetooth() async {
  //   if (Platform.isAndroid) {
  //     try {
  //       await flutterBeacon.openBluetoothSettings;
  //     } on PlatformException catch (e) {
  //       print(e);
  //     }
  //   } else if (Platform.isIOS) {
  //     await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Bluetooth is Off'),
  //           content:
  //               const Text('Please enable Bluetooth on Settings > Bluetooth.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // handleOpenLocationSettings() async {
  //   if (Platform.isAndroid) {
  //     await flutterBeacon.openLocationSettings;
  //   } else if (Platform.isIOS) {
  //     await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Location Services Off'),
  //           content: const Text(
  //             'Please enable Location Services on Settings > Privacy > Location Services.',
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    print('WIDTH : $width');
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.chevronLeft),
                onPressed: () => Navigator.of(context).pop(),
              )
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Navigation Beacons',
                            style: titleStyle,
                          ),
                        ),
                        Text(
                          'Navigate your beacon',
                          style: subtitleStyle2,
                        ),
                      ],
                    ),
                  ),
                ]),
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Admin())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Add Beacons',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  Icon(Icons.add)
                ],
              ),
            ),
            Row(
              children: [
                const Expanded(child: Text('Search by: ')),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isCheckedBook,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedBook = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('Book')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isCheckedSubject,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedSubject = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('Subject')
                  ],
                ),
              ],
            ),
            Column(
              children: [
                const Text('What book/genre are you looking for?'),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  controller: searchController,
                  label: 'Search',
                  icon: const Icon(Icons.search),
                  obscureText: false,
                )
              ],
            ),
            GestureDetector(onTap: () {}, child: const Text('Book Details')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Shelf: (From Database)'),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    color: Colors.grey,
                    height: height * 0.6,
                    child: const Center(
                      child: Text('*Navigation Map*'),
                    ),
                  )
                ],
              ),
            ),
            widget.regionBeacons.isEmpty && widget.isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : widget.regionBeacons.isEmpty && widget.isLoading == false
                    ? const Center(child: Text('No Beacons'))
                    : Container(
                        height: width,
                        width: width,
                        child: Center(
                          child: Stack(
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: width * 0.8,
                                      width: width * 0.8,
                                      decoration: BoxDecoration(
                                          color: Colors.blue[100],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(512))),
                                    ),
                                    Positioned(
                                      top: width * 0.05,
                                      left: width * 0.05,
                                      child: Container(
                                        height: width * 0.7,
                                        width: width * 0.7,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(512))),
                                      ),
                                    ),
                                    Positioned(
                                      top: width * 0.1,
                                      left: width * 0.1,
                                      child: Container(
                                        height: width * 0.6,
                                        width: width * 0.6,
                                        decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(512))),
                                      ),
                                    ),
                                    Positioned(
                                      top: width * 0.15,
                                      left: width * 0.15,
                                      child: Container(
                                        height: width * 0.5,
                                        width: width * 0.5,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(512))),
                                      ),
                                    ),
                                    Positioned(
                                      top: width * 0.2,
                                      left: width * 0.2,
                                      child: Container(
                                        height: width * 0.4,
                                        width: width * 0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(512))),
                                      ),
                                    ),
                                    Positioned(
                                      top: width * 0.25,
                                      left: width * 0.25,
                                      child: Container(
                                        height: width * 0.3,
                                        width: width * 0.3,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(512))),
                                      ),
                                    ),
                                    Positioned(
                                      top: width * 0.3,
                                      left: width * 0.3,
                                      child: Container(
                                        height: width * 0.2,
                                        width: width * 0.2,
                                        decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(512))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Stack(
                                  children:
                                      widget.regionBeacons.values.map((e) {
                                    return Positioned(
                                        top: width *
                                                RssiSignal.coefficient(
                                                    (e.first.beacon!.accuracy *
                                                            100)
                                                        .toInt()) +
                                            36

                                        //  width *
                                        //     ((e.first.beacon!.accuracy * 100) /
                                        //         1000)
                                        // (width * 0.38).toPrecision(2) *
                                        //         (e.first.beacon!.accuracy) +
                                        //     36
                                        ,
                                        left: width *
                                            RssiSignal.coefficient(
                                                (e.first.beacon!.accuracy * 100)
                                                    .toInt()),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 15,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[200],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                16))),
                                              ),
                                              Text(e.first.name!),
                                              Text(
                                                  'x: ${(width * RssiSignal.coefficient((e.first.beacon!.accuracy * 100).toInt())).toPrecision(1)}'),
                                              Text(
                                                  'y: ${(width * RssiSignal.coefficient((e.first.beacon!.accuracy * 100).toInt())).toPrecision(1)}')
                                            ],
                                          ),
                                        ));
                                  }).toList(),
                                  // children: [
                                  //   Positioned(
                                  //     top: width * 0.38,
                                  //     left: width * 0.38,
                                  //     child: Stack(
                                  //       children: [
                                  //         Container(
                                  //           width: 10,
                                  //           height: 10,
                                  //           color: Colors.red,
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
            // : GridView.count(
            //     childAspectRatio: 0.6,
            //     shrinkWrap: true,
            //     physics: const ClampingScrollPhysics(),
            //     primary: false,
            //     padding: const EdgeInsets.all(20),
            //     crossAxisSpacing: 20,
            //     mainAxisSpacing: 10,
            //     crossAxisCount: 2,
            //     children: widget.regionBeacons.entries.map(
            //       (beacon) {
            //         return Card(
            //           child: Container(
            //             padding: const EdgeInsets.all(8.0),
            //             child: beacon.value.isEmpty
            //                 ? const Text('Connecting to beacons')
            //                 : Column(
            //                     crossAxisAlignment:
            //                         CrossAxisAlignment.start,
            //                     children: [
            //                       Container(
            //                         decoration: const BoxDecoration(
            //                             borderRadius: BorderRadius.all(
            //                                 Radius.circular(8)),
            //                             color: Colors.green),
            //                         height: 8,
            //                         width: 8,
            //                       ),
            //                       Expanded(
            //                         child: ListView.builder(
            //                             shrinkWrap: true,
            //                             itemCount: beacon.value.length,
            //                             itemBuilder: (context, i) {
            //                               return Padding(
            //                                 padding:
            //                                     const EdgeInsets.all(
            //                                         8.0),
            //                                 child: Column(
            //                                   crossAxisAlignment:
            //                                       CrossAxisAlignment
            //                                           .start,
            //                                   children: [
            //                                     Text(
            //                                       'Name : ${beacon.value[i].name!}',
            //                                       style:
            //                                           subtitleStyle2Small,
            //                                     ),
            //                                     Text(
            //                                       'Signal: ${RssiSignal.rssiTranslator(beacon.value[i].beacon!.rssi)}',
            //                                       style:
            //                                           subtitleStyle2Small,
            //                                     ),
            //                                     Text(
            //                                       'Distance:  ${beacon.value[i].beacon!.accuracy.toString()} m',
            //                                       style:
            //                                           subtitleStyle2Small,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               );
            //                             }),
            //                       ),
            //                     ],
            //                   ),
            //           ),
            //         );
            //       },
            //     ).toList(),
            //   )
          ],
        ),
      ),
    );
  }
}
