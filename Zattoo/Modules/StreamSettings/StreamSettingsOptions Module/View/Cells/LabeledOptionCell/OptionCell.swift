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
        case .quality(let quality, _, _):
            if quality == .auto {
                updateUI(with: "Auto", item.enabled)
            } else {
                updateUI(with: quality.name, item.enabled)
            }
        case .audio(let option, _):
            updateUI(with: option.value, item.enabled)
        case .subtitle(let option, _):
            updateUI(with: option.value, item.enabled)
        }
    }
}
