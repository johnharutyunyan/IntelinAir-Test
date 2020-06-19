//
//  Observable.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/13/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

public final class Observable<Value> {
    
    struct Observer<Value> {
        weak var observer: AnyObject?
        let closure: (Value) -> Void
    }
    
    private var observers = [Observer<Value>]()
    
    public var value: Value {
        didSet { notifyObservers() }
    }
    
    
    // MARK: - Init
    public init(_ value: Value) {
        self.value = value
    }
    
    
    // MARK: - Public functions
    public func subscribe(on observer: AnyObject, closure: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, closure: closure))
        DispatchQueue.main.async { closure(self.value) }
    }
    
    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    
    // MARK: - Private functions
    private func notifyObservers() {
        for observer in observers {
           DispatchQueue.main.async { observer.closure(self.value) }
        }
    }
}
