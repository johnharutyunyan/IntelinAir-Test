//
//  URLSessionProvider.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

final class URLSessionProvider: ProviderProtocol {
    
    private let errorDomain = "com.domain.error"
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(type: T.Type, endPoint: EndpointType, completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable {
        let request = URLRequest(endPoint: endPoint)
        
        #if DEBUG
        NetworkLogger.log(request: request)
        #endif
        
        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }
    
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<T>) -> Void) {
      
        guard error == nil else { return
            completion(.failure(error!))
        }
        
        do {
            
            let result = try JSONDecoder().decode(T.self, from: data!)
            completion(.success(result))
            
        } catch let error {
            print(error.localizedDescription)
            completion(.failure(error))
        }
    }
}
