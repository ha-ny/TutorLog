//
//  Observable.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/20.
//

import Foundation

class Observable<T> {
    
    var listner: ((T) -> Void)?
    
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(value: @escaping (T) -> Void) {
        listner = value
    }
}


