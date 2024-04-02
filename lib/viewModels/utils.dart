import 'package:call_poc_2/views/patientFlow.dart';

Map<String, dynamic> getPage(String id) {
  switch (id) {
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
