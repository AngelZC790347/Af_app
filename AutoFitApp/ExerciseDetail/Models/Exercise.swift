//
//  Exercise.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import Foundation
struct Exercise: Codable,Identifiable {
    let id: Int
    let name: String
    let image: String
    let type: Int
    let stimulus: [String]
}
