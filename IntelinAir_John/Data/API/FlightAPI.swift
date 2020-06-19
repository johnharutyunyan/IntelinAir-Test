//
//  FlightAPI.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/13/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

enum FieldAPI {
    case retrieveFlightInfo
}

extension FieldAPI: EndpointType {
    
    var baseURL: URL {
        URL(string: "https://next.json-generator.com/api/")!
    }
    
    var path: String {
        "json/get/EJwhsvEo_"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        .requestPlain
    }
    
    var headers: Headers? {
        nil
    }
    
    var parametersEncoding: ParametersEncoding {
        .url
    }
}
