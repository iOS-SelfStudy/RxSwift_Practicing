//
//  Date + today.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/12/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
extension Date {
    func today() -> String {
        let date = Calendar.current.date(byAdding: .day, value: 0, to: self)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
}
