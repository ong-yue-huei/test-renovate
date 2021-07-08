import UIKit

final class EventTableViewCell: UITableViewCell {
    func event(_ event: Event) {
        label.text = "\(event.type)"
        descriptionLabel.text = "\(event.actor.login)/\(event.repo.name)"
    }

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet private var label: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
}
