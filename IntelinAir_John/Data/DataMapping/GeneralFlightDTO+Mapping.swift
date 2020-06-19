//
//  GeneralFlightDTO+Mapping.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/13/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

struct GeneralFlightDTO: Decodable {
    let flights: [FlightDTO]
    let geometry: String
}

extension GeneralFlightDTO {
    
    func toDomain() -> GeneralFlight {
        return .init(flights: flights.map { $0.toDomain() }, geometry: geometry)
    }
}
