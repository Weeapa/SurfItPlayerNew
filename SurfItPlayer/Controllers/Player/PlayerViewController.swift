import Foundation
import UIKit

final class PlayerViewController: UIViewController {
    
    // MARK: - Subviews
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .red
        button.clipsToBounds = true
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    private let playerMP3Service: PlayerMP3Service
    
    // MARK: - Initialization and deinitialization
    
    init(playerMP3Service: PlayerMP3Service) {
        self.playerMP3Service = playerMP3Service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        playerMP3Service.stopTrack()
    }
    
    // MARK: - Private methods
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(playButton)
        
        let constraints = [
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 122),
            playButton.heightAnchor.constraint(equalToConstant: 44)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Actions
    
    @objc
    private func buttonAction(sender: UIButton!) {
        playerMP3Service.playTrack()
    }
}
