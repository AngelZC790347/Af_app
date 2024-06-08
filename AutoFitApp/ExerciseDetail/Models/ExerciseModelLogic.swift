//
//  ExerciseModelLogic.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import Foundation
@Observable
class ExerciseModelLogic{
    private var interactor:ExerciseInteractor
    var exercises = [Exercise]()
    init(interactor: ExerciseInteractor = ExerciseInteractorApi()) {
        self.interactor = interactor
        #if DEBUG
        self.interactor = ExerciseInteractorMock()
        #endif
    }
    func loadExercises()async{
        do{
            let exercisesData =  try await interactor.getExercises()
            await MainActor.run {
                self.exercises = exercisesData
            }
        }catch{
            print("Error \(error)")
        }
    }
    func getExerciseById(id:Int)  ->Exercise?{
        return  exercises.first(where: {$0.id == id})
    }
}
