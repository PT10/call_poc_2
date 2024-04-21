var conciergeScaffold = {
  "type": "layout",
  "subType": "scaffold",
  "appBar": {"title": "Namaste Health Concierge"},
  "children": [
    {"type": "layout", "subType": "custom", "pageId": "conciergeHomeScreen"}
  ]
};

var conciergeHomeScreen = {
  "type": "layout",
  "subType": "column",
  "children": [
    {
      "type": "layout",
      "subType": "form",
      "children": [
        {
          "type": "field",
          "subType": "text",
          "initialText": "",
          "hintText": "Enter Patient ID",
          "id": "patient_id"
        },
      ],
      "actions": [
        {
          "type": "field",
          "subType": "submit",
          "buttonText": "Submit",
          "submitAction": {
            "api": "__SERVER__/concierge_controller/get_patient_call_details",
            "params": {"patient_id": "__val__"}
          },
          "action": [
            {
              "type": "navigate",
              "data": [
                "patient_id",
                "latitude",
                "longitude",
                "specialisation_id"
              ],
              "pageId": "doctorSearchPage"
            }
          ]
        },
      ]
    }
  ]
};

var doctorSearchPage = {
  "type": "layout",
  "subType": "list",
  "itemRenderer": {"pageId": "conciergeDoctorListItem"},
  "initAction": [
    {
      "api": "__SERVER__/order_controller/doctor_search",
      "params": {
        "specialisation_id": "__val__",
        "latitude": "__val__",
        "longitude": "__val__",
        "patient_id": "__val__",
        "gender_id": "2",
        "location_id": "1",
        "location_text": "Mumbai"
      }
    }
  ]
};

var conciergeDoctorListItem = {
  "type": "layout",
  "subType": "column",
  "children": [
    {
      "type": "layout",
      "subType": "row",
      "children": [
        {"type": "field", "subType": "label", "valueField": "name"},
        {
          "type": "field",
          "subType": "iconButton",
          "iconUrl": "video_icon",
          "buttonText": "",
          "action": [
            {
              "type": "popup",
              "pageId": "paymentPopup",
              "data": [
                {"newKey": "doctor_id", "oldKey": "_id"},
                "patient_id",
                "specialisation_id",
                "latitude",
                "longitude"
              ]
            }
          ]
        }
      ]
    },
    {
      "type": "layout",
      "subType": "row",
      "children": [
        {
          "type": "field",
          "subType": "label",
          "label": "Exp - ",
          "valueField": "experience"
        }
      ]
    }
  ]
};
