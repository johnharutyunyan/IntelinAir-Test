//
//  HTTPTask.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

enum HTTPTask {
    case requestPlain
    case requestParameters(Parameters)
}
