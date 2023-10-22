//
//  Extension+UIAlertController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/22.
//

import UIKit

extension UIAlertController {
    
    func customMessageAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        return alert
    }
}
