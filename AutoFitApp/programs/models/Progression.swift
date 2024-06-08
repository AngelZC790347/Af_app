//
//  Progression.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import Foundation
enum DayOfWeek: Int, CaseIterable, Codable {
    case sunday = 0
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    // Propiedad para obtener el nombre completo del día
    var fullName: String {
        switch self {
        case .sunday: return "Sunday"
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        }
    }
    
    // Propiedad para obtener la abreviatura del día
    var shortName: String {
        switch self {
        case .sunday: return "Sun"
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        }
    }
}
enum CodingKeys: String, CodingKey {
    case id
    case reps
    case series
    case weight
    case exercise
    case progrmasDay = "day"
}
struct ProgressionResponse:Codable{
    var id:Int
    var reps:Int
    var series:Int
    var weight:Float
    var exercise:Int
    var progrmasDay:DayOfWeek
    
}
struct Progression:Identifiable{
    var id:Int
    var reps:Int
    var series:Int
    var weight:Float
    var exercise:Exercise
    var progrmasDay:DayOfWeek
}
