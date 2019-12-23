//
//  Alert.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

enum AlertType: Equatable {
    case requestError
}

struct Alert: Equatable {
    let title: String
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .requestError:
            self = Alert(title: "Alert", message: "RequestError")
        }
    }
}
