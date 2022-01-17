//
//  StreamSettingsCell.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import UIKit

class StreamSettingsCell: UITableViewCell {
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
}

extension StreamSettingsCell {
    func configure(with setting: PlayerSettingsUIModel, title: String, icon: UIImage?) {
        titleLbl.text = title
        iconImgView.image = icon
        contentView.alpha = setting.enabled ? 1.0 : 0.5
        
        switch setting {
        case let .quality(quality, _, _):
            
            var resolutionText = .auto == quality ? "Auto" : quality.name
            let lastIndex = resolutionText.count

            if quality.heightResolution >= VideoQuality.hd.heightResolution {
                resolutionText.append("HD")
                valueLbl.setAttributedTextWithSubscripts(
                    text: resolutionText,
                    indicesOfSubscripts: [lastIndex, lastIndex + 1],
                    color: .white)
            }
            else {
                valueLbl.text = resolutionText
            }
        case let .audio(name, _):
            valueLbl.text = name.value
        case let .subtitle(name, _):
            valueLbl.text = name.value
        }
    }
}
