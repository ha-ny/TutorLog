//
//  UIViewController+Extension.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/23.
//

import UIKit

extension UIViewController {
    func errorHandling(_ task: () throws -> ()) {
        do {
            try task()
        } catch let realmError as RealmErrorType {
            let errorDescription = realmError.description
            UIAlertController.customMessageAlert(view: self, title: errorDescription.title, message: errorDescription.message)
        } catch { }
    }
}
