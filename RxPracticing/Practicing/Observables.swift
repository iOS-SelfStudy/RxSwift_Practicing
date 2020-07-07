//
//  Observables.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/6/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RxSwift


class Observables {
    
    
    static func doObservable() {
        let disposBag = DisposeBag()
        // create observable
        let numbers = Observable.just(5)
        
        _ = numbers.subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposBag)
        
        let helloSequence = Observable.from(["h","i","m"])
        _ = helloSequence.subscribe { (event) in
            switch event {
            case .next(let val):
                print(val)
            case .error(let error):
                print(error) 
            case .completed :
                print("finished")
            }
        }.disposed(by: disposBag)
        
    }
}

