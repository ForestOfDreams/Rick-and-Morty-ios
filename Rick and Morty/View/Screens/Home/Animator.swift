//
//  Animator.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 24.05.2022.
//

import Foundation
import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    static let duration: TimeInterval = 1
    private let type: PresentationType
    private let homeViewController: HomeViewController
    private let homeImageViewController: HomeImageViewController
    
    init?(
        type: PresentationType,
        homeViewController: HomeViewController,
        homeImageViewController: HomeImageViewController
    ) {
        self.type = type
        self.homeViewController = homeViewController
        self.homeImageViewController = homeImageViewController
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
        
        if type.isPresenting {
            let containerView = transitionContext.containerView
            containerView.addSubview(homeImageViewController.view)
            homeImageViewController.view.frame.origin.y += homeViewController.image.frame.minY
            homeImageViewController.closeButton.alpha = 0
        }

        UIView.animate(
            withDuration: Self.duration,
            // weak self?
            animations: {
                if self.type.isPresenting {
                    self.homeImageViewController.view.frame.origin.y -= self.homeViewController.image.frame.minY
                    self.homeImageViewController.closeButton.alpha = 1
                } else {
                    self.homeImageViewController.scrollView.zoomScale = 1
                    self.homeImageViewController.view.frame.origin.y += self.homeViewController.image.frame.minY
                    self.homeImageViewController.closeButton.alpha = 0
                }
            },
            completion: {
                if !self.type.isPresenting {
                    self.homeImageViewController.view.removeFromSuperview()
                    self.homeImageViewController.view.frame.origin.y -= self.homeViewController.image.frame.minY
                    self.homeImageViewController.closeButton.alpha = 1
                }
                transitionContext.completeTransition($0)
            }
        )
    }
}

enum PresentationType {
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}
