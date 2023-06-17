import 'package:fluttertoast/fluttertoast.dart';

class AppConsts {
  ///AppColors Theme

  ///Flutter Toast Message
  static void showMessage(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
