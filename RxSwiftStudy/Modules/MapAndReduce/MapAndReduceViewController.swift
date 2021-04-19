//
//  MapAndReduceViewController.swift
//  RxSwiftStudy
//
//  Created by Gokhan Alp on 19.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

class MapAndReduceViewController: BaseViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.outputLabel.text = ""
        
        Single.just(1).flatMap( { element in
            return element == 1 ? Single.just("one") : Single.just("other")
        }).subscribe(onSuccess: { result in
            self.log("Single FlatMap Sample onSuccess: \(result)")
        }, onFailure: { error in
            self.log("Single FlatMap Sample onFailure: \(error)")
        }, onDisposed: {
            self.log("Single FlatMap Sample onDisposed")
        }).disposed(by: self.disposeBag)
        
        Observable<String>.create({ observer in
            observer.onNext("Koç")
            observer.onNext("Sistem")
            observer.onNext("-RxSwift")
            observer.onCompleted()
            return Disposables.create()
        }).reduce("", accumulator: { (va1, va2) in
            let newText = "\(va1)\(va2)"
            return newText
        }).subscribe(onNext: { result in
            self.log("Single Reduce Sample onSuccess: \(result)")
        }, onError: { error in
            self.log("Single Reduce Sample onFailure: \(error)")
        }, onCompleted: {
            self.log("Single Reduce Sample onCompleted")
        }, onDisposed: {
            self.log("Single Reduce Sample onDisposed")
        }).disposed(by: self.disposeBag)

    }
    
    private func log(_ val: String) {
        print(val)
        self.outputLabel.text?.append("\(val)\n")
    }

}
