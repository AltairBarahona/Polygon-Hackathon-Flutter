import 'dart:io';

class Environment {
  //1. ESto es para probar con backend local
  // static String donatyApiUrl =
  // Platform.isAndroid ? 'http://10.0.2.2:3001' : 'http://localhost:3001';
  // http://polygon-alb-1640202886.us-east-2.elb.amazonaws.com/

  static String donatyApiUrl = Platform.isAndroid
      ? 'http://polygon-alb-1640202886.us-east-2.elb.amazonaws.com'
      : 'http://polygon-alb-1640202886.us-east-2.elb.amazonaws.com';
}
