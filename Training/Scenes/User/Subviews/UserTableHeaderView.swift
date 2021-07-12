//
//  UserTableHeaderView.swift
//  Training
//
//  Created by Ong Yue Huei on 12/07/2021.
//
//
import UIKit
import Nuke

final class UserTableHeaderView: UIView {

    @IBOutlet private var userImage: UIImageView! {
        didSet {
            userImage.layer.cornerRadius = userImage.frame.size.width * 0.5
        }
    }
    @IBOutlet private var displayName: UILabel!
    @IBOutlet private var loginName: UILabel!
    @IBOutlet private var followersCount: UILabel!
    @IBOutlet private var followingCount: UILabel!
    @IBOutlet private var personIcon: UIImageView! {
        didSet {
            personIcon.image = personIcon.image?.withHorizontallyFlippedOrientation()
        }
    }
    
    func setUser(_ user: User) {
        Nuke.loadImage(with: user.avatarUrl, into: userImage)
        displayName.text = user.name ?? user.login
        loginName.text = user.login
        followersCount.text = String(user.followers)
        followingCount.text = String(user.following)
    }
}
