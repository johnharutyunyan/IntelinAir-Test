//
//  FlightService.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/13/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

protocol FlightService: class {
    func retrieveFlights(completion: @escaping (Result<GeneralFlight, Error>) -> Void)
}

final class DefaultFlightService: FlightService {
    
    
    // MARK: - Members
    private let provider: ProviderProtocol
    
    
    // MARK: - Init
    init(provider: ProviderProtocol) {
        self.provider = provider
    }
    
    
    // MARK: - Internal functions
    internal func retrieveFlights(completion: @escaping (Result<GeneralFlight, Error>) -> Void) {
        
        provider.request(type: GeneralFlightDTO.self,
                         endPoint: FieldAPI.retrieveFlightInfo,
                         completion: { response in
                            
                            switch response {
                                
                            case .success(let flight):
                                completion(.success(flight.toDomain()))
                                
                            case .failure(let error):
                                completion(.failure(error))
                            }
        })
    }
}
