//
//  StoryboardExtension.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import UIKit

public enum StoryboardName: String {
    case main = "Main"
    case flight = "Flight"
    case flightMap = "FlightMap"
}

extension UIStoryboard {
    
    static func loadViewController<T>(with storyboardName: StoryboardName) -> T where T: UIViewController {
        
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else { return T() }
        
        return viewController
    }
}
