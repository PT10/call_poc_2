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
        {"id": "1", "name": "Doctor"},
        {"id": "2", "name": "Conceirge"}
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
        {
          "type": "field",
          "condition": {"var": "userType", "op": "eq", "val": "1"},
          "subType": "submit",
          "buttonText": "Sign in (Concierge)",
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
              "pageId": "conciergeHomeScreen"
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
      "hintText": "Mobile number",
      "id": "phone_number"
    },
  ],
  "actions": [
    {
      "type": "field",
      "subType": "submit",
      "condition": {"var": "userType", "op": "eq", "val": "1"},
      "buttonText": "Sign in",
      "submitAction": {
        "api": "__SERVER__/doctor_controller/login_by_otp",
        "params": {"phone_number": "__val__", "login_type": "0"}
      },
      "action": [
        {
          "type": "navigate",
          "data": [
            "phone_number",
            {"newKey": "doctor_id", "oldKey": "id"},
          ],
          "pageId": "enterOtpPage"
        }
      ]
    },
    {
      "type": "field",
      "subType": "submit",
      "condition": {"var": "userType", "op": "eq", "val": "0"},
      "buttonText": "Sign in",
      "submitAction": {
        "api": "__SERVER__/patient_controller/login_by_otp",
        "params": {"phone_number": "__val__", "login_type": "0"}
      },
      "action": [
        {
          "type": "navigate",
          "data": [
            "phone_number",
            {"newKey": "patient_id", "oldKey": "id"}
          ],
          "pageId": "enterOtpPage"
        }
      ]
    },
    {
      "type": "field",
      "subType": "submit",
      "condition": {"var": "userType", "op": "eq", "val": "2"},
      "buttonText": "Sign in",
      "submitAction": {
        "api": "__SERVER__/concierge_controller/login_by_otp",
        "params": {"phone_number": "__val__", "login_type": "0"}
      },
      "action": [
        {
          "type": "navigate",
          "data": [
            "phone_number",
            {"newKey": "patient_id", "oldKey": "id"}
          ],
          "pageId": "enterOtpPage"
        }
      ]
    },
  ]
};

var enterOtpPage = {
  "type": "layout",
  "subType": "form",
  "children": [
    {
      "type": "field",
      "subType": "text",
      "initialText": "",
      "hintText": "Enter OTP",
      "id": "otp"
    },
  ],
  "actions": [
    {
      "type": "field",
      "subType": "submit",
      "condition": {"var": "userType", "op": "eq", "val": "1"},
      "buttonText": "Sign in",
      "submitAction": {
        "api": "__SERVER__/doctor_controller/verify_otp",
        "params": {"phone_number": "__val__", "otp": "__val__", "type_otp": "1"}
      },
      "action": [
        {"type": "navigateFresh", "data": [], "pageId": "homeScreen"}
      ]
    },
    {
      "type": "field",
      "subType": "submit",
      "condition": {"var": "userType", "op": "eq", "val": "0"},
      "buttonText": "Sign in",
      "submitAction": {
        "api": "__SERVER__/patient_controller/verify_otp",
        "params": {"phone_number": "__val__", "otp": "__val__", "type_otp": "1"}
      },
      "action": [
        {
          "type": "navigateFresh",
          "data": [
            "patient_id",
            {"latitude": "18.577954759165255"},
            {"longitude": "73.76560389261459"}
          ],
          "pageId": "homeScreen"
        }
      ]
    },
    {
      "type": "field",
      "subType": "submit",
      "condition": {"var": "userType", "op": "eq", "val": "2"},
      "buttonText": "Sign in",
      "submitAction": {
        "api": "__SERVER__/concierge_controller/verify_otp",
        "params": {"phone_number": "__val__", "otp": "__val__", "type_otp": "1"}
      },
      "action": [
        {
          "type": "navigateFresh",
          "data": [
            "patient_id",
            {"latitude": "18.577954759165255"},
            {"longitude": "73.76560389261459"}
          ],
          "pageId": "conciergeScaffold"
        }
      ]
    },
  ]
};
