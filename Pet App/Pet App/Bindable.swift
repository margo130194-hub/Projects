//
//  Bindable.swift
//  Pet App
//
//  Created by Margarita Matsonko on 23/06/2026.
//

import Foundation

final class Bindable<T> {

    // MARK: - Properties
    var value: T {
        didSet {
            notifyObservers()
        }
    }

    private var observers: [(T) -> Void] = []

    // MARK: - Init

    init(_ value: T) {
        self.value = value
    }

    // MARK: - Public

    func bind(_ observer: @escaping (T) -> Void) {
        observers.append(observer)
        observer(value)
    }

    // MARK: - Private

    private func notifyObservers() {
        observers.forEach { $0(value) }
    }
}
