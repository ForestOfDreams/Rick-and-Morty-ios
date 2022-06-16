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
    //    private let homeViewController: HomeViewController
    //    private let homeImageViewController: HomeImageViewController
    
    init?(
        type: PresentationType
        //        homeViewController: HomeViewController,
        //        homeImageViewController: HomeImageViewController
    ) {
        self.type = type
        //        self.homeViewController = homeViewController
        //        self.homeImageViewController = homeImageViewController
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        
        if type.isPresenting {
            guard let homeImageViewController = toVC as? HomeImageViewController,
                  let homeViewController = fromVC.children[0] as? HomeViewController
            else {
                return
            }
            
            let containerView = transitionContext.containerView
            containerView.addSubview(homeImageViewController.view)
            homeImageViewController.view.frame.origin.y += homeViewController.getTopImageY()
            homeImageViewController.makeCloseBtnTransperent()
            
            UIView.animate(
                withDuration: Self.duration,
                animations: {
                    homeImageViewController.view.frame.origin.y -= homeViewController.getTopImageY()
                    homeImageViewController.removeCloseBtnTransperent()
                },
                completion: {
                    transitionContext.completeTransition($0)
                }
            )
        } else {
            guard let homeImageViewController = fromVC as? HomeImageViewController,
                  let homeViewController = toVC.children[0] as? HomeViewController
            else {
                return
            }
            
            UIView.animate(
                withDuration: Self.duration,
                animations: {
                    homeImageViewController.makeDefaultZoomScale()
                    homeImageViewController.view.frame.origin.y += homeViewController.getTopImageY()
                    homeImageViewController.makeCloseBtnTransperent()
                    toVC.view.layer.mask = nil
                    
                },
                completion: {
                    homeImageViewController.view.removeFromSuperview()
                    homeImageViewController.view.frame.origin.y -= homeViewController.getTopImageY()
                    homeImageViewController.removeCloseBtnTransperent()
                    transitionContext.completeTransition($0)
                }
            )
        }
    }
}

enum PresentationType {
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}
