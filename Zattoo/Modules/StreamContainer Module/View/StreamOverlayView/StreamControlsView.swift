//
//  StreamControlsView.swift
//  Zattoo
//
//  Created by SAMEH on 11/01/2022.
//

import UIKit

class StreamControlsView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var resizeButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var bitRateLabel: UILabel!
    @IBOutlet weak var currentPlaybackPositionLabel: UILabel!
        
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Methods
    private func commonInit() {
        loadNibFromFile()
    }
}
