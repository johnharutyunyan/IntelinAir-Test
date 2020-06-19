//
//  URLComponentsExtension.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

extension URLComponents {
    
    init(endPoint: EndpointType) {
        let url = endPoint.baseURL.appendingPathComponent(endPoint.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!
        
        guard case let .requestParameters(parameters) = endPoint.task, endPoint.parametersEncoding == .url else { return }
        
        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
