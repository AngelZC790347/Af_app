//
//  ExerciseDetail.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 24/05/24.
//

import SwiftUI

struct ExerciseDetail: View {
    @Binding var prog:Progression
    var body: some View {
            VStack(alignment: .center){
                Text(prog.exercise.name).font(.title).fontWeight(.heavy)
                AsyncImage(url: URL(string: prog.exercise.image)) { image in
                    image.resizable().frame(width: 200).clipShape(.circle)
                } placeholder: {
                    Text("Loading ...")
                }.frame(height: 200)

                VStack{
                    Text("Last Week Record").font(.title3).foregroundStyle(.primary).padding()
                    VStack(alignment: .leading, content: {
                        Text("Weight:\t\(String(format: "%.1f",prog.weight))").foregroundStyle(.secondary)
                        Text("Reps:\t\t\(prog.reps)").foregroundStyle(.secondary)
                        Text("Series:\t\t\(prog.series)").foregroundStyle(.secondary)
                    })
                }
                VStack(alignment:.center){
                    Text("New Preogresion").font(.title2).foregroundStyle(Color.init(red: 212, green: 101/255, blue: 32/255)).padding().fontWeight(.bold)
                    VStack(alignment: .center){
                        HStack(alignment: .center){
                            Text("Weigth\t\t:\t")
                            TextField("\(prog.weight)", value: $prog.weight, formatter: NumberFormatter())
                            
                        }.frame(width: 200)
                        HStack(alignment: .top){
                            Text("Reps\t\t:\t")
                            TextField("\(prog.reps)", value: $prog.reps, formatter: NumberFormatter())
                            
                        }.frame(width: 200)
                        HStack(alignment: .top){
                            Text("Series\t\t:\t")
                            TextField("\(prog.series)", value: $prog.series, formatter: NumberFormatter())
                        }.frame(width: 200)
                    }.padding(.leading,80)
                }
                
                Button("\t Finish\t\t") {
                    print("savinnng")
                }.padding(10).border(.white).padding(.vertical,40).foregroundColor(Color.init(red: 212, green: 101/255, blue: 32/255))
                
            }
        }
}

#Preview {
    ExerciseDetail(prog: .constant(Progression(id: 0, reps: 12, series: 17, weight: 120, exercise: Exercise(id: 0, name: "Press Banca", image: "https://static.strengthlevel.com/images/exercises/squat/squat-800.jpg", type: 0, stimulus: []), progrmasDay: .monday)))
}
