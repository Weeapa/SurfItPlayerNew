import Foundation
import UIKit

final class TrackListViewController: UIViewController {
    
    let playerMP3Service = PlayerMP3Service(trackService: TrackService())
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.addSubview(tableView)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func navigateToPlayerViewController() {
        let vc = PlayerViewController(playerMP3Service: playerMP3Service)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TrackListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerMP3Service.trackService.tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print("tracks", playerMP3Service.trackService.tracks)
        
        guard !playerMP3Service.trackService.tracks.isEmpty else {
            return UITableViewCell()
        }
        
        let track = playerMP3Service.trackService.tracks[indexPath.row]
        cell.textLabel?.text = track.titleName
        cell.detailTextLabel?.text = track.artist

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = playerMP3Service.trackService.tracks[indexPath.row]
        playerMP3Service.select(track: track)
        navigateToPlayerViewController()
    }
}
