//
//  HTTPEngine.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//


import Foundation

typealias HTTPCompletionHander = (Data?, HTTPURLResponse?, Error?) -> Void

protocol HTTPEngineType {
    func send(request: URLRequest, cancelledBy: RequestCancellationToken, completion: @escaping HTTPCompletionHander)
}

enum URLSessionErrorEngine : Error {
    case invalidURLResponseType
}

class HTTPEngine: HTTPEngineType {
    
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }

    func send(request: URLRequest, cancelledBy token: RequestCancellationToken, completion: @escaping HTTPCompletionHander) {
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if urlResponse != nil, let httpUrlResponse = urlResponse as? HTTPURLResponse {
                completion(data,httpUrlResponse ,nil)
            } else {
                completion(data, nil, URLSessionErrorEngine.invalidURLResponseType)
            }
        }
        task.resume()
        token.willDealocate = { task.cancel() }
    }
    
    deinit {
        session.invalidateAndCancel()
    }
}
