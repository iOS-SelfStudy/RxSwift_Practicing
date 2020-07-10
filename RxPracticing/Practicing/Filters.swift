//
//  Filters.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/10/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RxSwift

class Filters {
  
  static func doFilters(){
    let disposeBage = DisposeBag()
    Observable.of("mohamed" , "ahmed" , "sara" , "mona","omar" , "ziad")
      .filter {
        $0.starts(with: "a")
    }.subscribe(onNext:{
      print("\($0) start with a")
    }).addDisposableTo(disposeBage)
    
    
    
    // another example
    _  = Observable.just(["mohamed" , "ahmed" , "sara" , "mona","omar" , "ziad"])
      .map {
        return $0.filter {
          print("\($0) filter")
          return $0.contains("m")
        }
    }.subscribe(onNext:{
      print("\($0)  has m")
    }).dispose()
    
    
    
  }
  
}
