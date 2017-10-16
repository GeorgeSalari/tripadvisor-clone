class FlightsController < ApplicationController
  include UsersHelper
  def index

  end

  def google_api_respons
    resp = send_request(params)
  end

  def send_request(params)
    byebug
    results = RestClient.post "https://www.googleapis.com/qpxExpress/v1/trips/search?key=#{ENV[""]}", {
      "request": {
        "passengers": {
          "kind": "qpxexpress#passengerCounts",
          "adultCount": params[:adultCount].to_i,
          "childCount": params[:childCount].to_i,
          "infantInLapCount": params[:infantInLapCount].to_i,
          "infantInSeatCount": params[:infantInSeatCount].to_i,
          "seniorCount": params[:seniorCount].to_i
        },
        "slice": [
          {
            "kind": "qpxexpress#sliceInput",
            "origin": params[:origin],
            "destination": params[:destination],
            "date": params[:date].to_date,
            "maxStops": params[:maxStops].to_i || 10,
            "maxConnectionDuration": params[:maxConnectionDuration].to_i || 24,
            "preferredCabin": params[:preserredCabin] || "",
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
        "refundable": params[:refundable].to_i == 1 ,
        "solutions": params[:solutions].to_i
      }
    }.to_json, {content_type: :json, accept: :json}
  end
end

