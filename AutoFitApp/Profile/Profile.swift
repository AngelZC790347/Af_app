//
//  Profile.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 24/05/24.
//

import SwiftUI

struct Profile: View {
    @State var ususario:User
    var menuLabels: [String: (String, AnyView)] = [
        "Stadistics": ("trophy.fill", AnyView(RoutineList(routineML: RoutineModelLogic()))),
            "Body information": ("heart", AnyView(RoutineList(routineML: RoutineModelLogic()))),
            "routines": ("dumbbell", AnyView(RoutineList(routineML: RoutineModelLogic()))),
            "Settings": ("gear", AnyView(RoutineList(routineML: RoutineModelLogic())))
        ]
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                Divider()
                HStack{
                    Spacer()
                    Text(ususario.email)
                }.padding()
                List(){
                    ForEach(Array(menuLabels.keys.sorted()),id:\.self) { key in
                        NavigationLink(destination: menuLabels[key]?.1){
                            Label(key, systemImage: menuLabels[key]?.0 ?? "").padding(.vertical,30)
                        }
                    }.listRowSpacing(600).listRowBackground(Color.clear).listRowSeparatorTint(.blue)
                }.padding(.leading,-40)
                Spacer()
            }
            .background(Color.init(red: 212, green: 101/255, blue: 32/255)).navigationTitle(ususario.userName).navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    Profile(ususario: User(id: 0, userName: "AngelZC790347", email: "angel1200z@hotmail.com"))
}
