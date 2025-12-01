//
//  characterDetailViewControllerUIExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import UIKit

extension characterDetailViewController {
    
    func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        
        avatarImageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        episodesTable.dataSource = self
        episodesTable.delegate = self
        
        episodesTable.register(episodeCell.self, forCellReuseIdentifier: "episodeCell")
        episodesTable.translatesAutoresizingMaskIntoConstraints = false
        tableHeightConstraint = episodesTable.heightAnchor.constraint(equalToConstant: 50)
        tableHeightConstraint?.isActive = true
        
        [avatarImageView, nameLabel, infoLabel, locationLabel, favoriteButton, mapButton, episodesTable].forEach {
            stackView.addArrangedSubview($0)
        }
    }
}
