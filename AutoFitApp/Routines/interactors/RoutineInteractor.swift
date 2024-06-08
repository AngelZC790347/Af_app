//
//  Interactor.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import Foundation
protocol RoutineInteractor{
    func getRoutine() async throws -> [Routine]
}

struct RoutineAFitApi:RoutineInteractor{
    static let shared = RoutineAFitApi()
    func getRoutine() async throws-> [Routine] {
        return try await Common.parseJson(location:.API(RequestModel(baseUrL: .api, endpoint: "routines/", queryParams: [:])), model: [Routine].self,loginRequired: true)
    }
}
struct RoutineAFitMock:RoutineInteractor{
    func getRoutine() async throws-> [Routine] {
        return try await Common.parseJson(location: .PATH("routinesMock"), model: [Routine].self)
    }
    
    
}

