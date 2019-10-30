//
//  ExecutableDownloadRequest.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 30/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class ExecutableDownloadRequest {

    private let responsePromise: Promise<URL>

    init(promise: Promise<URL>) {
        self.responsePromise = promise
    }

    func processDownloadResponse(callback: @escaping (HTTPResponse<URL>) -> Void) {
        responsePromise.observe { result in
            switch result {
            case .value(let url, let statusCode):
                callback(HTTPResponse(result: .success(url), originalData: nil, statusCode: statusCode))
            case .error(let error, _, let statusCode):
                callback(HTTPResponse(result: .failure(error), originalData: nil, statusCode: statusCode))
            }
        }
    }
}
