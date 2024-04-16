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
          "hintText": "Patient ID",
          "id": "email"
        },
      ],
      "actions": [
        {
          "type": "field",
          "subType": "submit",
          "condition": {"var": "userType", "op": "eq", "val": "0"},
          "buttonText": "Submit",
          "submitAction": {
            "api": "__SERVER__/concierge_controller/get_patient_call_details",
            "params": {"patient_id": "__val__"}
          },
          "action": [
            {"type": "navigateFresh", "data": [], "pageId": "patientHomeScreen"}
          ]
        },
      ]
    }
  ]
};
