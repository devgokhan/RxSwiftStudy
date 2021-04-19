//
//  MVVMSampleAndSearchViewModel.swift
//  RxSwiftStudy
//
//  Created by Gokhan Alp on 18.04.2021.
//

import Foundation

class MVVMSampleAndSearchViewModel {
    private var viewController: MVVMSampleAndSearchViewController?
    
    init(viewController: MVVMSampleAndSearchViewController) {
        self.viewController = viewController
    }
    
    func dataLoad() {
        let newItems: [MVVMSampleAndSearchUIModel] = [
            MVVMSampleAndSearchUIModel(boolValue: true, stringValue: "test-willNotShown", intValue: 1),
            MVVMSampleAndSearchUIModel(boolValue: true, stringValue: "test2", intValue: 100),
            MVVMSampleAndSearchUIModel(boolValue: false, stringValue: "test3", intValue: 101),
            MVVMSampleAndSearchUIModel(boolValue: true, stringValue: "abc1", intValue: 120),
            MVVMSampleAndSearchUIModel(boolValue: false, stringValue: "abc2", intValue: 121),
        ]
        self.viewController?.items.accept(newItems)
    }
}
