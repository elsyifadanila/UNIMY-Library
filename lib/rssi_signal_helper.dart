import 'dart:math';

class RssiSignal {
  static String rssiTranslator(int rssi) {
    if (rssi >= -50) {
      return 'Excellent';
    } else if (rssi >= -60) {
      return 'Very Good';
    } else if (rssi >= -70) {
      return 'Good';
    } else if (rssi >= -80) {
      return 'Low';
    } else if (rssi >= -90) {
      return 'Very Low';
    } else if (rssi >= -100) {
      return 'Extremely slow';
    } else if (rssi == 0) {
      return 'No Signal';
    } else {
      return 'Unknown';
    }
  }

  static double coefficient(int distance) {
    final rand = Random().nextInt(2);
    print('DISTANCE :$distance');
    if (distance >= 200) {
      var list = [0.0, 1.0];
      return list[rand];
    } else if (distance >= 100) {
      var list = [0.1, 0.9];
      return list[rand];
    } else if (distance >= 80) {
      var list = [0.15, 0.85];
      return list[rand];
    } else if (distance >= 60) {
      var list = [0.2, 0.8];
      return list[rand];
    } else if (distance >= 40) {
      var list = [0.25, 0.75];
      return list[rand];
    } else if (distance >= 20) {
      var list = [0.3, 0.7];
      return list[rand];
    } else if (distance >= 0) {
      var list = [0.38, 0.38];
      return list[rand];
    } else {
      var list = [0.0, 1.0];
      return list[rand];
    }
    // final rand = Random().nextInt(2);
    // print('DISTANCE :$distance');
    // if (distance >= 200) {
    //   var list = [0.0, -0.0];
    //   return list[rand];
    // } else if (distance >= 100) {
    //   var list = [0.1, -0.1];
    //   return list[rand];
    // } else if (distance >= 80) {
    //   var list = [0.15, -0.15];
    //   return list[rand];
    // } else if (distance >= 60) {
    //   var list = [0.2, -0.2];
    //   return list[rand];
    // } else if (distance >= 40) {
    //   var list = [0.25, -0.25];
    //   return list[rand];
    // } else if (distance >= 20) {
    //   var list = [0.3, -0.3];
    //   return list[rand];
    // } else if (distance >= 0) {
    //   var list = [0.38, -0.38];
    //   return list[rand];
    // } else {
    //   var list = [0.0];
    //   return list[rand];
    // }
  }
}
