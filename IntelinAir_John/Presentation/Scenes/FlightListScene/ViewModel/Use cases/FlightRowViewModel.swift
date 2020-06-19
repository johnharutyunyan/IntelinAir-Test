//
//  FlightRowViewModel.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/13/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

protocol FlightRowViewModel: class {
    var name: String { get }
    var path: String? { get }
    var imagePath: String? { get }
}

class DefaultFlightRowViewModel: FlightRowViewModel {
    
    
    // MARK: - Members
    var name: String
    var path: String?
    var imagePath: String?
    
    
    // MARK: - Init
    init(name: String, path: String?, imagePath: String?) {
        self.name = name
        self.path = path
        self.imagePath = imagePath
    }
}
