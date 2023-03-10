//
//  FilialProvider.swift
//  MapBank
//
//  Created by Александр Молчан on 12.01.23.
//

import Foundation
import Moya

typealias ArrayResponce<T: Decodable> = (([T]) -> Void)
typealias Error = ((String) -> Void)

final class FilialProvider {
    private let provider = MoyaProvider<AtmApi>(plugins: [NetworkLoggerPlugin()])
    
    func getAtmInfo(success: @escaping ArrayResponce<AtmInfo>, failure: @escaping Error) {
        provider.request(.getFilialInfo) { result in
            switch result {
                case .success(let response):
                    guard let atmInfo = try? JSONDecoder().decode([AtmInfo].self, from: response.data) else { return }
                    success(atmInfo)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
}
