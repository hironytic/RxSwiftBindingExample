//
// ViewModel.swift
// RxSwiftBindingExample
//
// Copyright (c) 2016 Hironori Ichimiya <hiron@hironytic.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation
import RxSwift

class ViewModel {
    let number1Text: Observable<String>
    let number2Text: Observable<String>
    let calcEnabled: Observable<Bool>
    let answerText: Observable<String>
    let number1ChangedAction: AnyObserver<String?>
    let number2ChangedAction: AnyObserver<String?>
    let calcAction: AnyObserver<Void>

    private let _number1Text = BehaviorSubject<String?>(value: "")
    private let _number2Text = BehaviorSubject<String?>(value: "")
    private let _calcAction = PublishSubject<Void>()
    
    init() {
        number1Text = _number1Text.map({ $0 ?? "" }).asObservable()
        number2Text = _number2Text.map({ $0 ?? "" }).asObservable()
        number1ChangedAction = _number1Text.asObserver()
        number2ChangedAction = _number2Text.asObserver()
        calcAction = _calcAction.asObserver()
        
        let numbers = Observable.combineLatest(number1Text, number2Text) { ($0, $1) }

        calcEnabled = numbers
            .map { (number1, number2) in
                return !number1.isEmpty && !number2.isEmpty
            }
        
        answerText = _calcAction
            .withLatestFrom(numbers)
            .map { (number1, number2) in
                let n1 = Int(number1) ?? 0
                let n2 = Int(number2) ?? 0
                return String(n1 + n2)
            }
            .startWith("")
    }
}
