//
//  UIViewController + Safari.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/12/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import SafariServices

extension UIViewController {
    func presentSafariWebViewFor(url: String) {
        let repoUrl = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: repoUrl!)
        present(safariVC, animated: true, completion: nil)
    }
}
