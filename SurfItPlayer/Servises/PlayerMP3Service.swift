//
//  PlayerMP3Service.swift
//  SurfItPlayer
//
//  Created by Калякин Дима on 08.09.2023.
//

import Foundation
import AVFoundation

final class PlayerMP3Service {
    private (set) var trackService: TrackService
    private (set) var selectedTrack: Track?
    private var player = AVAudioPlayer()
    
    init(trackService: TrackService) {
        self.trackService = trackService
    }
    
    func select(track: Track) {
        selectedTrack = track
    }
    
    func playTrack() {
        do {
            guard let track = selectedTrack,
                let file = Bundle.main.url(
                forResource: track.fileName,
                withExtension: "mp3"
            ) else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: file)
            player.numberOfLoops = 0
            player.volume = 1
            player.prepareToPlay()
            
            try AVAudioSession.sharedInstance().setCategory(
                .playback, mode: .default, options: []
            )
            try AVAudioSession.sharedInstance().setActive(true)
            
            player.play()
        } catch _ {
            print("player error")
        }
    }
    
    func stopTrack() {
        player.stop()
    }
}
