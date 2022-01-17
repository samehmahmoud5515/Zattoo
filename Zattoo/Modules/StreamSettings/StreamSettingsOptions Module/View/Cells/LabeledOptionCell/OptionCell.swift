//
//  OptionCell.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    
    
}

// MARK: - HELPER METHODS
extension OptionCell {
    func updateUI(with title: String?, _ isSelected: Bool) {
        titleLabel.text = title
        checkMarkImageView.isHidden = !isSelected
    }
}

extension OptionCell {
    func configure(_ item: PlayerSettingsUIModel)  {
        
        switch item {
        case let .quality(quality, resoulution, _):
            if quality == .auto {
                updateUI(with: "Auto", item.enabled)
            } else {
                updateUI(with: "\(quality.name)(\(resoulution))", item.enabled)
            }
        case let .audio(option, _):
            updateUI(with: option.value, item.enabled)
        case let .subtitle(option, _):
            updateUI(with: option.value, item.enabled)
        }
    }
}
