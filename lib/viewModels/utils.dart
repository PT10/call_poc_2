import 'package:call_poc_2/settings.dart';
import 'package:call_poc_2/views/loginFlow.dart';
import 'package:call_poc_2/views/patientFlow.dart';

Map<String, dynamic> getPage(String id) {
  switch (id) {
    case 'login':
      return login;
    case 'otpSignInPage':
      return otpSignInPage;
    case 'patientHomeScreen':
      return patientHomeScreen;
    case 'patientDashboard':
      return patientDashboard;
    case 'roundedIconWithText':
      return roundedIconWithText;
    case 'doctorListVicinity':
      return doctorListVicinity;
    case 'doctorListItem':
      return doctorListItem;
    case 'paymentPopup':
      return paymentPopup;
    case 'videoCallPopUp':
      return videoCallPopUp;
    case 'videoCall':
      return videoCall;

    default:
      return {};
  }
}

List<Widget> skipNulls<Widget>(List<Widget?> items) {
  List<Widget> results = [];
  items.forEach((element) {
    if (element != null) results.add(element);
  });
  return results;
}

String? replaceVariables(String? input) {
  if (input == null) {
    return null;
  }
  String temp = input;
  globalVariables.keys.forEach((key) {
    if (input.contains(key)) {
      temp = temp.replaceAll(key, globalVariables[key] ?? '');
    }
  });

  return temp;
}
