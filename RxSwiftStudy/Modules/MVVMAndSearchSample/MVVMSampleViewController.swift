//
//  MVVMSampleAndSearchViewController.swift
//  RxSwiftStudy
//
//  Created by Gokhan Alp on 18.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

class MVVMSampleAndSearchViewController: BaseViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var boolSwitch: UISwitch!
    
    private var viewModel: MVVMSampleAndSearchViewModel?
    let items = BehaviorRelay<[MVVMSampleAndSearchUIModel]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MVVMSampleAndSearchViewModel(viewController: self)
        
        self.searchTextField.rx.controlEvent(.editingChanged).asObservable().debounce(.seconds(1), scheduler: MainScheduler()).subscribe({ event in
            print("Search Changed: \(self.searchTextField.text ?? "")")
            self.items.accept(self.items.value)
        }) .disposed(by: self.disposeBag)
        
        self.boolSwitch.rx.controlEvent(.valueChanged).asObservable().subscribe({ event in
            print("Switch value changed isOn: \(self.boolSwitch.isOn)")
            self.items.accept(self.items.value)
        }).disposed(by: self.disposeBag)
        
        self.items.asObservable()
            .map { $0.filter({ $0.boolValue == self.boolSwitch.isOn && $0.intValue >= 100 &&
                                (self.searchTextField.text?.count ?? 0 < 1 ||
                                (self.searchTextField.text?.count ?? 0 > 0 && $0.stringValue.lowercased().contains(self.searchTextField.text!.lowercased())) )
                })
            }
            .bind(to: self.tableView.rx.items(cellIdentifier: "cell")) { row,item,cell in
                cell.textLabel?.text = "\(item.stringValue)"
        }.disposed(by: self.disposeBag)
        
        self.viewModel?.dataLoad()
    }

}
