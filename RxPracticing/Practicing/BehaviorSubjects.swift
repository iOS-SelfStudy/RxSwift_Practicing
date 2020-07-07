//
//  BehaviorSubjects.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/7/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RxSwift
class BehaviorSubjects {
    
    static func doBehaviorSubjects(){
        /* behavior subjects same like publish but it gives the subscribers
         the recent value and the values emits after that subscribers*/
        
        
        // note : you need to give behaviro subject an initial value of anythin
        let behaviorSubjects = BehaviorSubject(value: "Value A")
        
        
        // then you should subscribe
        _ = behaviorSubjects.subscribe(onNext: {
            print("Subscription 1 \($0)")
        })
        // so far will print Subscription 1  Value a
        
        behaviorSubjects.onNext("Value B")
        behaviorSubjects.onNext("Value C")
        
        // till now will print 3 values for a b c
        
        // now i will make another subscription
        _ = behaviorSubjects.subscribe(onNext: {
            print("Subscription 2 \($0)")
        })
        
        
        behaviorSubjects.onNext("both subscriptio get this value")
        //that's because behavior subjects give the recent emit and the values emits after that
    }
}
