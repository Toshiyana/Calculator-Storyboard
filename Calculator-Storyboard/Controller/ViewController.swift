//
//  ViewController.swift
//  Calculator-Storyboard
//
//  Created by Toshiyana on 2021/03/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber: Bool = true//praivateは{}のみアクセス可能(この場合，class ViewController内のみ)，この変数はこのclassでしか使わないと考えてpraivateをつける
    
    //computed propertyを利用
    private var displayValue: Double {
        get {
            // Double()のreturnはoptional. Double("A")などとなった場合は変換できないため
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double.")
            }
            return number
        }
        set {//値がsetされた時に実行
            displayLabel.text = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private var calclator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {

        isFinishedTypingNumber = true
        
        calclator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            //数字を何も押さずに記号を押した場合，nilになる
            if let result = calclator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {

        if let numValue = sender.currentTitle, let text = displayLabel.text {
            
            //小数点を含むか否かの判定，オリジナル（文字列検索より）
            if isFinishedTypingNumber {
                if numValue != "." {
                    displayLabel.text = numValue
                    isFinishedTypingNumber = false
                }
            } else {
                if numValue == "." {
                    if text.contains(".") {
                        return
                    }
                }
                
                displayLabel.text = text + numValue
                
            }

            //小数を含むか否かの判定（lesson, これだと連続して"."を打つとエラーand 0の時でも"."を打ててしまう）
//            if isFinishedTypingNumber {
//                displayLabel.text = numValue
//                isFinishedTypingNumber = false
//            } else {
//                if numValue == "." {
//                    guard let currentDisplayValue = Double(displayLabel.text!) else {
//                        fatalError("Cannot convert display label text to a Double.")
//                    }
//
//                    //整数かどうか判定することで小数点を含むか判定
//                    let isInt = floor(currentDisplayValue) == currentDisplayValue
//
//                    if !isInt {//既に小数を含む場合，それ以上小数点をつけられない
//                        return
//                    }
//                }
//                displayLabel.text = displayLabel.text! + numValue
//            }
            
        }
    }
    
    
    
    
}

