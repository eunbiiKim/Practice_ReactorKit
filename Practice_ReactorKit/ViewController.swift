//
//  ViewController.swift
//  Practice_ReactorKit
//
//  Created by eunbiiKim on 2022/11/23.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, StoryboardView {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bind(reactor: CounterViewReactor) {
        actionBind()
        stateBind()
    }
    
    private func actionBind() {
        increaseButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
    
    private func stateBind() {
        reactor?.state.map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor?.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
