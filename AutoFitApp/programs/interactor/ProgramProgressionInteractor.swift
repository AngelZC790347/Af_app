//
//  ProgramProgrssionInteractor.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import Foundation

protocol ProgramProgressionInteractor{
    func getProgressions(routineId:Int) async throws-> [ProgressionResponse]
}
class ProgramProgression:ProgramProgressionInteractor{
    func getProgressions(routineId:Int) async throws -> [ProgressionResponse] {
        return try await Common.parseJson(location: .API(RequestModel(baseUrL: .api, endpoint: "routines/\(routineId)", queryParams: [:])), model: [ProgressionResponse].self)
    }
}
class ProgramProgressionMock:ProgramProgressionInteractor{
    func getProgressions(routineId:Int = 0) async throws -> [ProgressionResponse] {
        return try await Common.parseJson(location: .PATH("progressionMock"), model: [ProgressionResponse].self)
    }
}
