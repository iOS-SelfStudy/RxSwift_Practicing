//
//  SearchTableViewCell.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/11/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

  @IBOutlet weak var githubImageView: UIImageView!
  @IBOutlet weak var languageLbl: UILabel!
  @IBOutlet weak var forksCountLbl: UILabel!
  @IBOutlet weak var repoDescLbl: UILabel!
  @IBOutlet weak var repoNameLbl: UILabel!
  
  @IBOutlet weak var backView: UIView!
  private var repoUrl:String?
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    backView.layer.cornerRadius = 15
    }

  func ConfigerCell(repo:Repo) {
  
    repoNameLbl.text = repo.name
    repoDescLbl.text = repo.description
    forksCountLbl.text = String(repo.numberOfDownloads)
    languageLbl.text = repo.language
    repoUrl = repo.url
  }
  
}
