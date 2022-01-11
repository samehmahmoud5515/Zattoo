//
//  StreamOverlayView.swift
//  Zattoo
//
//  Created by SAMEH on 11/01/2022.
//

import UIKit

class StreamOverlayView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var resizeButton: UIButton!
    @IBOutlet weak var gradientBackgroundView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var gradientLayer: CALayer?
    
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
        setupUI()
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer?.frame = gradientBackgroundView.bounds
    }
}

extension StreamOverlayView {
    func setupUI() {
        setupGradientBackgroundView()
    }
    
    private func setupGradientBackgroundView() {
        gradientLayer = gradientBackgroundView.gradientBackground(from: .black30, to: .clear, direction: .topToBottom)
    }
}
