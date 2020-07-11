//
//  NetworkLayer.swift
//  RxPracticing
//
//  Created by Mohamed Korany Ali on 7/11/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import Foundation
import RxSwift
import Alamofire
import AlamofireImage

class DownloadService {
  static let instance = DownloadService()
  
  func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray: [Dictionary<String, Any>]) -> ()) {
    var trendingReposDictArray = [Dictionary<String, Any>]()
    
    AF.request(trendingRepoUrl).responseJSON { response in
      switch response.result {
        
      case .success(let value):
        print("success")
        guard let json = value as? Dictionary<String, Any> else { return }
        guard let repoDictionaryArray = json["items"] as? [Dictionary<String, AnyObject>] else {return}
        
        for repoDict in repoDictionaryArray {
         
          if trendingReposDictArray.count < 9 {
             print("trendingReposDictArray for if")
             let name = repoDict["name"] as? String
              let description = repoDict["description"] as? String
              let language = repoDict["language"] as? String
              let forksCount = repoDict["forks_count"] as? Int
              let repoUrl = repoDict["html_url"] as? String
              let contributorsUrl = repoDict["contributors_url"] as? String
              let owner = repoDict["owner"] as? Dictionary<String, AnyObject>
            let avatarUrl = owner?["avatar_url"] as? String
            
            let repoDictionary: Dictionary<String, Any> = ["name": name?.uppercased(), "description": description, "language": language, "forksCount": forksCount, "repoUrl": repoUrl, "avatarUrl": avatarUrl, "contributorsUrl": contributorsUrl]
            
            print("before complition trendingReposDictArray")
            trendingReposDictArray.append(repoDictionary)
            
          } else {
             print("trendingReposDictArray for else")
            
          }
        }
        print(trendingReposDictArray.count)
        completion(trendingReposDictArray)
      case .failure(let error):
        break
      }
      
    }
    
    
  }
  
  
  
  func downloadTrendingRepo(fromDictionary dictionary: Dictionary<String, Any>, completion: @escaping (_ repo: Repo) -> Void) {
    
    let avatarUrl = dictionary["avatarUrl"] as? String ?? ""
    let contributorsUrl = dictionary["contributorsUrl"] as? String ?? ""
    let name = dictionary["name"] as? String ?? ""
    let description = dictionary["description"] as? String ?? ""
    let language = dictionary["language"] as? String ?? ""
    let forksCount = dictionary["forksCount"] as? Int ?? 0
    let repoUrl = dictionary["repoUrl"] as? String ?? ""
    
    downloadImageFor(avatarUrl: avatarUrl) { (imageForRepo) in
      self.downloadContributorsDataFor(contributorsUrl: contributorsUrl, completion: { contributions in
        
        
        
        let repo = Repo(image: imageForRepo, name: name, description: description, language: language, numberOfDownloads: forksCount, numberOfContributors: contributions, url: repoUrl)
        completion(repo)
      })
    }
  }
  
  func downloadImageFor(avatarUrl: String, completion: @escaping (_ image: UIImage) -> ()) {
    AF.request(avatarUrl).responseImage { (imageResponse) in
      
      switch imageResponse.result {
        
      case .success(let value):
        let image = value
        completion(image)
      case .failure(_):
        print("error")
      }
      
    }
    
  }
  
  func downloadContributorsDataFor(contributorsUrl url: String, completion: @escaping (_ contributions: Int) -> Void) {
    AF.request(url).responseJSON { response in
      
      switch response.result {
        
      case .success(let value):
        guard let json = value as? [Dictionary<String, Any>] else { return }
        if !json.isEmpty {
          let contributions = json[0]["contributions"] as! Int
          completion(contributions)
        }
      case .failure(_):
        print("error")
      }
    }
  }
  
  
  
  
  
  func downloadTrendingRepos(completion: @escaping (_ reposArray: [Repo]) -> ()) {
      downloadTrendingReposDictArray { (trendingReposDictArray) in
          var trendingReposArray = [Repo]()
          for dict in trendingReposDictArray {
              self.downloadTrendingRepo(fromDictionary: dict, completion: { (returnedRepo) in
                  if trendingReposArray.count <= 9 {
                      trendingReposArray.append(returnedRepo)
                    if trendingReposArray.count == 9 {
                      completion(trendingReposArray)
                    }
                    print("aaaaa")
                    print(trendingReposArray.count)
                  } else {
                    print("slsl")
                      let sortedRepoArray = trendingReposArray.sorted(by: { (repoA, repoB) -> Bool in
                          if repoA.numberOfDownloads > repoB.numberOfDownloads {
                              return true
                          } else {
                              return false
                          }
                      })
                    print("kakakkakakaaka")
                      
                  }
              })
          }
      }
  }
  
  
}
