//
//  AutoFitAppApp.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 23/05/24.
//

import SwiftUI
import UIKit
enum AppState {
    case loading
    case unauthenticated
    case active
}


@Observable
class UserAgent{
    var state :AppState
    var authInteractor:UserAuthInteractor
    var errorMsg = ""
    init(authInteractor: UserAuthInteractor = UserAuthApi()) {
        self.authInteractor = authInteractor
        #if DEBUG
            self.authInteractor = UserAuthenthicatorMock()
            authInteractor.logout()
        #endif
        self.state = (authInteractor.isAuthrnticated() ? .active : .unauthenticated)
    }
    func login(email:String,password:String) -> Void {
        self.state = .loading
        self.authInteractor.login(emial: email, password: password) { res in
            switch res{
            case .success(()):
                self.state = .active
                break
            case .failure(let error ):
                if let error = error as? JsonParseError.NetworkError{
                    self.errorMsg = error.localizedDescription
                }else{
                    self.errorMsg = "\(error)"
                }
                self.state = .unauthenticated
                
            }
        }
    }
    func logOut(){
        print("log out")
        self.authInteractor.logout()
        self.state = .unauthenticated
    }
}

@main
struct AutoFitAppApp: App {
    @State private var user = UserAgent()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                switch user.state {
                case .loading:
                    Text("...")
                case .unauthenticated:
                    SigIn(userAgent: user)
                case .active:
                    if let routine = UserDefaults.standard.object(forKey: "routines") as? Routine{
                        ProgramView(routine: routine)
                    }
                    RoutineList(routineML: RoutineModelLogic()).environment(user)
                        .navigationBarItems(leading: Button("Log out", action: {
                            self.user.logOut()
                        }))                  
                }
            }
            
            
        }
    }
}
