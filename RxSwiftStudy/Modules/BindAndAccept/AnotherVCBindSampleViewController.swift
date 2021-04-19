//
//  AnotherVCBindSampleViewController.swift
//  RxSwiftStudy
//
//  Created by Gokhan Alp on 17.04.2021.
//

import UIKit

class AnotherVCBindSampleViewController: BaseViewController {

    @IBOutlet weak var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedVariables.shared.sharedBasicCount.asObservable().bind { [weak self ](newValue) in
            self?.valueLabel.text = "\(newValue)"
        }.disposed(by: self.disposeBag)
    }

    @IBAction func goToAddMorePageTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "BindAcceptObservableSampleViewController") as? BindAcceptObservableSampleViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
