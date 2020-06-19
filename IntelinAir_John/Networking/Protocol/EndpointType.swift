//
//  EndpointType.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

typealias Headers = [String: String]

protocol EndpointType {
   
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}
