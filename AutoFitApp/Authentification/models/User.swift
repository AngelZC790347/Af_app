//
//  User.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 26/05/24.
//

import Foundation

struct User{
    let id      :Int
    let userName:String
    let email   :String    
}
//{"token": token.key}
struct AuthResponse:Codable{
    let token:String
}
