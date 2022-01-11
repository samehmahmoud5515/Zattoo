//
//  ChannelCell.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import UIKit

class ChannelCell: UICollectionViewCell {
    @IBOutlet weak var channelLogoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropShadow(color: .darkGray)
    }
}

extension ChannelCell: ChannelCellProtocol {
    func updateUI(with title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
