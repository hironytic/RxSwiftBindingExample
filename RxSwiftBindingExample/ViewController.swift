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

class ViewController: UIViewController {

    @IBOutlet weak var number1Field: UITextField!
    @IBOutlet weak var number2Field: UITextField!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        number1Field.text = ""
        number2Field.text = ""
        answerLabel.text = ""
        calcButton.enabled = false
    }
    
    @IBAction private func calc(sender: AnyObject) {
        let n1 = Int(number1Field.text ?? "") ?? 0
        let n2 = Int(number2Field.text ?? "") ?? 0
        answerLabel.text = String(n1 + n2)
    }

    @IBAction func number1Changed(sender: AnyObject) {
        updateCalcState()
    }
    
    @IBAction func number2Changed(sender: AnyObject) {
        updateCalcState()
    }
    
    private func updateCalcState() {
        calcButton.enabled = !(number1Field.text?.isEmpty ?? true)
                          && !(number2Field.text?.isEmpty ?? true)
    }
}

