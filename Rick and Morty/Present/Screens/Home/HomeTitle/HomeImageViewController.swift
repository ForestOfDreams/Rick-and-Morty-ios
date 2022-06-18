//
//  HomeImageViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 24.05.2022.
//

import Foundation
import UIKit

final class HomeImageViewController: UIViewController {
    
    var viewModel : HomeImageViewModel!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .BG
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        scrollView.pin(to: view)
        
        scrollView.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: image.widthAnchor),
            image.topAnchor.constraint(equalTo: scrollView.topAnchor),
            image.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 63),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        closeButton.addTarget(self, action: #selector(onCloseBtnTap), for: .touchUpInside)
        
    }
    
    private lazy var scrollView: UIScrollView = {
        let ret = UIScrollView()
        ret.contentInsetAdjustmentBehavior = .never
        ret.bounces = false
        ret.maximumZoomScale = 4
        ret.minimumZoomScale = 1
        ret.showsHorizontalScrollIndicator = false
        ret.showsVerticalScrollIndicator = false
        ret.addSubview(image)
        ret.addSubview(closeButton)
        
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
    
    
    private lazy var closeButton: UIButton = {
        let ret = FavoriteButton()
        let normalImage = UIImage(systemName: "multiply")
        ret.setImage(normalImage, for: .normal)
        ret.backgroundColor = .BG
        ret.tintColor = .main
        ret.widthAnchor.constraint(equalToConstant: 48).isActive = true
        ret.heightAnchor.constraint(equalToConstant: 48).isActive = true
        ret.layer.cornerRadius = 24
        ret.alpha = 0.8
        return ret
    }()
    
    public func makeCloseBtnTransperent() {
        closeButton.alpha = 0
    }
    
    public func removeCloseBtnTransperent() {
        closeButton.alpha = 1
    }
    
    public func makeDefaultZoomScale() {
        scrollView.zoomScale = 1
    }
    
    @objc func onCloseBtnTap() {
        viewModel.goToTitleView()
    }
}

extension HomeImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        image
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: offsetX, bottom: 0, right: 0)
    }
}
