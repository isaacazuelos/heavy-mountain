import Foundation

struct Track {
    let number: UInt8
    static let noTrack: Track = Track(number: 0)
    
    static let transition3:  CGFloat = 618
    static let transition4:  CGFloat = 907
    static let transition7:  CGFloat = 1195
    static let transition8:  CGFloat = 2000
    static let transition10: CGFloat = 5000
    
    var url: URL? {
        let name: String
        switch number {
        case 1:  name = "01.wav"
        case 2:  name = "02.wav"
        case 3:  name = "03.wav"
        case 4:  name = "04.wav"
        case 5:  name = "05.wav"
        case 6:  name = "06.wav"
        case 7:  name = "07.wav"
        case 8:  name = "08.wav"
        case 9:  name = "09.wav"
        case 10: name = "10.wav"
        case 11: name = "11.wav"
        default:
            print("no url for track number: \(number)")
            return nil
        }
        return Bundle.main.url(forResource: name, withExtension: nil)
    }
    
    func next(at position: CGPoint) -> Track {
        let y = position.y
        print("loading next track with position: \(position)")
        switch number {
        case 1:  return Track(number: 2)
        case 2:  return Track(number: 3)
        case 3:  return Track(number: y >= Track.transition3 ? 4 : 3)
        case 4:  return Track(number: y >= Track.transition4 ? 5 : 4)
        case 5:  return Track(number: 6)
        case 6:  return Track(number: 7)
        case 7:  return Track(number: y >= Track.transition7 ? 8 : 7)
        case 8:  return Track(number: y >= Track.transition8 ? 9 : 8)
        case 9:  return Track(number: 10)
        case 10: return Track(number: 11)
        case 11: return Track.noTrack
        default: return Track.noTrack
        }
    }
}
