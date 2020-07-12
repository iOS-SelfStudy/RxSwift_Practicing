//
//  SearchViewController.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/11/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController  , UITextFieldDelegate{
let disposeBag = DisposeBag()
  @IBOutlet weak var searchField: RoundBoarderTextField!
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()

    BindingElements()
   // tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    setupTableViewDisSelectedRow()

        // Do any additional setup after loading the view.
    }
    

  func BindingElements(){
   let searchResultObservable = searchField.rx.text
    .orEmpty.debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .map {
        $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    .flatMap { (query) -> Observable<[Repo]> in
      if query == "" {
        return Observable<[Repo]>.just([])
      }
      else {
        let url = searchUrl + query + startsDescendingSegment
        var searchRepos = [Repo]()
        
        return URLSession.shared.rx.json(url: URL(string: url)!).map {
          let result = $0 as AnyObject
          let items = result.object(forKey: "items") as? [Dictionary<String , Any>] ?? []
          
          for dictionary in items {
            
            let avatarUrl = dictionary["avatarUrl"] as? String ?? ""
            let contributorsUrl = dictionary["contributorsUrl"] as? String ?? ""
            let name = dictionary["name"] as? String ?? ""
            let description = dictionary["description"] as? String ?? ""
            let language = dictionary["language"] as? String ?? ""
            let forksCount = dictionary["forks_count"] as? Int ?? 0
            let repoUrl = dictionary["html_url"] as? String ?? ""
            let repo = Repo(image: UIImage(named: "gitHubLogo")!, name: name, description: description, language: language, numberOfDownloads: forksCount, numberOfContributors: forksCount, url: repoUrl)
            searchRepos.append(repo)
          }
          return searchRepos
        }
        
        
      }
    }.observeOn(MainScheduler.instance)
    searchResultObservable.bind(to: tableView.rx.items(cellIdentifier: "\(SearchTableViewCell.self)")) {
      (row , repo:Repo , cell:SearchTableViewCell) in
      cell.configureCell(repo: repo)
    }
  }
  
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      view.endEditing(true)
//      guard let cell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell else { return }
//      self.presentSafariWebViewFor(url: cell.repoUrl!)
//    cell.selectionStyle = .none
//    print(cell.repoUrl)
//  }
  
  func setupTableViewDisSelectedRow(){
      Observable
          .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Repo.self))
          .bind { [unowned self] indexPath, model in
              self.tableView.deselectRow(at: indexPath, animated: true)
            self.presentSafariWebViewFor(url: model.url)
            print("Selected " + model.name + " at \(indexPath.row)")
          }
          .disposed(by: disposeBag)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
   
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    return true
  }
}
