//
//  RepositoryCountView.swift
//  Training
//
//  Created by Ong Yue Huei on 09/07/2021.
//

import UIKit

@IBDesignable
final class RepositoryCountView: UIView {

    enum Count: String {
        case stargazers = "Stargazers"
        case watchers = "Watchers"
        case forks = "Forks"

        var iconImage: UIImage {
            switch self {
            case .stargazers: return R.image.star()!
            case .watchers: return R.image.watch()!
            case .forks: return R.image.fork()!
            }
        }
    }
    
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var countLabel: UILabel!
    @IBOutlet private var iconNameLabel: UILabel!
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         setup()
     }

     required init?(coder: NSCoder) {
         super.init(coder: coder)
         setup()
     }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    private func setup() {
        guard let view = R.nib.repositoryCountView.instantiate(withOwner: self).first as? UIView else {
            fatalError("Fail to load CountView from Nib.")
        }
        view.frame = bounds
        view.layer.borderColor = R.color.controlHilight()!.cgColor
        view.layer.borderWidth = 0.5
        addSubview(view)
    }
    
    func setInfo(type this: Count, count: Int) {
        iconImageView.image = this.iconImage
        iconNameLabel.text = this.rawValue
        self.countLabel.text = String(count)
    }
}
