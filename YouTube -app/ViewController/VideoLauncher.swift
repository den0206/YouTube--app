//
//  VideoLauncher.swift
//  YouTube -app
//
//  Created by 酒井ゆうき on 2020/04/18.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import AVFoundation

class VideoLauncher {
    
    func showVideoPlayer() {
        
        if let keyWindow = UIWindow.key {
    
            let view = UIView(frame: keyWindow.frame)
            
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            keyWindow.addSubview(view)
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height))
            view.addSubview(videoPlayerView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
            }) { (completed) in
                
                /// dismiss status bar
        
            }
            
        }
       
    }
    
    func hideVideoPlayer() {
        if let keyWindow = UIWindow.key {
            
            keyWindow.removeFromSuperview()
        }
    }
}

class VideoPlayerView : UIView {
    
    //MARK: - parts
    
    let controllContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        
        return view
    }()
    
    let activityIndocator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.style = .large
        
        indicator.startAnimating()
        return indicator
    }()

    
    lazy var pausePlayButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.setDimension(width: 50, height: 50)
        
        button.addTarget(self, action: #selector(handPause), for: .touchUpInside)
        
        return button
    }()
    
    let videoLengthLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel : UILabel = {
         let label = UILabel()
         label.text = "00:00"
         label.textColor = .white
         label.font = UIFont.boldSystemFont(ofSize: 13)
         label.textAlignment = .right
         return label
     }()
    
    lazy var videoSlider : UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(#imageLiteral(resourceName: "hospital"), for: .normal)
        
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        
        return slider
    }()
    
    let cancelButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cancel").withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.setDimension(width: 30, height: 30)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    
    var player : AVPlayer?
    
    var isPlaying = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        setupContainerView()

    }
    
    
    private func setupPlayerView() {
    
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        guard let url = URL(string: urlString) else {return}
        player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        
        player?.play()
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        let interval = CMTime(value: 1, timescale: 2)
        
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
            let minutesString = String(format: "%02d", Int(seconds / 60))
            
            print(seconds)
            self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
            
            if let duration = self.player?.currentItem?.duration {
                let durationSecounds = CMTimeGetSeconds(duration)
                self.videoSlider.value = Float(seconds / durationSecounds)
            }
            
        })
        
        
        //
    }
    
    /// observer
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndocator.stopAnimating()
            controllContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            
            isPlaying = true
//            pausePlayButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
//            pausePlayButton.tintColor = .clear
   
            /// set videoLength (right) Label
            guard let duration = player?.currentItem?.duration else {return}
            let secounds = CMTimeGetSeconds(duration)
            
            let secoundText = Int(secounds)
            let minuteText = String(format: "%02d", Int(secounds) / 60)
            videoLengthLabel.text = "\(minuteText):\(secoundText)"
        }
    }
    
    private func setupContainerView() {
        controllContainerView.frame = frame
        addSubview(controllContainerView)
        
        controllContainerView.addSubview(cancelButton)
        cancelButton.anchor(top : controllContainerView.topAnchor, left: controllContainerView.leftAnchor,paddongTop: 16, paddingLeft: 16)
        
        controllContainerView.addSubview(activityIndocator)
        activityIndocator.center(inView: controllContainerView)
        
        controllContainerView.addSubview(pausePlayButton)
        pausePlayButton.center(inView: controllContainerView)
        
        controllContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.anchor(bottom : bottomAnchor, right:  rightAnchor,paddiongBottom: 8, paddingRight: 8)
        videoLengthLabel.setDimension(width: 60, height: 24)
        
        controllContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.centerY(inView: videoLengthLabel)
        currentTimeLabel.anchor(left : leftAnchor, bottom: bottomAnchor,paddingLeft: 8)
        
        controllContainerView.addSubview(videoSlider)
        videoSlider.centerY(inView: currentTimeLabel)
        videoSlider.anchor(left : currentTimeLabel.rightAnchor, right: videoLengthLabel.leftAnchor, paddingLeft: 8, paddingRight: -8, height: 30)
        
        backgroundColor = .black
        
        
    }
    
    //MARK: - Actions
    
    @objc func handPause() {
        
        if isPlaying {
            
            player?.pause()
            pausePlayButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            
     
        } else {
            player?.play()
            pausePlayButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        
        
        /// clear button
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.pausePlayButton.tintColor = .clear
        }
        
        
        pausePlayButton.tintColor = .white
        
        isPlaying = !isPlaying
    }
    
    @objc func handleSlider() {
        
        guard let duration = player?.currentItem?.duration else {return}
        let total = CMTimeGetSeconds(duration)
        
        let value = Float64(videoSlider.value) * total
        
        let seekTime = CMTime(value: Int64(value), timescale: 1)
        player?.seek(to: seekTime, completionHandler: { (complete) in
            
            return
        })
        
    }
    
    @objc func handleDismiss() {
        let videoLauncher = VideoLauncher()
        videoLauncher.hideVideoPlayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


