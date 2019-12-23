//
//  LinearGradientView.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 25/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class GradientView: UIView {
    // Layer from UIView, considered as class LinearGradientLayer
    lazy var gradientLayer = layer as? LinearGradientLayer
    
    // In order to use Layer, we have to specifize its class
    override class var layerClass: AnyClass {
        return LinearGradientLayer.self
    }
    
    // Update gradient with its direction (enum) and [UIColor]
    func updateGradient(with direction: LinearGradientLayer.Direction, colors: UIColor...) {
        gradientLayer?.direction = direction
        gradientLayer?.colors = colors.map { $0.cgColor}
        gradientLayer?.setNeedsDisplay()
    }
}
