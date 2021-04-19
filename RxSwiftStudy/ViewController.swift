//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by Gokhan Alp on 17.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private typealias ItemsType = (String, () -> Void)
    private let items = BehaviorRelay<[ItemsType]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.items.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "cell")) {row,item,cell in
            cell.textLabel?.text = item.0
        }.disposed(by: self.disposeBag)
        
        self.tableView.rx.modelSelected(ItemsType.self).subscribe { selectedItem in
            print("Selected item: \(selectedItem.element?.0 ?? "")")
            selectedItem.element?.1()
        }.disposed(by: self.disposeBag)

        
        self.items.accept( [
            ("Accept & Bind Observable", { [weak self] in
                self?.goTo(identifier: "AnotherVCBindSampleViewController", type: AnotherVCBindSampleViewController.self)
            }),
            ("MVVM & Search Sample & Filter & Debounce", { [weak self] in
                self?.goTo(identifier: "MVVMSampleAndSearchViewController", type: MVVMSampleAndSearchViewController.self)
            }),
            ("Zip & CombineLatest & WithLatestForm", { [weak self] in
                self?.goTo(identifier: "ZipSampleViewController", type: ZipSampleViewController.self)
            }),
            ("Observable & Single & Completable & Maybe", { [weak self] in
                self?.goTo(identifier: "AllObservableViewController", type: AllObservableViewController.self)
            }),
            ("FlatMap & Reduce", { [weak self] in
                self?.goTo(identifier: "MapAndReduceViewController", type: MapAndReduceViewController.self)
            }),
        ])
        
        // Subscribe Observe
        // Map
        // Observable Single Copletable Maybe
        
        if self.items.value.count > 0 {
            print("Items is greather than 0 and first object is: \(self.items.value.first?.0 ?? "")")
        }
        
        self.view.rx.observe(CGRect.self, "frame").subscribe(onNext: { frame in
            if let f = frame {
                print("New frame: \(f)")
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func goTo<T: BaseViewController> (identifier: String, type: T.Type) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? T {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


}

