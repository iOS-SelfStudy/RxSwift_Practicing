//
//  TrendingRepoCell.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/11/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingRepoCell: UITableViewCell {

  @IBOutlet weak var repoImageView: UIImageView!
  @IBOutlet weak var repoNameLbl: UILabel!
  @IBOutlet weak var repoDescLbl: UILabel!
  
  @IBOutlet weak var numberOfForksLbl: UILabel!
  
  @IBOutlet weak var conributorLbl: UILabel!
  @IBOutlet weak var languageLbl: UILabel!
  @IBOutlet weak var backView: UIView!

  @IBOutlet weak var viewReadMeBtn: RoundButton!
  
  private var repoUrl :String?
  let disposeBage = DisposeBag()
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
  func ConfigerCell(repo:Repo) {
    
    
    repoImageView.image = repo.image
    repoNameLbl.text = repo.name
    repoDescLbl.text = repo.description
    numberOfForksLbl.text = String(repo.numberOfDownloads)
    conributorLbl.text = String(repo.numberOfContributors)
    languageLbl.text = repo.language
    repoUrl = repo.url
    
    viewReadMeBtn.rx.tap.subscribe(onNext:{
      self.window?.rootViewController?.presentSafariWebViewFor(url: self.repoUrl!)
      }).addDisposableTo(disposeBage)
    
  }
  
  override func layoutSubviews() {
    backView.layer.cornerRadius = 15
    backView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    backView.layer.shadowOpacity = 0.25
    backView.layer.shadowRadius = 5.0
    backView.layer.shadowOffset = CGSize(width: 0, height: 0)
  }
  
}
