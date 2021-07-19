//
//  RepositoryDataView.swift
//  Training
//
//  Created by Ong Yue Huei on 09/07/2021.
//

import UIKit

@IBDesignable
final class RepositoryDataView: UIView {

    enum Data {
        case isPrivate(_ isPrivate: Bool)
        case language(_ language: String?)
        case issue(_ issue: Int)
        case date(_ date: Date)
        
        var info: String {
            switch self {
            case .isPrivate(let isPrivate):
                return isPrivate ? "Private" : "Public"
            case .language(let language):
                return language ?? "-NA-"
            case .issue(let issue):
                let s = (issue > 1) ? "s" : ""
                return "\(String(issue)) issue\(s)"
            case .date(let date):
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                return formatter.string(from: date)
            }
        }
        
        var iconImage: UIImage {
            switch self {
            case .isPrivate: return R.image.private()!
            case .language: return R.image.language()!
            case .issue: return R.image.issue()!
            case .date: return R.image.date()!
            }
        }
    }
    
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var iconInfoLabel: UILabel!
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         setup()
     }

     required init?(coder: NSCoder) {
         super.init(coder: coder)
         setup()
     }
    
    private func setup() {
        guard let view = R.nib.repositoryDataView.instantiate(withOwner: self).first as? UIView else {
            fatalError("Fail to load DataView from Nib.")
        }
        view.frame = bounds
        view.layer.borderColor = R.color.controlHilight()!.cgColor
        view.layer.borderWidth = 0.5
        addSubview(view)
    }
    
    func setInfo(type this: Data) {
        iconInfoLabel.text = this.info
        iconImageView.image = this.iconImage
    }
}


