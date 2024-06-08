//
//  Routine.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 23/05/24.
//

import Foundation

struct Routine:Codable,Identifiable,Hashable{
    let id:Int
    let name:String
    let created:Date
    let user:Int
}




