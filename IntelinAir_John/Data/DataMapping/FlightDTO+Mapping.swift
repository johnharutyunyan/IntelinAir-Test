//
//  FlightDTO.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/13/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

struct FlightDTO: Decodable {
    
    let id: Int
    let tilesets: [TilesetDTO]
    let code: String
}

extension FlightDTO {
    
    func toDomain() -> Flight {
        .init(id: id, tilesets: tilesets.map { $0.toDomain() }, code: code)
    }
}
