//
//  RequestCancellationToken.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class RequestCancellationToken {
    
    init () {}
    
    deinit {
        willDealocate?()
    }
    
    var willDealocate:(() -> Void)?
}
