//
//  FlightMapViewModel.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/18/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

protocol FlightMapViewModel: class {
    var tileSetPath: String? { get }
    var geometry: String? { get }
    var coordinates: [[Double]]? { get }
}

final class DefaultFlightMapViewModel: FlightMapViewModel {
    
    var tileSetPath: String?
    var geometry: String?
    var coordinates: [[Double]]?
    
    
    // MARK: - Init
    init(with geometry: String?, path: String?) {
        self.tileSetPath = path
        self.geometry = geometry
        
        if let date = geometry?.data(using: .utf8) {
            let json = try? JSONDecoder().decode(FeatureCollectionDTO.self, from: date)
            
            if let coordinates = json?.features.first?.geometry.coordinates.first {
                let allCoordinates = (coordinates.first) ?? [] + (coordinates.last ?? [])
                self.coordinates = allCoordinates
            }
        }
    }
}
