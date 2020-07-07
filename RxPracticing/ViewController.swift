//
//  ViewController.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/6/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        Observables.doObservable()
//        PublishSubjects.doPublishSubject()
        //BehaviorSubjects.doBehaviorSubjects()
        
        ReplaySubjects.doReplaySubjects()
    }


}

