//
//  FilialsAPI.swift
//  MapBank
//
//  Created by Александр Молчан on 12.01.23.
//

import Foundation
import Moya

enum AtmApi {
    case getFilialInfo
}

extension AtmApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://belarusbank.by/api/atm")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        switch self {
            case .getFilialInfo: return .get
        }
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .getFilialInfo:
                return URLEncoding.queryString
        }
    }
    
}

