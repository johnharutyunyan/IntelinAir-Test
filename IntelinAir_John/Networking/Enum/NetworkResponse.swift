//
//  NetworkResponse.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

enum NetworkResponse<T> {
    case success(T)
    case failure(Error)
}
