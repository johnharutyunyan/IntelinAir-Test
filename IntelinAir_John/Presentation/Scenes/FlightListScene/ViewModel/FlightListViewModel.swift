//
//  FlightListViewModel.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

protocol FlightListViewModel: class {
    var sections: Observable<[FlightSectionViewModel]> { get }
    var flightMapViewModel: FlightMapViewModel? { get }
    func retrieveFlights()
    func selectItem(at indexPath: IndexPath)
    
    var selectedPathAction: (() -> Void)? { get set }
}

final class DefaultFlightListViewModel: FlightListViewModel {
    
    // MARK: - Members
    var sections: Observable<[FlightSectionViewModel]> = Observable([])
    
    var flightMapViewModel: FlightMapViewModel? {
        DefaultFlightMapViewModel(with: geometry, path: selectedPath)
    }
    
    var selectedPathAction: (() -> Void)?
    
    
    private var geometry: String?
    private var selectedPath: String?
    private let service: FlightService
    
    
    // MARK: - Init
    init(with service: FlightService) {
        self.service = service
    }
    
    
    // MARK: - Internal functions
    internal func retrieveFlights() {
        
        service.retrieveFlights { result in
            
            switch result {
                
            case .success(let generalFlight):
                var sections = [FlightSectionViewModel]()
                
                if let flights = generalFlight.flights {
                    sections = flights.map { flight -> FlightSectionViewModel in
                        let section = DefaultFlightSectionViewModel(flight: flight)
                        return section
                    }
                }
                
                self.geometry = generalFlight.geometry
                self.sections.value = sections
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    internal func selectItem(at indexPath: IndexPath) {
        selectedPath = sections.value[indexPath.section].rows[indexPath.row].path
        selectedPathAction?()
    }
}
