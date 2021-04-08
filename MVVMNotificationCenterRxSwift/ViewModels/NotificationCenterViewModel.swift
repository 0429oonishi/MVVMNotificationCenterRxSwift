//
//  NotificationCenterViewModel.swift
//  MVVMNotificationCenterRxSwift
//
//  Created by 大西玲音 on 2021/04/07.
//

import UIKit

final class NotificationCenterViewModel {
    
    let changeText = Notification.Name("changeText")
    let changeColor = Notification.Name("changeColor")
    private let notificationCenter: NotificationCenter
    private let model: NotificationCenterModelProtocol
    
    init(notificationCenter: NotificationCenter,
         model: NotificationCenterModelProtocol = NotificationCenterModel()) {
        self.notificationCenter = notificationCenter
        self.model = model
    }
    
    //Viewからイベントを受け取り、Modelの処理を呼び出す
    func idPasswordChanged(id: String?, password: String?) {
        let result = model.validate(idText: id, passwordText: password)
        switch result {
        case .success:
            //Viewからイベントを受け取り、加工して値を更新する
            notificationCenter.post(name: changeText, object: "OK!!!")
            //Viewからイベントを受け取り、加工して値を更新する
            notificationCenter.post(name: changeColor, object: UIColor.green)
        case .failure(let error as ModelError):
            //Viewからイベントを受け取り、加工して値を更新する
            notificationCenter.post(name: changeText, object: error.errorText)
            //Viewからイベントを受け取り、加工して値を更新する
            notificationCenter.post(name: changeColor, object: UIColor.red)
        case _:
            fatalError("Unexpected pattern.")
        }
    }
    
}
