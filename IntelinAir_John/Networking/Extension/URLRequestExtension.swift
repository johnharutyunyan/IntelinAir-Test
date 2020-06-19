//
//  URLRequestExtension.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init(endPoint: EndpointType) {
        let urlComponents = URLComponents(endPoint: endPoint)
        
        self.init(url: urlComponents.url!)
        
        httpMethod = endPoint.method.rawValue
        endPoint.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        
        guard case let .requestParameters(parameters) = endPoint.task, endPoint.parametersEncoding == .json else { return }
        httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }
}
