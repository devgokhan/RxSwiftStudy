//
//  AllObservableViewController.swift
//  RxSwiftStudy
//
//  Created by Gokhan Alp on 19.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

class AllObservableViewController: BaseViewController {

    @IBOutlet weak var isValidSwitch: UISwitch!
    @IBOutlet weak var logLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func workTapped(_ sender: Any) {
        self.logLabel.text = ""
        
        Observable.of("val1", "val2").subscribe(onNext: { val in
            self.log("Observable - onNext \(val)")
        }, onError: { error in
            self.log("Observable - onError \(error)")
        }, onCompleted: {
            self.log("Observable - onCompleted")
        }, onDisposed: {
            self.log("Observable - onDisposed")
        }).disposed(by: self.disposeBag)
        
        
        Single.just("onlyVal").subscribe(onSuccess: { val in
            self.log("Single - onSuccess \(val)")
        }, onFailure: { error in
            self.log("Single - onFailure \(error)")
        }, onDisposed: {
            self.log("Single - onDisposed")
        }).disposed(by: self.disposeBag)
        
        
        Completable.create(subscribe: { observer in
            if self.isValidSwitch.isOn {
                self.log("Completable .completed")
                observer(.completed)
            } else {
                self.log("Completable .error")
                observer(.error(NSError(domain: "wups", code: 0, userInfo: [:])))
            }
            return Disposables.create()
        }).subscribe(onCompleted: {
            self.log("Completable - onCompleted")
        }, onError: { error in
            self.log("Completable - onError \(error)")
        }, onDisposed: {
            self.log("Completable - onDisposed")
        }).disposed(by: self.disposeBag)

        
        Maybe.just("onlyVal").subscribe(onSuccess: { val in
            self.log("Maybe - onSuccess \(val)")
        }, onError: { error in
            self.log("Maybe - onError \(error)")
        }, onCompleted: {
            self.log("Maybe - onCompleted")
        }, onDisposed: {
            self.log("Maybe - onDisposed")
        }).disposed(by: self.disposeBag)
    }
    
    private func log(_ val: String) {
        print(val)
        self.logLabel.text?.append("\(val)\n")
    }
    
}
