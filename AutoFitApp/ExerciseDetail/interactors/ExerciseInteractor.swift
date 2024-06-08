//
//  ExerciseInteractor.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import Foundation
protocol ExerciseInteractor{
    func getExercises() async throws->[Exercise]
}

class ExerciseInteractorMock:ExerciseInteractor{
    func getExercises() async throws -> [Exercise] {
        return try await Common.parseJson(location: .PATH("exerciseMock"), model: [Exercise].self)
    }
}
class ExerciseInteractorApi:ExerciseInteractor{
    func getExercises() async throws -> [Exercise] {
        return try await Common.parseJson(location: .API(RequestModel(baseUrL: .api, endpoint: "exercises", queryParams: [:])), model: [Exercise].self)
    }
}
