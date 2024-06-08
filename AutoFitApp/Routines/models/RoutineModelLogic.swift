//
//  RoutineModelLogic.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import Foundation

@Observable
class RoutineModelLogic{
    private var routines = [Routine]()
    private var routineInteractor:RoutineInteractor
    init(routineInteractor: RoutineInteractor = RoutineAFitApi()) {
        self.routineInteractor = routineInteractor
        #if DEBUG
        self.routineInteractor = RoutineAFitMock()
        #endif
    }
    func getAllRoutine() -> [Routine]{
        return routines
    }
    func loadData()async{
        do{
            let data =  try await self.routineInteractor.getRoutine()
            await MainActor.run {
                self.routines = data
            }
        }catch{
            print("Error \(error)")
        }
    }
}
