//
//  FlightSectionViewModel.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/13/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

protocol FlightSectionViewModel: class {
    var title: String { get }
    var rows: [FlightRowViewModel] { get }
}


class DefaultFlightSectionViewModel: FlightSectionViewModel {
    
    
    // MARK: - Members
    var rows: [FlightRowViewModel] = []
    var title: String
    
    
    // MARK: - Init
    init(flight: Flight) {
        
        var rows = [FlightRowViewModel]()
        
        if let tilesets = flight.tilesets {
            rows = tilesets.map { tileset -> FlightRowViewModel in
                let row = DefaultFlightRowViewModel(name: tileset.name ?? "", path: tileset.path, imagePath: tileset.exportGeotiffThumbnail)
                return row
            }
        }
        
        if let code = flight.code {
            self.title = "Flight code: " + "\(code)"
        } else {
            self.title = ""
        }
        
        self.rows = rows
    }
}
