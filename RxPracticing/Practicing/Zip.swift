//
//  Zip.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/10/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RxSwift

class Zip {
  
  // zip is a transformation function that add two or more observables together
  static func doZip(){
    let names1 = Observable.of("Ahmed","Mohamed","Yara")
    let names2 = Observable.of("Mona" , "Hana","Mahmoud")
    Observable.zip(names1 , names2) {
      $0 + " with " + $1
    }.subscribe(onNext:{
      print("\($0) :  in subscribe 1")
    }).dispose()
    
  }
  
}
