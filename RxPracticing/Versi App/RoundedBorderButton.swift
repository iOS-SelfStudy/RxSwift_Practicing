//
//  RoundedBorderButton.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/11/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  func setup(){
    backgroundColor = .clear
    layer.cornerRadius = frame.height / 2
    layer.borderWidth = 3
    layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  }
  
}
