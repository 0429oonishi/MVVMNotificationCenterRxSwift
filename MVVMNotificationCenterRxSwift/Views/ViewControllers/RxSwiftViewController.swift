//
//  RxSwiftViewController.swift
//  MVVMNotificationCenterRxSwift
//
//  Created by 大西玲音 on 2021/04/07.
//

import UIKit
import RxSwift
import RxCocoa

final class RxSwiftViewController: UIViewController {

    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var validationLabel: UILabel!
                                 //ユーザーの入力をViewModelに伝える
    private lazy var viewModel = RxSwiftViewModel(idTextObservable: idTextField.rx.text.asObservable(),
                                                  passwordTextObservable: passwordTextField.rx.text.asObservable(),
                                                  model: RxSwiftModel())
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //自身の状態とViewModelの状態をデータバインディング
        viewModel.validationText
            .bind(to: validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.loadLabelColor
            .bind(to: loadLabelColor)
            .disposed(by: disposeBag)

    }
    
    //ViewModelから返されるイベントを元に画面処理を実行
    private var loadLabelColor: Binder<UIColor> {
        return Binder(self) { me, color in
            me.validationLabel.textColor = color
        }
    }

}
