//
// ViewController.swift
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

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var number1Field: UITextField!
    @IBOutlet weak var number2Field: UITextField!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    
    var disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.number1Text
            .bindTo(number1Field.rx.text)
            .addDisposableTo(disposeBag)
        viewModel.number2Text
            .bindTo(number2Field.rx.text)
            .addDisposableTo(disposeBag)
        viewModel.calcEnabled
            .bindTo(calcButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
        viewModel.answerText
            .bindTo(answerLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        number1Field.rx.text
            .bindTo(viewModel.number1ChangedAction)
            .addDisposableTo(disposeBag)
        number2Field.rx.text
            .bindTo(viewModel.number2ChangedAction)
            .addDisposableTo(disposeBag)
        calcButton.rx.tap
            .bindTo(viewModel.calcAction)
            .addDisposableTo(disposeBag)
    }
}

