


import 'package:jin_net/request/jin_net_request.dart';

abstract class BaseRequest extends JinNetRequest {
  @override
  String url() {
    if (needLogin()) {
      //给需要登录的接口携带登录令牌
      // addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }
    return super.url();
  }

  Map<String, dynamic> header = {
    // HiConstants.authTokenK: HiConstants.authTokenV,
    // HiConstants.courseFlagK: HiConstants.courseFlagV
  };

}