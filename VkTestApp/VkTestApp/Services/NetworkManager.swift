//
//  Network Manager.swift
//  VkTestApp
//
//  Created by Khachatryan Arsen on 26.03.2024.
//

import Foundation
import Alamofire

//MARK: - Ответственен за ошибки
enum NetworkError: Error {
    case invalidURL, decodingError, noData
}

final class NetworkManager {
    //MARK: - Синглтон
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Извлечение из сети курса валют
    func fetchServices(completion: @escaping (Result<[Service], NetworkError>) -> Void){
        
        URLSession.shared.dataTask(with: Link.services.url) { data, response, error in
            
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                
                let services = try decoder.decode(Services.self, from: data)
                
                DispatchQueue.main.async {
                    
                    completion(.success(services.body.services))
                    
                }
                
            }
            catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
}
    


//MARK: - Link

extension NetworkManager {
    
    enum Link {
        
        case services
        
        var url:URL {
            switch self {
            case.services:
                return URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json")!
            }
        }
        
    }
    
}
