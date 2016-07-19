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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numbers = Observable.combineLatest(number1Field.rx_text, number2Field.rx_text) { ($0, $1) }
        
        numbers
            .map { (number1, number2) in
                return !number1.isEmpty && !number2.isEmpty
            }
            .bindTo(calcButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        calcButton.rx_tap
            .withLatestFrom(numbers)
            .map { (number1, number2) in
                let n1 = Int(number1) ?? 0
                let n2 = Int(number2) ?? 0
                return String(n1 + n2)
            }
            .startWith("")
            .bindTo(answerLabel.rx_text)
            .addDisposableTo(disposeBag)
    }
}

