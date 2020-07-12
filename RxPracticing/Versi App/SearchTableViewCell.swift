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
  public private(set) var repoUrl:String?
  func configureCell(repo: Repo) {
    print(repo.language)
         repoUrl = repo.url
    
    githubImageView.image = repo.image
         repoNameLbl.text = repo.name
         repoDescLbl.text = repo.description
         forksCountLbl.text = String(describing: repo.numberOfDownloads)
         languageLbl.text = repo.language
    print(repo.language)
     }
     
     override func layoutSubviews() {
         backView.layer.cornerRadius = 15
         backView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         backView.layer.shadowOpacity = 0.25
         backView.layer.shadowRadius = 3.0
         backView.layer.shadowOffset = CGSize(width: 0, height: 0)
     }
  
}
