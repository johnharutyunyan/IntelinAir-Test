//
//  FeatureCollectionDTO+Mapping.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/18/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

struct FeatureCollectionDTO: Decodable {
    let type: String
    let features: [FeatureDTO]
}

extension FeatureCollectionDTO {
    
    func toDomain() -> FeatureCollection {
        .init(type: type, features: features.map { $0.toDomain()} )
    }
}
