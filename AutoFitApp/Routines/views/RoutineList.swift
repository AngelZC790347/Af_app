//
//  Profile.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 23/05/24.
//

import SwiftUI

struct RoutineList: View {
    @State var routineML:RoutineModelLogic
    var body: some View {
        NavigationStack{
            VStack {
                if routineML.getAllRoutine().isEmpty{
                    Text("There are not routines aviable please create one in your page ").padding(.horizontal,70)
                }else{
                    Text("This is your aviable routines")
                    Text("Please Choos One of This")
                    Spacer(minLength: 60)
                    List(routineML.getAllRoutine()) { routine in
                        NavigationLink {
                            ProgramView(routine: routine)
                        } label: {
                            Text(routine.name)
                        }
                    }.listStyle(.inset).background(.red)
                }
                
            }.padding(.vertical,200)
        }.onAppear(perform: {
            Task{
                await routineML.loadData()
            }
        })
    }
}

#Preview {
    RoutineList(routineML: RoutineModelLogic())
}
