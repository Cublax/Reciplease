//
//  ImageRepository.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 18/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol  ImageRepositoryType {
    func downloadImage(for url: String, callback: @escaping (Data?) -> Void)
}
final class ImageRepository: ImageRepositoryType {

      // MARK: - Properties
    
      private let client: HTTPClient
      
      private let token = RequestCancellationToken()
      
      // MARK: - Initializer

      init() {
          self.client = HTTPClient(cancellationToken: token)
      }
      
      // MARK: - Requests
      
    func downloadImage(for url: String, callback: @escaping (Data?) -> Void) {
        
        guard let urlForRequest = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: urlForRequest) else {return}

          client.request(type: Data.self, requestType: .GET, url: url) { response in
            callback(response)
        }
        }
      
}
