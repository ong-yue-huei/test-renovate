import UIKit
import Nuke

final class EventTableViewCell: UITableViewCell {
    func event(_ event: Event) {
        label.text = event.type
        descriptionLabel.text = event.repo.name
        Nuke.loadImage(with: event.actor.avatarUrl, into: profileImage)
    }
    
    @IBOutlet private var profileImage: UIImageView!{
        didSet {
            profileImage.clipsToBounds = true
            profileImage.layer.cornerRadius = profileImage.frame.size.width * 0.5
        }
    }
    @IBOutlet private var label: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
}
