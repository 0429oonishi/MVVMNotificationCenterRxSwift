//
//  RxSwiftViewModel.swift
//  MVVMNotificationCenterRxSwift
//
//  Created by 大西玲音 on 2021/04/08.
//

import RxSwift
import RxCocoa

final class RxSwiftViewModel {
    
    let validationText: Observable<String>
    let loadLabelColor: Observable<UIColor>
    
    init(idTextObservable: Observable<String?>,
         passwordTextObservable: Observable<String?>,
         model: RxSwiftModelProtocol) {
        
        //Viewからイベントを受け取り、Modelの処理を呼ぶ
        let event = Observable
            .combineLatest(idTextObservable, passwordTextObservable)
            .skip(1)
            .flatMap { idText, passwordText -> Observable<Event<Void>> in
                return model
                    .validate(idText: idText, passwordText: passwordText)
                    .materialize()
            }
            .share()
        
        
        //Viewからイベントを受け取り、加工して値を更新する
        self.validationText = event
            .flatMap { event -> Observable<String> in
                switch event {
                case .next:
                    return .just("OK!!!")
                case let .error(error as ModelError):
                    return .just(error.errorText)
                case .error, .completed:
                    return .empty()
                }
            }
            .startWith("IDとPasswordを入力してください。")
        
        //Viewからイベントを受け取り、加工して値を更新する
        self.loadLabelColor = event
            .flatMap { event -> Observable<UIColor> in
                switch event {
                case .next:
                    return .just(.green)
                case .error:
                    return .just(.red)
                case .completed:
                    return .empty()
                }
            }
        
    }
    
}
