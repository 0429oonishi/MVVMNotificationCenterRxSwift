//
//  Model.swift
//  MVVMNotificationCenterRxSwift
//
//  Created by 大西玲音 on 2021/04/07.
//

protocol NotificationCenterModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Result<Void>
}

final class NotificationCenterModel: NotificationCenterModelProtocol {
    
    func validate(idText: String?, passwordText: String?) -> Result<Void> {
        switch (idText, passwordText) {
        case (.none, .none): return .failure(ModelError.invalidIdAndPassword)
        case (.none, .some): return .failure(ModelError.invalidId)
        case (.some, .none): return .failure(ModelError.invalidPassword)
        case (let idText?, let passwordText?):
            switch (idText.isEmpty, passwordText.isEmpty) {
            case (true, true): return .failure(ModelError.invalidIdAndPassword)
            case (false, false): return .success(())
            case (true, false): return .failure(ModelError.invalidId)
            case (false, true): return .failure(ModelError.invalidPassword)
            }
        }
    }
    
}
