//
//  FeatureDTO+Mapping.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/18/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

struct FeatureDTO : Decodable {
    let geometry : GeometryDTO
}

extension FeatureDTO {
    
    func toDomain() -> Feature {
        .init(geometry: geometry.toDomain())
    }
}
