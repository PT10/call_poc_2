var callNotification = {
  "type": "layout",
  "subtype": "notificationPage",
  "actions": [
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "Accept",
      "action": [
        {
          "type": "navigate",
          "pageId": "videoCall",
          "data": ["patient_id", "latitude", "longitude"]
        }
      ]
    },
    {
      "type": "field",
      "subType": "iconButton",
      "iconUrl": "",
      "buttonText": "Reject",
      "action": [
        {
          "type": "close",
        }
      ]
    },
  ]
};
