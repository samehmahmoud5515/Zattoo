//
//  PlayerView.swift
//  Zattoo
//
//  Created by SAMEH on 10/01/2022.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    var playerLayer: AVPlayerLayer {
        return self.layer as? AVPlayerLayer ?? AVPlayerLayer()
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
