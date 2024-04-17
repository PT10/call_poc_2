var patientHomeScreen = {
  "type": "layout",
  "subType": "column",
  "initAction": [
    {
      "api": "__SERVER__/notification_controller/subscribe",
      "mode": "async",
      "params": {
        "token": "__FCM_TOKEN__",
        "device_type": "0",
        "mobile_device_id": "__DEVICE_ID__",
        "user_id": {"oldKey": "patient_id", "value": "__val__"},
        "type": {"oldKey": "userType", "value": "__val__"},
      }
    }
  ],
  "children": [
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "Connect with emergency specialist",
      "action": [
        {
          "type": "navigate",
          "pageId": "patientDashboard",
          "data": ["patient_id", "latitude", "longitude"]
        }
      ]
    },
    {
      "type": "layout",
      "subType": "row",
      "children": [
        {
          "type": "field",
          "subType": "iconButton",
          "iconUrl": "",
          "buttonText": "Ambulance",
          "action": [
            {"type": "navigate", "data": [], "pageId": "patientHomeScreen"}
          ]
        },
        {
          "type": "field",
          "subType": "iconButton",
          "iconUrl": "",
          "buttonText": "Home Visit",
          "action": [
            {"type": "navigate", "data": [], "pageId": "patientHomeScreen"}
          ]
        }
      ]
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "SOS",
      "action": [
        {"type": "navigate", "data": [], "pageId": "patientHomeScreen"}
      ]
    },
  ]
};
var patientDashboard = {
  "type": "layout",
  "subType": "column",
  "title": "Patient Dashboard",
  "children": [
    /* {
      "type": "field",
      "subType": "dropDown",
      "initAction": { "api": "",
      "params": [
        {"name": "emergency_type", "value": "1"},
        {"name": "accidental_type", "value": "1"}
      ]},
      "idField": "_id",
      "nameField": "symptom_name"
    },*/
    {
      "type": "layout",
      "subType": "grid",
      "numCols": 3,
      "itemRenderer": {
        "pageId": "roundedIconWithText",
        "data": ["patient_id", "latitude", "longitude"]
      },
      "initAction": [
        {
          "api": "__SERVER__/symptom_controller/list2",
          "params": {"emergency_type": "1", "accidental_type": "0"}
        }
      ]
    },
    {
      "type": "field",
      "subType": "textButton",
      "buttonText": "Any other illness",
      "action": [
        {
          "type": "navigate",
          "data": [
            "patient_id",
            "latitude",
            "longitude",
            {"symptom": "1"},
            {"specialisation": "Hospitals with ICU & OT"}
          ],
          "pageId": "doctorListVicinity"
        }
      ]
    },
    {
      "type": "field",
      "subType": "textButton",
      "buttonText": "Accidents & Emergeincies",
      "action": [
        {
          "type": "navigate",
          "data": [
            "patient_id",
            "latitude",
            "longitude",
            {"symptom": "1"},
            {"specialisation": "Hospitals with ICU & OT"}
          ],
          "pageId": "doctorListVicinity"
        }
      ]
    },
  ]
};

var roundedIconWithText = {
  "type": "field",
  "subType": "iconButton",
  "idField": "_id",
  "buttonTextFieldInData": "symptom_name",
  "action": [
    {
      "type": "navigate",
      "data": ["specialisation_id", "patient_id", "latitude", "longitude"],
      "pageId": "doctorListVicinity"
    }
  ]
};

var doctorListVicinity = {
  "type": "layout",
  "subType": "list",
  "itemRenderer": {"pageId": "doctorListItem"},
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

var doctorListItem = {
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

var paymentPopup = {
  "type": "layout",
  "subType": "popup",
  "children": [
    {
      "type": "layout",
      "subType": "column",
      "children": [
        {
          "type": "field",
          "subType": "label",
          "initAction": [
            {
              "api": "__SERVER__/symptom_controller/patient_call_details",
              "params": {"patient_id": "__val__"}
            }
          ],
          "valueField": "message"
        }
      ]
    }
  ],
  "actions": [
    {
      "type": "field",
      "subType": "textButton",
      "buttonText": "Agree",
      "action": [
        {
          "type": "popup",
          "data": [
            "amount",
            "doctor_id",
            "patient_id",
            "specialisation_id",
            "latitude",
            "longitude"
          ],
          "pageId": "videoCallPopUp"
        },
        {"type": "close"}
      ]
    },
    {
      "type": "field",
      "subType": "textButton",
      "buttonText": "Disagree",
      "action": [
        {"type": "close"}
      ]
    },
  ]
};

var razorPay = {
  "type": "customCmp",
  "subType": "razorPay",
  "params": [
    {"key": ""}
  ],
  "action": [
    {
      "type": "navigate",
      "data": [
        "amount",
        "doctor_id",
        "patient_id",
        "specialisation_id",
        "latitude",
        "longitude"
      ],
      "pageId": "videoCallPopUp"
    }
  ]
};

var videoCallPopUp = {
  "type": "layout",
  "subType": "popup",
  "timeout": 30000,
  "children": [
    {"type": "field", "subType": "label", "label": "Calling.. please wait.."}
  ],
  "initAction": [
    {
      "api": "__SERVER__/order_controller/create",
      "id": "create",
      "params": {
        "patient_id": "__val__",
        "specialisation_id": "__val__",
        "doctor_id": "__val__",
        "latitude": "__val__",
        "longitude": "__val__"
      }
    },
    {
      "api": "__SERVER__/notification_controller/video_call",
      "params": {
        "sender_id": {"oldKey": "patient_id", "value": "__val__"},
        "receiver_id": {"oldKey": "doctor_id", "value": "__val__"},
        "channel_name": "__randStr__",
        "call_type": "0",
        "order_id": {"oldKey": "_id", "value": "__val__"}
      }
    },
    {
      "api": "__SERVER__/order_controller/call_status_notify",
      "params": {"order_id": "__val__"},
      "mode": "poll",
      "interval": 500,
      "timeout": 30000,
      "breakCondition": {"field": "data", "op": "eq", "value": 1},
      "action": [
        {
          "type": "navigate",
          "data": [
            "channel_name",
            "isPromotional",
            "promotionalCallMsg",
            "order_id",
            "doctor_id",
            "calling_from",
            "doctor_name",
            "doctor_specialisation",
            "patient_name",
            "doctor_distance",
            "is_server_call",
            "isOtherEmergency",
            "specialization_id",
            "amount"
          ],
          "pageId": "videoCall"
        },
        {"type": "close"}
      ]
    }
  ],
};

var videoCall = {
  "type": "layout",
  "subType": "stack",
  "children": [
    {
      // TODO
      "type": "field",
      "subType": "agoraCallPage",
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "",
      "align": "bottom",
      "action": [
        {
          "type": "navigate",
          "pageId": "uploadDoc",
          "data": [
            "order_id_sender",
          ]
        }
      ]
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "",
      "align": "bottom",
      "action": [
        {"type": "navigate", "pageId": "patientDashboard"}
      ]
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "",
      "align": "bottom",
      "action": [
        {"type": "navigate", "pageId": "patientDashboard"}
      ]
    },
  ]
};

var uploadDoc = {
  "type": "layout",
  "subType": "popup",
  "children": [
    {
      "type": "layout",
      "subType": "form",
      "children": [
        {"type": "field", "subType": "fileBrowser", "id": "_file"}
      ],
      "actions": [
        {
          "type": "field",
          "subType": "textButton",
          "buttonText": "Cancel",
          "action": [
            {"close": "true"}
          ]
        },
        {
          "type": "field",
          "subType": "textButton",
          "buttonText": "Submit",
          "action": [
            {"type": "api", "api": "patient_controller/upload", "close": "true"}
          ]
        }
      ]
    }
  ]
};
