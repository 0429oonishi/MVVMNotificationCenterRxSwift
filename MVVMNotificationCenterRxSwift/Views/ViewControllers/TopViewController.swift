//
//  TopViewController.swift
//  MVVMNotificationCenterRxSwift
//
//  Created by 大西玲音 on 2021/04/07.
//

import UIKit

final class TopViewController: UIViewController {
    
    @IBAction private func NotificationCenterButtonDidTapped(_ sender: Any) {
        let notificationViewController = UIStoryboard(name: "NotificationCenter", bundle: nil).instantiateViewController(identifier: "NotificationCenterViewController") as! NotificationCenterViewController
        present(notificationViewController, animated: true, completion: nil)
    }
    
    @IBAction private func RxSwiftButtonDidTapped(_ sender: Any) {
        let rxSwiftViewController = UIStoryboard(name: "RxSwift", bundle: nil).instantiateViewController(identifier: "RxSwiftViewController") as! RxSwiftViewController
        present(rxSwiftViewController, animated: true, completion: nil)
    }
    
}
