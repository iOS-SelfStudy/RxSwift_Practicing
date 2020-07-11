//
//  AddNameViewController.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/11/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddNameViewController: UIViewController {
  @IBOutlet weak var newNameTextField: UITextField!
  @IBOutlet weak var submitBtn: UIButton!
  let disposeBag = DisposeBag()
  
  let nameSubject = PublishSubject<String>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindSubmitBtn()			
    // Do any additional setup after loading the view.
  }
  
  func bindSubmitBtn(){
    submitBtn.rx.tap.subscribe(onNext:{
      if self.newNameTextField.text != "" {
        self.nameSubject.onNext(self.newNameTextField.text!)
      }
      
    }).addDisposableTo(disposeBag)
  }
  
}
