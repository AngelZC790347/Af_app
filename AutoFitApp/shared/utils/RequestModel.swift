//
//  RequestModel.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import Foundation



struct RequestModel{
    let baseUrL :BaseUrl
    let endpoint:String
    let queryParams : [String:String]?
    var httpMethod : HTTPMethod = .GET
    var httpBody : Data? = nil
    enum HTTPMethod:String{
        case POST
        case GET
    }
    func getUrl() -> String {
        return baseUrL.rawValue + endpoint
    }
    #if DEBUG
    enum BaseUrl:String{
        case api = "https://localhost:8000/api"
    }
    #else
    enum BaseUrl:String{
        case api = "https://web-production-f259.up.railway.app/api/"
    }
    #endif
    
}
