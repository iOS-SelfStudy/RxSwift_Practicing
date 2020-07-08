//
//  FlatMaps.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/9/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RxSwift
class FlatMaps {
    
    struct Game {
        var price : Variable<Double>
    }
    static func doFlatMaps() {
        let disposeBag = DisposeBag()
        let game1 = Game(price: Variable(15.5))
        let game2 = Game(price: Variable(25.3))
        
        let gameSubject = PublishSubject<Game>()
        
        gameSubject
            .flatMap {
                $0.price.asObservable()
        }
        .subscribe(onNext:{
            print($0)
            }).addDisposableTo(disposeBag)
        
        gameSubject.onNext(game1)
        gameSubject.onNext(game2)
        
        game2.price.value = 155.33
        
    }
    
    
    
}
