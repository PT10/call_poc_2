var conciergeScaffold = {
  "type": "layout",
  "subType": "scaffold",
  "appBar": {"title": "Namaste Health Concierge"},
  "children": [
    {"type": "layout", "subType": "page", "pageId": "conciergeHomeScreen"}
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
                {"latitude": "19.10179212"},
                {"longitude": "72.83892889"},
                "specialisation_id"
              ],
              "pageId": "searchContainer"
            }
          ]
        },
      ]
    }
  ]
};

var searchContainer = {
  "type": "layout",
  "subType": "column",
  "customDataModel": "doctorSearchModel",
  "children": [
    {
      "type": "layout",
      "subType": "column",
      "children": [
        {
          "type": "field",
          "subType": "label",
          "label": "Selected doctors",
          "giveEqualFlex": false
        },
        {
          "type": "layout",
          "subType": "list",
          "horizontal": true,
          "consumeCustomDataModel": true,
          "itemRenderer": {"pageId": "selectedDoctorRenderer"},
          "emptyText": "No doctors added to the group"
        }
      ],
      "flex": 1
    },
    {
      "type": "layout",
      "subType": "column",
      "flex": 5,
      "children": [
        {
          "type": "field",
          "subType": "label",
          "label": "Available doctors",
          "giveEqualFlex": false
        },
        {
          "type": "layout",
          "subType": "page",
          "pageId": "searchTabs",
        }
      ]
    }
  ]
};

var selectedDoctorRenderer = {
  "type": "field",
  "subType": "tileButton",
  "buttonTextFieldInData": "name",
  "action": [
    {"type": "customProviderUpdate", "idField": "_id"}
  ]
};

var searchTabs = {
  "type": "layout",
  "subType": "tab",
  "children": [
    {
      "type": "layout",
      "subType": "page",
      "pageId": "doctorSearchPage",
    },
    {
      "type": "layout",
      "subType": "page",
      "pageId": "doctorSearchPage2",
    }
  ]
};

var doctorSearchPage = {
  "type": "layout",
  "subType": "list",
  "title": "Available nearby",
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

var doctorSearchPage2 = {
  "type": "layout",
  "subType": "list",
  "title": "Available farther",
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
  "consumeCustomDataModel": true,
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
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "video_icon",
      "buttonText": "Remove from Group",
      //"consumeCustomDataModel": true, // added on parent
      "condition": {
        "type": "customDataModel",
        "op": "contains",
        "idField": "_id"
      },
      "action": [
        {"type": "customProviderUpdate", "idField": "_id"}
      ]
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "video_icon",
      "buttonText": "Add to Group",
      //"consumeCustomDataModel": true, //added on parent
      "condition": {
        "type": "customDataModel",
        "op": "!contains",
        "idField": "_id"
      },
      "action": [
        {"type": "customProviderUpdate", "idField": "_id"}
      ]
    }
  ]
};
