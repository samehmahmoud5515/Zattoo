//
//  GroupCell.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import UIKit
import RxSwift

class GroupCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    
    override var isSelected: Bool {
        didSet {
            selectionView.isHidden = !isSelected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionView.gradientBackground(from: .groupLineGradientColor1, to: .groupLineGradientColor2, direction: .leftToRight)
    }
}

extension GroupCell: GroupCellProtocol {
    func updateUI(with group: GroupUIModel, isSelected: Bool) {
        titleLabel.text = group.name
        selectionView.isHidden = !isSelected
    }
}
