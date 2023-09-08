//
//  TrackService.swift
//  SurfItPlayer
//
//  Created by Калякин Дима on 09.09.2023.
//

import Foundation

final class TrackService {
    private (set) var tracks: [Track]
    
    init() {
        self.tracks = TrackService.getTestTracks()
    }
    
    static private func getTestTracks() -> [Track] {
        var testTracks: [Track] = []
        
        let track1 = Track(
            titleName: "Вивальди - Зима/Лето",
            artist: "Вивальди",
            fileName: "classic1"
        )
        
        let track2 = Track(
            titleName: "Бетховен - К Элизе",
            artist: "Бетховен",
            fileName: "classic2"
        )
        
        let track3 = Track(
            titleName: "Бетховен - Симфония №5",
            artist: "Бетховен",
            fileName: "classic3"
        )
        let track4 = Track(
            titleName: "Скрипка и фортепиано",
            artist: "Unnowed",
            fileName: "classic4"
        )
        
        testTracks.append(track1)
        testTracks.append(track2)
        testTracks.append(track3)
        testTracks.append(track4)
        return testTracks
    }
}
