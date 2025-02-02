//
//  DesignableButton.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

@IBDesignable
open class DesignableButton: UIButton {
    // MARK: - Properties
    @IBInspectable open var borderColor: UIColor = .lightGray {
        didSet { layer.borderColor = borderColor.cgColor }
    }

    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet { layer.borderWidth = borderWidth }
    }

    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet { layer.shadowOffset = shadowOffset }
    }

    @IBInspectable var shadowOpacity: Float = 0 {
        didSet { layer.shadowOpacity = shadowOpacity }
    }

    @IBInspectable var shadowColor: UIColor = .clear {
        didSet { layer.shadowColor = shadowColor.cgColor }
    }

    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet { layer.shadowRadius = shadowRadius }
    }

    @IBInspectable var maskToBounds: Bool = true {
        didSet { layer.masksToBounds = maskToBounds }
    }
}
