//
//  TrendingFeedsViewController.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/11/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingFeedsViewController: UIViewController  {

  let refreshControl = UIRefreshControl()
  
 // fileprivate let Repos: BehaviorRelay<[Repo]> = BehaviorRelay(value: [
        
//    Repo(image: UIImage(named: "searchIconLarge")!, name: "Swift", description: "this is a langauage", language: "Swift", numberOfDownloads: 55, numberOfContributors: 44, url: ""),
//         Repo(image: UIImage(named: "searchIconLarge")!, name: "Swift", description: "this is a langauage", language: "Swift", numberOfDownloads: 55, numberOfContributors: 44, url: "")
//     ])
     var dataSource = PublishSubject<[Repo]>()
     let disposeBag = DisposeBag()
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()
    setupTableViewDataBinding()
    fetchData()
    
    
setupRefreshControll()
      
    }
  
  func setupRefreshControll() {
    tableView.refreshControl = refreshControl
    refreshControl.tintColor = #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1)
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching Treinding Github repos 💻🔥", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1) , NSAttributedString.Key.font:UIFont(name: "AvenirNext-DemiBold", size: 16.0)!])
    refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
  }
  
  
  @objc func refreshData(_ sender: Any) {
      DownloadService.instance.downloadTrendingRepos { (trendingReposArray) in
          self.dataSource.onNext(trendingReposArray)
          self.refreshControl.endRefreshing()
      }
  }

   
  func setupTableViewDataBinding(){
    
    dataSource.bind(to: tableView.rx.items(cellIdentifier: "\(TrendingRepoCell.self)")) { (row, repoModel, cell: TrendingRepoCell) in
      cell.ConfigerCell(repo: repoModel)
    }.disposed(by: disposeBag)
    
  }
  
  
  
  func fetchData() {
    DownloadService.instance.downloadTrendingRepos { (trendingReposArray) in
      print("\(trendingReposArray.count)   fetchData")
      self.dataSource.onNext(trendingReposArray)
    }
  }
  
  
  
  
  
  
  //    tableView.delegate = self
  //    tableView.dataSource = self
          // Do any additional setup after loading the view.
  
  
  //  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  //    5
  //  }
  //
  //  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  //    let cell = tableView.dequeueReusableCell(withIdentifier: "\(TrendingRepoCell.self)", for: indexPath )as? TrendingRepoCell
  //    let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: "Swift", description: "dasasd", numberOfForks: 56, language: "aasd", numberOfContributors: "sdfs", repoURL: "asda")
  //    cell?.ConfigerCell(repo: repo)
  //
  //    return cell!
  //  }
  
}

