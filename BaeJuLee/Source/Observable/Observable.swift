//
//  Observable.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import Foundation

class Observable<T> {
    
    private var closure: ((T) -> Void)?  // 현재 value 값을 받아와서 실행
    
    var value: T {
        didSet {
            closure?(value) // 값이 바뀔 때마다 closure 실행
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {   // clousure 함수 기능 설정
        closure(value)
        self.closure = closure
    }
    
}

