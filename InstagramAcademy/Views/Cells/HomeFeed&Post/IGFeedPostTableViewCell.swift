//
//  IGFeedPostTableViewCell.swift
//  InstagramAcademy
//
//  Created by HieuTong on 5/2/21.
//

import AVFoundation
import SDWebImage
import UIKit

final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerPlayer = AVPlayerLayer()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerPlayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "test")
        
        return
        //configure the cell
        switch post.postType {
        case .photo:
            //show image
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            // load and play video
            player = AVPlayer(url: post.postURL)
            playerPlayer.player = player
            playerPlayer.player?.volume = 0
            playerPlayer.player?.play()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerPlayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
}
