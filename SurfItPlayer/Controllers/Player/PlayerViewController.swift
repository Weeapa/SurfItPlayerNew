import Foundation
import UIKit

final class PlayerViewController: UIViewController {
    
    // MARK: - Subviews
    
    private let playerStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 8
        view.axis = .horizontal
        view.spacing = 6
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        return slider
    }()
    
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
//        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.clipsToBounds = true
//        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.addTarget(self, action: #selector(buttonActionStop), for: .touchUpInside)
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
        
        self.slider.maximumValue = Float(playerMP3Service.player.duration)
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        playerMP3Service.stopTrack()
    }
    
    // MARK: - Private methods
    
   
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(playerStackView)
        view.addSubview(slider)
 
        [
            playButton,
            stopButton,
        ].forEach(playerStackView.addArrangedSubview)
        
        let constraints = [

            playerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            playerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerStackView.widthAnchor.constraint(equalToConstant: 122),
            playerStackView.heightAnchor.constraint(equalToConstant: 44),
            
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.widthAnchor.constraint(equalToConstant: 300),
            slider.heightAnchor.constraint(equalToConstant: 44),
        ]
        
        
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Actions
    
    @objc func changeSlider(sender: UISlider){
        if sender == slider {
            playerMP3Service.player.currentTime = TimeInterval(sender.value)
        }
    }
    
    @objc
    private func buttonAction(sender: UIButton!) {
        playerMP3Service.playTrack()
    }
    
    @objc
    private func buttonActionStop(sender: UIButton!) {
        playerMP3Service.pauseTrack()
    }
}
