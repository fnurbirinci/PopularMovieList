//
//  Observable.swift
//  Popular Movie List
//
//  Created by Fatmanur Birinci on 18.09.2023.
//

import Foundation

final class Observable<T> {
    
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }

    init(value: T? = nil) {
        self.value = value
    }

    private var listener: ((T?) -> Void)?

    func bind( _ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener


    }
}
