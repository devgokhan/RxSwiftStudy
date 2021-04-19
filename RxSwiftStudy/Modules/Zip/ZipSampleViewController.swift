//
//  ZipSampleViewController.swift
//  RxSwiftStudy
//
//  Created by Gokhan Alp on 19.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ZipSampleViewController: BaseViewController {

    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var data1Label: UILabel!
    @IBOutlet weak var data2Label: UILabel!
    @IBOutlet weak var data3Label: UILabel!
    
    private let ob1 = Observable<String>.of("1A", "1B").delay(.milliseconds(300), scheduler: MainScheduler())
    private let ob2 = Observable<String>.of("2A", "2B", "2C").delay(.milliseconds(100), scheduler: MainScheduler())
    private let ob3 = Observable<String>.of("3A", "3B", "3C", "3D").delay(.milliseconds(200), scheduler: MainScheduler())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func restart() {
        self.loadingLabel.text = "Loading..."
        self.data1Label.text = "Data 1:"
        self.data2Label.text = "Data 2:"
        self.data3Label.text = "Data 3:"
    }

    @IBAction func loadZipTapped(_ sender: Any) {
        self.restart()
        Observable.zip(
            ob1, ob2, ob3,
            resultSelector: { v1, v2, v3 in
                self.data1Label.text?.append(" \(v1)")
                self.data2Label.text?.append(" \(v2)")
                self.data3Label.text?.append(" \(v3)")
                self.loadingLabel.text = "Load Completed!"
            }
        ).subscribe(onCompleted: {
            self.loadingLabel.text = "Loaded!"
        }).disposed(by: self.disposeBag)
    }
    
    @IBAction func loadCombineLatest(_ sender: Any) {
        self.restart()
        Observable.combineLatest(
            ob1, ob2, ob3,
            resultSelector: { v1, v2, v3 in
                self.data1Label.text?.append(" \(v1)")
                self.data2Label.text?.append(" \(v2)")
                self.data3Label.text?.append(" \(v3)")
                self.loadingLabel.text = "Load Completed!"
            }
        ).subscribe(onCompleted: {
            self.loadingLabel.text = "Loaded!"
        }).disposed(by: self.disposeBag)
    }
    
    @IBAction func loadWithLatestFrom(_ sender: Any) {
        self.restart()
        ob1.withLatestFrom(ob2, resultSelector: { (v1, v2) in
            self.data1Label.text?.append(" \(v1)")
            self.data2Label.text?.append(" \(v2)")
        }).subscribe(
        onCompleted: {
            self.loadingLabel.text = "Loaded!"
        }).disposed(by: self.disposeBag)
    }
    
}
