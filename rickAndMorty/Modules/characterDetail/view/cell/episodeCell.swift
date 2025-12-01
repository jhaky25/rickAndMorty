//
//  episodeCell.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit

final class episodeCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let seenSwitch = UISwitch()

    var onSeenToggle: ((Bool) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        seenSwitch.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(titleLabel)
        contentView.addSubview(seenSwitch)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            seenSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            seenSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: seenSwitch.leadingAnchor,constant: -12)
        ])

        seenSwitch.addTarget(self,action: #selector(switchChanged),for: .valueChanged)
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with episode: episodeModel, seen: Bool) {
        titleLabel.text = "\(episode.episode) - \(episode.name)"
        seenSwitch.isOn = seen
    }

    @objc private func switchChanged() {
        onSeenToggle?(seenSwitch.isOn)
    }
}
