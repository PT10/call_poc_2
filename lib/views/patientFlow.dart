var patientHomeScreen = {
  "type": "layout",
  "subType": "column",
  "children": [
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "Connect with emergency specialist",
      "action": {"type": "navigate", "pageId": "patientDashboard"}
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
          "action": {"type": "launch_app", "data": [], "appId": ""}
        },
        {
          "type": "field",
          "subType": "iconButton",
          "iconUrl": "",
          "buttonText": "Home Visit",
          "action": {"type": "popup", "cmpId": ""}
        }
      ]
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "SOS",
      "action": {"type": "popup", "componentId": ""}
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
      "itemRenderer": {"pageId": "roundedIconWithText"},
      "initAction": {
        "api": "http://192.168.0.100:4009/symptom_controller/list2",
        "params": {"emergency_type": "1", "accidental_type": "0"}
      }
    },
    {
      "type": "field",
      "subType": "textButton",
      "buttonText": "Any other illness",
      "action": {
        "type": "navigate",
        "data": [
          {"symptom": "1"},
          {"specialisation": "Hospitals with ICU & OT"}
        ],
        "pageId": "doctorListVicinity"
      }
    },
    {
      "type": "field",
      "subType": "textButton",
      "buttonText": "Accidents & Emergeincies",
      "action": {
        "type": "navigate",
        "data": [
          {"symptom": "1"},
          {"specialisation": "Hospitals with ICU & OT"}
        ],
        "pageId": "doctorListVicinity"
      }
    },
  ]
};

var roundedIconWithText = {
  "type": "field",
  "subType": "iconButton",
  "idField": "_id",
  "buttonTextFieldInData": "symptom_name",
  "action": {
    "type": "navigate",
    "data": ["specialisation_id"],
    "pageId": "doctorListVicinity"
  }
};

var doctorListVicinity = {
  "type": "layout",
  "subType": "list",
  "itemRenderer": {"pageId": "doctorListItem"},
  "initAction": {
    "api": "http://192.168.0.100:4009/order_controller/doctor_search",
    "params": {
      "specialisation_id": "__val__",
      "latitude": "18.577954759165255",
      "longitude": "73.76560389261459",
      "patient_id": "65c9f89d031272e866295a9a",
      "gender_id": "2",
      "location_id": "1",
      "location_text": "Mumbai"
    }
  }
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
          "action": {
            "type": "popup",
            "pageId": "paymentPopup",
            "data": [
              "doctor_id",
              "patient_id",
              "specialisation_id",
              "lattitude",
              "longitude"
            ]
          }
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
      "type": "field",
      "subType": "label",
      "initAction": {
        "api": "symptom_controller/patient_call_details",
        "params": {"patient_id": "__val__"}
      },
      "valueField": "message"
    }
  ],
  "actions": [
    {
      "type": "field",
      "subType": "textButton",
      "buttonText": "Agree",
      "action": {
        "type": "navigate",
        "data": [
          "amount",
          "doctor_id",
          "patient_id",
          "specialisation_id",
          "latitude",
          "longitude"
        ],
        "pageId": "razorPay"
      }
    },
  ]
};

var razorPay = {
  "type": "customCmp",
  "subType": "razorPay",
  "params": [
    {"key": ""}
  ],
  "action": {
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
};

var videoCallPopUp = {
  "type": "layout",
  "subType": "popup",
  "timeout": 30000,
  "children": [
    {"type": "field", "subType": "label", "label": "Calling.. please wait.."}
  ],
  "afterInitAction": [
    {
      "api": "order_controller/create",
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
      "api": "notification_controller/video_call",
      "params": {
        "sender_id": "__val__",
        "receiver_id": "__val__",
        "channel_name": "__val__",
        "call_type": "0",
        "order_id": ""
      }
    },
    {
      "api": "order_controller/call_status_notify",
      "params": ["order_id"],
      "mode": "poll",
      "interval": 500,
      "timeout": 30000,
      "breakCondition": {"field": "data", "op": "eq", "value": "1"},
      "action": {
        "type": "navigate",
        "data": {
          "channel_name": "__val__",
          "isPromotionalCall": "__val__",
          "promotionalCallMsg": "__val__",
          "order_id_sender": "__val__",
          "doctor_id_fcm": "__val__",
          "calling_from": "__val__",
          "doctor_name_fcm": "__val__",
          "doctor_specialisation": "__val__",
          "patient_name": "__val__",
          "doctor_distance": "__val__",
          "is_server_call": "__val__",
          "isOtherEmergency": "__val__",
          "specialization_id": "__val__",
          "amount": "__val__"
        },
        "pageId": "videoCall"
      }
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
      "subType": "callPage",
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "",
      "align": "bottom",
      "action": {
        "type": "navigate",
        "pageId": "uploadDoc",
        "data": [
          "order_id_sender",
        ]
      }
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "",
      "align": "bottom",
      "action": {"type": "navigate", "pageId": "patientDashboard"}
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "",
      "align": "bottom",
      "action": {"type": "navigate", "pageId": "patientDashboard"}
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
          "action": {"close": "true"}
        },
        {
          "type": "field",
          "subType": "textButton",
          "buttonText": "Submit",
          "action": {
            "type": "api",
            "api": "patient_controller/upload",
            "close": "true"
          }
        }
      ]
    }
  ]
};
