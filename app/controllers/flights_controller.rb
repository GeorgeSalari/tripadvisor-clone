class FlightsController < ApplicationController
  include UsersHelper
  def google_api_respons
      resp = send_request
      byebug
  end

  def send_request
    results = RestClient.post "https://www.googleapis.com/qpxExpress/v1/trips/search?key=#{ENV["GOOGLE_API_KEY"]}", {
      "request": {
        "passengers": {
          "kind": "qpxexpress#passengerCounts",
          "adultCount": 1,
          "childCount": 1,
          "infantInLapCount": 1,
          "infantInSeatCount": 1,
          "seniorCount": 1
        },
        "slice": [
          {
            "kind": "qpxexpress#sliceInput",
            "origin": "KUL",
            "destination": "HKT",
            "date": "#{Date.today}",
            "maxStops": 1,
            "maxConnectionDuration": 3,
            "preferredCabin": "",
            "permittedDepartureTime": {
              "kind": "qpxexpress#timeOfDayRange",
              "earliestTime": "",
              "latestTime": ""
            },
            "permittedCarrier": [
              ""
            ],
            "alliance": "",
            "prohibitedCarrier": [
              ""
            ]
          }
        ],
        "maxPrice": "",
        "saleCountry": "",
        "ticketingCountry": "",
        "refundable": true,
        "solutions": 20
      }
    }.to_json, {content_type: :json, accept: :json}
  end
end

