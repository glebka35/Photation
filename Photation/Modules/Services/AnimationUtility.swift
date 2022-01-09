//
//  AnimationUtility.swift
//  Photation
//
//  Created by Gleb Uvarkin on 31.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class AnimationUtility: UIViewController, CAAnimationDelegate {

    static let kSlideAnimationDuration: CFTimeInterval = 0.4

    static func viewSlideInFromRight(toLeft views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition?.type = .push
        transition?.subtype = .fromRight
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromLeft(toRight views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition?.type = .push
        transition?.subtype = .fromLeft
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromTop(toBottom views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition?.type = .push
        transition?.subtype = .fromBottom
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromBottom(toTop views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition?.type = .push
        transition?.subtype = .fromTop
        views.layer.add(transition!, forKey: nil)
    }
}
