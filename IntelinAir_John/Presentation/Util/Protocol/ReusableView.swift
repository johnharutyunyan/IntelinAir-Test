//
//  ReusableView.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: class {
    
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
}

