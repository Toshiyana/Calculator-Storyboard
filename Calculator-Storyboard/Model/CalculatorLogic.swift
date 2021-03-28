//
//  CalculatorLogic.swift
//  Calculator-Storyboard
//
//  Created by Toshiyana on 2021/03/26.
//

import Foundation

struct CalculatorLogic {
    
    //objectの生成時に使わないpropertyはoptional型にする
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?//tuple
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        
        if let num = number {
            switch symbol {
            case "AC":
                return 0
            case "+/-":
                return num * -1
            case "%":
                return num * 0.01
            case "=":
                return performTwoNumCalculation(n2: num)
            default:
                intermediateCalculation = (n1: num, calcMethod: symbol)
            }
        }
        return nil//上記のいずれも満たさない場合
    }
    
    private func performTwoNumCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "X":
                return n1 * n2
            case "/":
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        
        return nil
    }
    
}
