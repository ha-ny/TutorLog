//
//  AppVersionCheck.swift
//  TutoringSchedule
//
//  Created by 김하은 on 11/18/23.
//

import Foundation

class AppVersionCheck {
    
    static private let appleID = "6470282118"
    
    //업데이트 필요 여부 확인
    static func updateRequired(_ completion: @escaping (URL?) -> ()) {
        guard let oldVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return completion(nil) }

        getLatestAppStoreVersion { latestVersion in
            guard let latestVersion else { return completion(nil) }
            
            let compareResult = oldVersion.compare(latestVersion, options: .numeric)
            
            switch compareResult {
            case .orderedAscending: //앱 스토어 보다 낮은 버전(업데이트 필요)
                guard let url = URL(string: "itms-apps://itunes.apple.com/app/apple-store/\(appleID)") else { return completion(nil)}
                return completion(url)
            case .orderedDescending, .orderedSame: // 앱스토어 보다 높은 버전 또는 버전이 같은 경우
                return completion(nil)
            }
        }
    }
    
    //앱 스토어 최신 버전 체크
    private static func getLatestAppStoreVersion(_ completion: @escaping (String?) -> ()) {
        guard let url = URL(string: "http://itunes.apple.com/lookup?id=\(appleID)") else { return completion(nil) }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return completion(nil) }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return completion(nil) }
                guard let results = json["results"] as? [[String: Any]] else { return completion(nil) }
                guard let appStoreVersion = results[0]["version"] as? String else { return completion(nil) }
                
                return completion(appStoreVersion)
            } catch { }
        }.resume()
        
        return completion(nil)
    }
}
