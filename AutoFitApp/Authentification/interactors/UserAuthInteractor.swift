//
//  UserAuthInteractor.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 2/06/24.
//

import Foundation
import Security

protocol UserAuthInteractor{
    var serviceAcount:String {get}    
    func login(emial:String,password:String,completion:@escaping(Result<Void,Error>)->Void)->Void
    func logout()->Void
    func isAuthrnticated()->Bool
    func getAuthToken()->String?
}

class UserAuthApi:UserAuthInteractor{
    let serviceAcount: String = "com.AutoFitApp.autenticacion"
    
    func login(emial: String, password: String, completion: @escaping (Result<Void, any Error>) -> Void){
        Task{
            let body = ["email":emial,"password":password]
            let payload = try? JSONSerialization.data(withJSONObject: body, options: [])
            do{
                let response = try await Common.parseJson(location: .API(.init(baseUrL: .api, endpoint: "user/", queryParams: [:],httpMethod: .POST, httpBody: payload)), model:AuthResponse.self)
                KeyChainHekper.shared.save(response.token, service: serviceAcount, account: "authToken")
                completion(.success(()))
            }catch{
                completion(.failure(error))
            }
         }
    }
    func logout() {
        KeyChainHekper.shared.delete(service: serviceAcount, account: "authToken")      
    }
    
    func isAuthrnticated() -> Bool {
        return KeyChainHekper.shared.read(service: serviceAcount, account: "authToken") as Data? != nil
    }
    
    func getAuthToken() -> String? {
        return KeyChainHekper.shared.read(service: serviceAcount, account: "authToken") as String?  
    }        
}

class UserAuthenthicatorMock:UserAuthInteractor{
    let serviceAcount: String = "com.AutoFitApp.autenticacion"
    
    func login(emial: String, password: String, completion: @escaping (Result<Void, any Error>) -> Void){
        Task{
            KeyChainHekper.shared.save("28aead066409846a98ddfe34c69d5ec2420c2a07", service: serviceAcount, account: "authToken")
                completion(.success(()))       
         }
    }
    func logout() {
        KeyChainHekper.shared.delete(service: serviceAcount, account: "authToken")
    }
    
    func isAuthrnticated() -> Bool {
        return KeyChainHekper.shared.read(service: serviceAcount, account: "authToken") as Data? != nil
    }
    
    func getAuthToken() -> String? {
        return KeyChainHekper.shared.read(service: serviceAcount, account: "authToken") as String?
    }
}
