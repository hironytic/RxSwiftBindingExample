//
// RxSwiftBindingExampleTests.swift
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

import XCTest
import RxSwift
import RxCocoa
@testable import RxSwiftBindingExample

class RxSwiftBindingExampleTests: XCTestCase {

    func testCalc() {
        let disposeBag = DisposeBag()
        let viewModel = ViewModel()
        
        let answerObserver = FulfillObserver(expectationWithDescription("empty before calculation")) { $0 == "" }
        viewModel.answerText
            .bindTo(answerObserver)
            .addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(1.0, handler: nil)

        answerObserver.reset(expectationWithDescription("30 after calculation")) { $0 == "30" }
        viewModel.number1ChangedAction.onNext("10")
        viewModel.number2ChangedAction.onNext("20")
        viewModel.calcAction.onNext()
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
    
    func testCalcEnabled() {
        let disposeBag = DisposeBag()
        let viewModel = ViewModel()
        
        let enabledObserver = FulfillObserver(expectationWithDescription("disabled")) { $0 == false }
        viewModel.calcEnabled
            .bindTo(enabledObserver)
            .addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(1.0, handler: nil)
        
        enabledObserver.reset(expectationWithDescription("become enabled")) { $0 == true }
        viewModel.number1ChangedAction.onNext("10")
        viewModel.number2ChangedAction.onNext("20")
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
}
