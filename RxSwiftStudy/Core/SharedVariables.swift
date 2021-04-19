//
//  SharedVariables.swift
//  RxSwiftStudy
//
//  Created by Gokhan Alp on 17.04.2021.
//

import RxSwift
import RxCocoa

class SharedVariables {
    static let shared = SharedVariables()
    
    let sharedBasicCount = BehaviorRelay<Int>(value: 0)
}
