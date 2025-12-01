//
//  characterMapSheetViewControllerUIExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit

extension characterMapSheetViewController {
    
    func configureSheet() {
        guard let sheet = sheetPresentationController else { return }
        sheet.detents = [.medium()]
        sheet.prefersGrabberVisible = true
    }
    
    func setupUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        [nameLabel,speciesLabel,statusLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
}
