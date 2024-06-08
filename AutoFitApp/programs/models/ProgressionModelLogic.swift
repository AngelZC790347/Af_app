//
//  ProgressionModelLogic.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import Foundation
enum ProgressionError:Error{
    case invalidExerciseId
}
@Observable
class ProgressionModelLogic{
    var progresion = [Progression]()
    var interactor:ProgramProgressionInteractor
    var exerciseModelLogic:ExerciseModelLogic
    var progresionByDay:[DayOfWeek:[Progression]]{
        return progresion.reduce(into: [DayOfWeek:[Progression]](), {$0[$1.progrmasDay,default: []].append($1)})
    }
    init(interactor: ProgramProgressionInteractor = ProgramProgression()) {
        self.interactor = interactor
        #if DEBUG
            self.interactor = ProgramProgressionMock()
        #endif
        self.exerciseModelLogic = ExerciseModelLogic()
        
    }
    func initialize(routine:Routine) async throws {
        await exerciseModelLogic.loadExercises()
        try await self.progresion = getCurrentProgression(routineId: routine.id)
    }
    func getCurrentProgression(routineId:Int)async throws->[Progression]{
        let progressionsResponse =  try await interactor.getProgressions(routineId: routineId)
        return try progressionsResponse.map({try prrogressionFrom(progressionResponse: $0)})
    }
    private func prrogressionFrom(progressionResponse:ProgressionResponse)throws ->Progression{
        guard let exs = exerciseModelLogic.getExerciseById(id:progressionResponse.exercise) else{
            throw ProgressionError.invalidExerciseId
        }
        return Progression(id: progressionResponse.id, reps: progressionResponse.reps, series: progressionResponse.series, weight: progressionResponse.weight, exercise: exs, progrmasDay: progressionResponse.progrmasDay)
    }
    
}
