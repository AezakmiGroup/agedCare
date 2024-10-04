import Foundation
import UIKit
import FirebaseRemoteConfig

struct AgedColor {
   
    static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let bgColor = #colorLiteral(red: 0.8155465126, green: 0.8831213117, blue: 0.8838805556, alpha: 1)
    static let blue = #colorLiteral(red: 0.3438738585, green: 0.8175842166, blue: 0.8038011789, alpha: 1)
    static let red = #colorLiteral(red: 0.9308356643, green: 0.2690732479, blue: 0.2851892114, alpha: 1)
    static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)

}




class AgedMentee : NSObject, StreamDelegate {
   
    var defaults = UserDefaults.standard
    
    func fetchFromRemote() async -> URL? {
        let remoteConfig = RemoteConfig.remoteConfig()
        
        do {
            let status = try await remoteConfig.fetchAndActivate()
            if status == .successFetchedFromRemote || status == .successUsingPreFetchedData {
                let urlString = remoteConfig["privacyLink"].stringValue ?? ""
                guard let url = URL(string: urlString) else { return nil }
                return url
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func start(_ callback : @escaping (URL) -> Void ){
        let home = defaults.value(forKey: "home") as? String ?? ""
      
        if home != "" {
            guard let url = URL(string: home) else { return }
            callback(url)
        } else {
            Task {
                if let url = await fetchFromRemote() {
                    DispatchQueue.main.async {
                        callback(url)
                    }
                }
            }
        }
    }
}

extension UIView {
    
    func radiusOnlyTopLeft(radius: Double){
//        clipsToBounds = true
        layer.cornerRadius = radius
        
        layer.maskedCorners =  [.layerMaxXMinYCorner]
    }
    
    func radiusOnlyTop(radius: Double){
//        clipsToBounds = true
        layer.cornerRadius = radius
        
        layer.maskedCorners =  [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func radiusOnlyTopRight(radius: Double){
//        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMinYCorner]
    }
    
    func radiusOnlyBottomLefft(radius: Double){
//        clipsToBounds = true
        layer.cornerRadius = radius
        
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner] //layerMaxXMinYCorner
    }
    
    func radiusOnlyBottomRight(radius: Double){
//        clipsToBounds = true
        layer.cornerRadius = radius
        
        layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
}
