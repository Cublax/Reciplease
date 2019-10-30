//
//  ImageProvider.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 18/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

typealias Key = NSString
typealias Object = NSData

final class ImageProvider {

    // MARK: - Private properties

    private let repository: ImageRepositoryType

    private var cache: NSCache<Key, Object>

    fileprivate enum CachedImage {
        case exists(data: NSData)
        case new
    }

    // MARK: - Initializer

    init() {
        self.repository = ImageRepository()
        self.cache = NSCache<Key, Object>()
    }

    // MARK: - Public

    func setImage(for url: String, cancelledBy token: RequestCancellationToken, callback: @escaping (UIImage?) -> Void) {
         let uid = url.hashValue.description
        let cachedImage = CachedImage(with: Key(string: uid), in: cache)
        switch cachedImage {
        case .exists(data: let data):
            callback(UIImage(data: Data(referencing: data)))
        case .new:
            repository.downloadImage(for: url, cancelledBy: token) { (data) in
                guard let data = data else { return }
                self.cache.setObject(Object(data: data), forKey: Key(string: uid))
                callback(UIImage(data: data))
            }
        }
    }
}

extension ImageProvider.CachedImage {
    init(with uid: NSString, in cache: NSCache<Key, Object>) {
        if let data = cache.object(forKey: uid) {
            self = .exists(data: data)
        } else {
            self = .new
        }
    }
}
