//
//  ProviderProtocol.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

protocol ProviderProtocol {
    func request<T>(type: T.Type, endPoint: EndpointType, completion: @escaping ((NetworkResponse<T>) -> Void)) where T: Decodable
}
