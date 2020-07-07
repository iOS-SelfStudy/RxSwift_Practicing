//
//  PublishSubject.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/7/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RxSwift

class PublishSubjects {
    // subjects is special type of observables
   static func doPublishSubject(){
        
        
        // you need to give it explicit type "String"
        let publishSubject = PublishSubject<String>()
        publishSubject.onNext("Hello")
        
        //Note you must subscribe to publishSubject to get on next .. all on next before subscription will not call
        
        let publishSubscrtiption = publishSubject.subscribe(onNext: {
            print($0)
        })
        //so far there is no value will print in publishSubscrtiption
        publishSubject.onNext("first")
        // now publishSubscrtiption will print first
        let publishSubscrtiption2 = publishSubject.subscribe(onNext: {
            print($0)
        })
        // no value will print till now in publishSubscrtiption2
        publishSubject.onNext("second")
        /* now output will be
         first
         second
         second
         
         and the other second because publishSubscrtiption will also call when publishSubject.onNext("second")
         */
    }
}
