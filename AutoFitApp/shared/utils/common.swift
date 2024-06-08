//
//  common.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 1/06/24.
//

import Foundation
enum JsonParseError:Error{
    case FileNotFound
    case UnviableApiUrl
    case InvalidUrl
    case DecodeError
    case NotFoundCredential
    enum NetworkError:Error {
        case HttpResponseError(String)
        case StatusCodeError
    }
    
}
extension JsonParseError.NetworkError:LocalizedError{
    public var errorDescription: String?{
        switch self{
        case .HttpResponseError(let error):
            return NSLocalizedString(error, comment: "")
        case .StatusCodeError:
            return "some ocurred"
        }
    }
}
enum LocationSource{
    case API(RequestModel)
    case PATH(String)
}
class Common{
    static func parseJson<T: Decodable>(location:LocationSource,model:T.Type,loginRequired:Bool=false)  async throws-> T{
        let data:Data
        
        switch location {
            case .API(let req):
            var serviceUrl = URLComponents(string: req.getUrl())
            serviceUrl?.queryItems = (req.queryParams ?? [:]).map({URLQueryItem(name: $0, value: $1)})
            guard let componentURL = serviceUrl?.url else { throw JsonParseError.InvalidUrl}
            var request = URLRequest(url: componentURL)
            request.httpMethod = req.httpMethod.rawValue
            request.httpBody = req.httpBody
            if loginRequired{
                guard let token = UserAuthApi().getAuthToken() else{
                    throw JsonParseError.NotFoundCredential
                }
                request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
            }
            
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let (data2,response) = try await URLSession.shared.data(for: request)
            data = data2
            guard let response = response as? HTTPURLResponse else {
                throw JsonParseError.NetworkError.HttpResponseError("Not available protocol")
            }
            if response.statusCode !=  200{
                throw JsonParseError.NetworkError.HttpResponseError(String(data: data, encoding: .utf8) ?? "Internal server error")
            }
            
        case .PATH(let path):
            guard let url = Bundle.main.url(forResource: path, withExtension: "json") else{
                throw JsonParseError.FileNotFound
            }
            data = try Data(contentsOf: url)
        }
        let jsonDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        do{
            let responseModel = try jsonDecoder.decode(T.self, from: data)
            return responseModel
        }catch{
            print("Not could parse json : \(location): \(error)")
            throw JsonParseError.DecodeError
        }
    }
}
