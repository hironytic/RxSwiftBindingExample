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

    private let _number1Text = Variable<String>("")
    private let _number2Text = Variable<String>("")
    private let _calcEnabled = Variable<Bool>(false)
    private let _answerText = Variable<String>("")
    private let _calcAction = ActionObserver<Void>()
    private let _number1ChangedAction = ActionObserver<String?>()
    private let _number2ChangedAction = ActionObserver<String?>()
    
    init() {
        number1Text = _number1Text.asObservable()
        number2Text = _number2Text.asObservable()
        answerText = _answerText.asObservable()
        calcEnabled = _calcEnabled.asObservable()
        number1ChangedAction = _number1ChangedAction.asObserver()
        number2ChangedAction = _number2ChangedAction.asObserver()
        calcAction = _calcAction.asObserver()
        
        _calcAction.handler = { [weak self] in self?.calc() }
        _number1ChangedAction.handler = { [weak self] in self?.number1Changed($0) }
        _number2ChangedAction.handler = { [weak self] in self?.number2Changed($0) }
    }
    
    private func calc() {
        let n1 = Int(_number1Text.value) ?? 0
        let n2 = Int(_number2Text.value) ?? 0
        _answerText.value = String(n1 + n2)
    }
    
    private func number1Changed(_ value: String?) {
        _number1Text.value = value ?? ""
        updateCalcState()
    }
    
    private func number2Changed(_ value: String?) {
        _number2Text.value = value ?? ""
        updateCalcState()
    }
    
    private func updateCalcState() {
        _calcEnabled.value = !_number1Text.value.isEmpty && !_number2Text.value.isEmpty
    }
}
