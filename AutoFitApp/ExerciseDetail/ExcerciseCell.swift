//
//  ExcerciseCell.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 24/05/24.
//

import SwiftUI

struct ExcerciseCell: View {
    @State var exerciseProgression:Progression
    var body: some View {
        HStack(alignment: .center,spacing: 70){
            NavigationLink(destination:ExerciseDetail(prog: $exerciseProgression)){
                Text(exerciseProgression.exercise.name).fontWeight(.semibold)
            }
        }.padding()
        
    }
}

#Preview(traits: .fixedLayout(width: 300, height: 60)) {
    ExcerciseCell(exerciseProgression: Progression(id: 0, reps: 12, series: 17, weight: 120, exercise: Exercise(id: 0, name: "Press Banca", image: "", type: 0, stimulus: []), progrmasDay: .monday))
}
