//
//  NotificationCenterViewController.swift
//  MVVMNotificationCenterRxSwift
//
//  Created by 大西玲音 on 2021/04/07.
//

import UIKit

final class NotificationCenterViewController: UIViewController {

    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var validationLabel: UILabel!
    
    private let notificationCenter = NotificationCenter()
    private lazy var viewModel = NotificationCenterViewModel(notificationCenter: notificationCenter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.addTarget(self, action: #selector(textFieldEditignChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldEditignChanged), for: .editingChanged)
        //自身の状態とViewModelの状態をデーターバインディングする
        notificationCenter.addObserver(self, selector: #selector(updateValidationText), name: viewModel.changeText, object: nil)
        //自身の状態とViewModelの状態をデーターバインディングする
        notificationCenter.addObserver(self, selector: #selector(updateValidationColor), name: viewModel.changeColor, object: nil)
        
    }

}

private extension NotificationCenterViewController {
    
    @objc func textFieldEditignChanged(sender: UITextField) {
        //ユーザーの入力をViewModelに渡す
        viewModel.idPasswordChanged(id: idTextField.text, password: passwordTextField.text)
    }
    
    @objc func updateValidationText(notification: Notification) {
        //ViewModelから返されるイベントを元に描画処理を実行する
        guard let text = notification.object as? String else { return }
        validationLabel.text = text
    }
    
    @objc func updateValidationColor(notification: Notification) {
        //ViewModelから返されるイベントを元に描画処理を実行する
        guard let color = notification.object as? UIColor else { return }
        validationLabel.textColor = color
    }
    
}
