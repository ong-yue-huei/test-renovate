import UIKit
import Nuke

final class EventTableViewCell: UITableViewCell {
    func event(_ event: Event) {
        label.text = "\(event.type)"
        descriptionLabel.text = "\(event.actor.login)/\(event.repo.name)"
        Nuke.loadImage(with: event.actor.avatarUrl, into: profileImage)
        profileImage.layer.cornerRadius = profileImage.frame.size.width * 0.5
//        Nuke.loadImage(with: event.actor.avatarUrl, options: options, into: profileImage)
    }

//    let options = ImageLoadingOptions(
//        placeholder: UIImage(named: "placeholder"),
//        transition: .fadeIn(duration: 0.33),
//        failureImage: UIImage(named: "oopsie")
//    )
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet private var label: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
}
