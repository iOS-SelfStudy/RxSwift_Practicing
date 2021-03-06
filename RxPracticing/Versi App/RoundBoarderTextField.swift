//
//  RoundBoarderTextField.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/11/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit

class RoundBoarderTextField: UITextField {

  override func awakeFromNib() {
    super.awakeFromNib()
    let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1)])
           attributedPlaceholder = placeholder
    backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    layer.cornerRadius = frame.height/2
    layer.borderColor = #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1)
    layer.borderWidth = 3
  }

}
