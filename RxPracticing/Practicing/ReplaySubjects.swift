//
//  ReplaySubjects.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/8/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RxSwift
class ReplaySubjects {
    
    let dispose = DisposeBag()
    static func doReplaySubjects(){
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
        replaySubject.onNext("First")
        
        _ = replaySubject.subscribe(onNext: {
            print("Subscribe 1 : line =  \(#line) and value = \($0)")
            }).dispose()
        
        replaySubject.onNext("Second") //emits next event to subscription
        replaySubject.onNext("Third")
        replaySubject.onNext("Fourth")
        replaySubject.onNext("Fifth")
        
        _ = replaySubject.subscribe(onNext: {
            print("Subscribe 2 : line =  \(#line) and value = \($0)")
            // it just replays the last 2 emits in memory
            }).dispose()
        
    }
    
    // we can use it for example to get the last three people you may know to show from a list
    //
}
