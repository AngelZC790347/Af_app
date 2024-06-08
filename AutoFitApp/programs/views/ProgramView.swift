//
//  ProgramView.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import SwiftUI

struct ProgramView: View {
    @State var routine:Routine
    @State var programVM:ProgressionModelLogic = ProgressionModelLogic()
    var body: some View {
        NavigationView {
            List(DayOfWeek.allCases,id: \.self) {day in
                if let progressions = programVM.progresionByDay[day]{
                    Section(day.fullName) {
                        ForEach(progressions) { pr in
                            ExcerciseCell(exerciseProgression: pr)
                        }
                    }
                }
            }.navigationTitle(Text(self.routine.name))
        }
        .onAppear(perform: {
            Task{
                try await programVM.initialize(routine: self.routine)
            }
        })}
}

#Preview {
    ProgramView(routine: Routine(id: 0, name: "dada", created: Date(), user: 0))
}
