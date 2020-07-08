//
//  Variables.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/8/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RxSwift

class Variables {
    // Variable can hold one value at time
    static func doVariables(){
        // vaiables like behavior subjects needs initial value
        var variable = Variable<String>("Hello")
        
    // variable not treated as observable so
       /* variable.onNext("Value B") will not work  */
        
        
        // so we make
        variable.asObservable().subscribe(onNext: {
            print("First Subscriber: value is \($0)")
        })
        
        // otherwise we treat it as ordinary var
        variable.value = "value1"
        variable.value = "value2"
        variable.value = "value3"
        variable.value = "value4"
        
        variable.asObservable().subscribe(onNext: {
            print("Second Subscriber: value is \($0)")
            //here will be like behavior subjectr wil get the recent value only "value 4"
        })
    }
}
