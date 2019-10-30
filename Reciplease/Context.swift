//
//  Context.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 29/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class Context {

    // MARK: - Public properties

    let networkClient: HTTPClient

    let imageProvider: ImageProvider

    // MARK: - Initializer

    init(networkClient: HTTPClient, imageProvider: ImageProvider) {
        self.networkClient = networkClient
        self.imageProvider = imageProvider
    }
}


