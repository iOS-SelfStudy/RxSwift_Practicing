//
//  Maps.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/9/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RxSwift
class Maps {
    
    static func doMaps() {
        let disposeBag = DisposeBag()
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        Observable<NSNumber>.of(26,12,1995)
            .map {
                formatter.string(from: $0)
        }.subscribe(onNext: {
            print($0 ?? "")
        }).disposed(by: disposeBag)
        
        
        // here power of rx that every result can passed as parameter in next call
    }
}
