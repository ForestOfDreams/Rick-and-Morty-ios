//
//  CharacterViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 19.04.2022.
//

import Foundation
import Kingfisher
import UIKit
import Combine

final class CharacterViewController: UIViewController {
    
    var viewModel : CharacterViewModel!
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
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
        
        viewModel.character.sink { [weak self] _ in
            self?.updateInfo()
        }
        .store(in: &subscriptions)
    }
    
    private func setupUI() {
        view.backgroundColor = .BG
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(icon)
        scrollView.addSubview(titleView)
        scrollView.addSubview(stack)
        scrollView.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            icon.topAnchor.constraint(equalTo: scrollView.topAnchor),
            icon.widthAnchor.constraint(equalToConstant: 300),
            icon.heightAnchor.constraint(equalToConstant: 300),
            icon.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            titleView.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 35),
            titleView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            stack.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .main
    }
    
    private func updateInfo() {
        icon.kf.setImage(with: URL(string: viewModel.character.value.image)!)
        titleView.update(
            with: CharacterTitleView.Model(
                name: viewModel.character.value.name,
                isFavorite: viewModel.character.value.isFavorite
            )
        )
        
        statusCell.update(
            with: InfoCell.Model(
                key: "Status",
                value: viewModel.character.value.status.rawValue
            )
        )
        speciesCell.update(
            with: InfoCell.Model(
                key: "Species",
                value: viewModel.character.value.species
            )
        )
        genderCell.update(
            with: InfoCell.Model(
                key: "Gender",
                value: viewModel.character.value.gender.rawValue
            )
        )
    }
    
    private lazy var icon: UIImageView = {
        let ret = BaseImage(frame: .zero)
        return ret
    }()
    
    private lazy var stack: UIStackView = {
        let ret = UIStackView()
        ret.alignment = .fill
        ret.distribution = .fill
        ret.contentMode = .left
        ret.axis = .vertical
        ret.spacing = 16
        ret.addArrangedSubview(statusCell)
        ret.addArrangedSubview(speciesCell)
        ret.addArrangedSubview(genderCell)
        return ret
    }()
    
    private lazy var titleView = CharacterTitleView(onLikeButtonTap: viewModel.onLikeButtonTap)
    private lazy var statusCell = InfoCell()
    private lazy var speciesCell = InfoCell()
    private lazy var genderCell = InfoCell()
    
    private lazy var scrollView: UIScrollView = {
        let ret = UIScrollView()
        ret.alwaysBounceVertical = true
        return ret
    }()
}
