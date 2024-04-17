var homeScreen = {
  "type": "layout",
  "subType": "scaffold",
  "appBar": {
    "type": "layout",
    "subType": "appBar",
    "title": "Namaste Health",
    "menu": [
      {
        "type": "field",
        "subType": "iconButton",
        "condition": {"var": "userType", "op": "eq", "val": "0"},
        "iconUrl": "",
        "buttonText": "About",
        "action": [
          {"type": "navigate", "pageId": "about", "data": []},
        ]
      },
      {
        "type": "field",
        "subType": "iconButton",
        "condition": {"var": "userType", "op": "eq", "val": "0"},
        "iconUrl": "",
        "buttonText": "Logout",
        "action": [
          {
            "type": "api",
            "api": "__SERVER__/patient_controller/logout",
            "params": {
              "patient_id": "__val__",
            }
          },
          {"type": "navigate", "pageId": "login", "data": []},
        ]
      },
    ],
    "actions": [
      {
        "type": "field",
        "subType": "iconButton",
        "condition": {"var": "userType", "op": "eq", "val": "0"},
        "iconUrl": "",
        "buttonText": "Logout",
        "action": [
          {
            "type": "api",
            "api": "__SERVER__/patient_controller/logout",
            "params": {
              "patient_id": "__val__",
            },
            "onSuccess": {
              "action": {"type": "navigate", "pageId": "login", "data": []}
            },
            "onFailure": {}
          },
        ]
      },
      {
        "type": "field",
        "subType": "iconButton",
        "condition": {"var": "userType", "op": "eq", "val": "1"},
        "iconUrl": "",
        "buttonText": "Logout",
        "action": [
          {
            "type": "api",
            "api": "__SERVER__/doctor_controller/logout",
            "params": {
              "doctor_id": "__val__",
            }
          },
          {"type": "navigate", "pageId": "login", "data": []},
        ]
      },
      {
        "type": "field",
        "subType": "iconButton",
        "condition": {"var": "userType", "op": "eq", "val": "2"},
        "iconUrl": "",
        "buttonText": "Logout",
        "action": [
          {
            "type": "api",
            "api": "__SERVER__/concierge_controller/logout",
            "params": {
              "patient_id": "__val__",
            }
          },
          {"type": "navigate", "pageId": "login", "data": []},
        ]
      },
    ]
  },
  "children": [
    {
      "condition": {"var": "userType", "op": "eq", "val": "0"},
      "type": "page",
      "subType": "custom",
      "pageId": "patientHomeScreen"
    },
    {
      "condition": {"var": "userType", "op": "eq", "val": "1"},
      "type": "page",
      "subType": "custom",
      "pageId": "doctorHomeScreen"
    },
    {
      "condition": {"var": "userType", "op": "eq", "val": "2"},
      "type": "page",
      "subType": "custom",
      "pageId": "conciergeHomeScreen"
    }
  ],
  "bottomBar": [
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "Appointment",
      "action": [
        {
          "type": "api",
          "api": "__SERVER__/patient_controller/logout",
          "params": {
            "patient_id": "__val__",
          }
        },
        {"type": "navigate", "pageId": "login", "data": []},
      ]
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "Hospitals",
      "action": [
        {
          "type": "api",
          "api": "__SERVER__/patient_controller/logout",
          "params": {
            "patient_id": "__val__",
          }
        },
        {"type": "navigate", "pageId": "login", "data": []},
      ]
    }
  ]
};
