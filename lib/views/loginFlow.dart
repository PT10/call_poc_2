var login = {
  "type": "layout",
  "subType": "column",
  "children": [
    {
      "type": "field",
      "subType": "dropDown",
      "buttonText": "Login As",
      "value": "0",
      "values": [
        {"id": "0", "name": "Patient"},
        {"id": "1", "name": "Doctor"}
      ],
      "id": "userType",
      "action": [
        {"type": "memoryUpdate", "var": "userType"},
        {"type": "refresh"}
      ]
    },
    {
      "type": "layout",
      "subType": "form",
      "children": [
        {
          "type": "field",
          "subType": "text",
          "initialText": "",
          "hintText": "User Email",
          "id": "email"
        },
        {
          "type": "field",
          "subType": "text",
          "obscure": true,
          "initialText": "",
          "hintText": "Password",
          "id": "password"
        },
        {
          "type": "field",
          "subType": "textButton",
          "showAsLink": true,
          "align": "right",
          "buttonText": "OTP Sign in",
          "action": [
            {"type": "navigate", "data": [], "pageId": "otpSignInPage"}
          ]
        }
      ],
      "actions": [
        {
          "type": "field",
          "subType": "submit",
          "condition": {"var": "userType", "op": "eq", "val": "0"},
          "buttonText": "Sign in (Patient)",
          "submitAction": {
            "api": "__SERVER__/patient_controller/login",
            "params": {
              "email": "__val__",
              "password": "__val__",
              "login_type": "0"
            }
          },
          "action": [
            {"type": "navigateFresh", "data": [], "pageId": "patientHomeScreen"}
          ]
        },
        {
          "type": "field",
          "condition": {"var": "userType", "op": "eq", "val": "1"},
          "subType": "submit",
          "buttonText": "Sign in (Doctor)",
          "submitAction": {
            "api": "__SERVER__/doctor_controller/login",
            "params": {
              "email": "__val__",
              "password": "__val__",
              "login_type": "0"
            }
          },
          "action": [
            {
              "type": "navigateFresh",
              "data": ["patient_id", "latitude", "longitude"],
              "pageId": "patientHomeScreen"
            }
          ]
        },
      ]
    }
  ]
};

var otpSignInPage = {
  "type": "layout",
  "subType": "form",
  "children": [
    {
      "type": "field",
      "subType": "text",
      "initialText": "",
      "hintText": "Phone number",
      "id": "phone"
    },
    {
      "type": "field",
      "subType": "textButton",
      "buttonText": "Sign in",
      "submitAction": {
        "api": "__SERVER__/symptom_controller/list2",
        "params": {"emergency_type": "1", "accidental_type": "0"}
      },
      "action": [
        {"type": "navigate", "data": [], "pageId": "otpSignInPage"}
      ]
    },
  ]
};
