//
//  BindAcceptObservableSampleViewController.swift
//  RxSwiftStudy
//
//  Created by Gokhan Alp on 17.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

class BindAcceptObservableSampleViewController: BaseViewController {

    @IBOutlet weak var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedVariables.shared.sharedBasicCount.asObservable().bind { [weak self ](newValue) in
            self?.valueLabel.text = "\(newValue)"
        }.disposed(by: self.disposeBag)
    }
    
    @IBAction func addMoreTapped(_ sender: Any) {
        let newValue = SharedVariables.shared.sharedBasicCount.value + 1
        SharedVariables.shared.sharedBasicCount.accept(newValue)
    }
}
