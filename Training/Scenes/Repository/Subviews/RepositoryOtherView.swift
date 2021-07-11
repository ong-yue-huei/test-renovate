//
//  RepositoryOtherView.swift
//  Training
//
//  Created by Ong Yue Huei on 09/07/2021.
//

import UIKit

@IBDesignable
final class RepositoryOtherView: UIView {

    @IBOutlet var icon: UIImageView!
    @IBOutlet var iconName: UILabel!
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         setup()
     }

     required init?(coder: NSCoder) {
         super.init(coder: coder)
         setup()
     }
    
    private func setup() {
        guard let view = R.nib.repositoryOtherView.instantiate(withOwner: self).first as? UIView else {
            fatalError("Fail to load OtherView from Nib.")
        }
        view.frame = bounds
        view.layer.borderColor = R.color.controlHilight()!.cgColor
        view.layer.borderWidth = 0.5
        addSubview(view)
    }
}


