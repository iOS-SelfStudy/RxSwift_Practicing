//
//  NamerViewController.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/10/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NamerViewController: UIViewController {
  @IBOutlet weak var helloLabel: UILabel!
  @IBOutlet weak var nameEntryTextField: UITextField!
  @IBOutlet weak var submitBtn: UIButton!
  @IBOutlet weak var namesLbl: UILabel!
  @IBOutlet weak var addNameFromANotherVCBtn: UIButton!
  
  var namesArray:Variable<[String]> = Variable([])
//  let namesArray  :BehaviorRelay<[String]> = BehaviorRelay(value: [])
  
  let disposeBage = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bindTextToLabel(sender: nameEntryTextField, receiver: helloLabel)
    bindSubmitButton()
    setubNamesObservaion()
    setupAddNameFromVcBtnBinding()
  }
  func bindTextToLabel(sender : UITextField , receiver:UILabel){
    sender.rx.text
      .map{
        $0 != "" ? "hello \($0 ?? "") "  : "Type your name"
    }.debounce(.microseconds(500), scheduler: MainScheduler.instance)
      .bind(to: receiver.rx.text)
      .disposed(by: disposeBage)
  }
  func bindSubmitButton(){
    
    _ = submitBtn.rx.tap.subscribe(onNext:{
      if self.nameEntryTextField.text != "" {
        self.namesArray.value.append(self.nameEntryTextField.text!)
        //self.namesLbl.rx.text.onNext(self.namesArray.value.joined(separator: " - "))
        self.nameEntryTextField.rx.text.onNext("")
        self.helloLabel.rx.text.onNext("Type your name")
      }
      }).disposed(by: disposeBage)
  }
  func setubNamesObservaion() {
    namesArray.asObservable().subscribe(onNext:{
      self.namesLbl.text = $0.joined(separator: " - ")
      }).addDisposableTo(disposeBage)
  }
  
  func setupAddNameFromVcBtnBinding(){
   _ = addNameFromANotherVCBtn.rx.tap.throttle(.microseconds(500), scheduler: MainScheduler.instance)
      .subscribe(onNext:{
        guard let AddNameVc = self.storyboard?.instantiateViewController(identifier: "\(AddNameViewController.self)") as? AddNameViewController else {return}
      _ =  AddNameVc.nameSubject.subscribe(onNext:{
          self.namesArray.value.append($0)
        AddNameVc.dismiss(animated: true, completion: nil)
      }).addDisposableTo(self.disposeBage)
        self.present(AddNameVc, animated: true, completion: nil)
      })
  }
  
}
