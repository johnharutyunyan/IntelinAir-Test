//
//  GeometryDTO.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/18/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

struct GeometryDTO: Decodable {
    let type : String
    let coordinates: [[[[Double]]]]
}

extension GeometryDTO {
    
    func toDomain() -> Geometry {
        .init(type: type, coordinates: coordinates)
    }
}
