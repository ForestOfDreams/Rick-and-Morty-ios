//
//  HomeViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 04.05.2022.
//

import Foundation
import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    var viewModel : HomeViewModel!
    
    struct Model {
    }
    
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateInfo()
    }
    
    private func setupUI() {
        view.backgroundColor = .BG
        
        view.addSubview(titleView)
        view.addSubview(subTitleView)
        view.addSubview(image)
        
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            subTitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 24),
            subTitleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            subTitleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            image.topAnchor.constraint(equalTo: subTitleView.bottomAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onImageTap))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
    }
    
    private func updateInfo() {
        //        titleView.text = "RICK\nAND\nMORTY"
        subTitleView.text = "CHARACTER\nBOOK"
    }
    
    private let model: Model
    
    private lazy var titleView: UILabel = {
        let ret = UILabel()
        
        ret.font = UIFont(name: "SFUIDisplay-Black", size: 72)
        
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.main,
            NSAttributedString.Key.foregroundColor : UIColor.BG,
            NSAttributedString.Key.strokeWidth : -1.0,
            NSAttributedString.Key.kern: 3
        ]
        as [NSAttributedString.Key : Any]
        
        // Лишние аргументы
        ret.attributedText = NSMutableAttributedString(string: "RICK\nAND\nMORTY", attributes: strokeTextAttributes)
        
        ret.numberOfLines = 0
        return ret
    }()
    
    private lazy var subTitleView: UILabel = {
        let ret = UILabel()
        ret.font = UIFont(name: "SFUIDisplay-Black", size: 32)
        let strokeTextAttributes = [
            NSAttributedString.Key.kern: 3
        ]
        as [NSAttributedString.Key : Any]
        
        // Лишние аргументы
        ret.attributedText = NSMutableAttributedString(string: "р", attributes: strokeTextAttributes)
        ret.numberOfLines = 0
        return ret
    }()
    
    
    private lazy var image: UIImageView = {
        let ret = UIImageView()
        let image = UIImage(named: "Home")
        ret.image = image
        ret.contentMode = .scaleAspectFit
        ret.widthAnchor.constraint(equalTo: ret.heightAnchor, multiplier: image!.size.width / image!.size.height).isActive = true
        return ret
    }()
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    @objc func onImageTap()
    {
        let service = CharacterAPIService()
        service.getAllCharacters().sink(receiveCompletion: {
//            let b = $0 as! ServerError
            print($0)
        }) {
            print($0)
        }.store(in: &cancellableSet)
        viewModel.goToImageView()
    }
    
    public func getTopImageY() -> CGFloat {
        return image.frame.minY
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    )
    -> UIViewControllerAnimatedTransitioning? {
        return Animator(
            type: .present
        )
    }
    
    func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
        return Animator(
            type: .dismiss
        )
    }
}
