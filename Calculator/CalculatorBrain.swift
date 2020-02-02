//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Shyngys on 01.02.2020
//  Copyright © 2020 Shyngys Zharmukhambetov. All rights reserved.
//

import Foundation

func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

class CalculatorBrain
{
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        "∏": Operation.Constant(Double.pi),
        "C" :Operation.Constant(0.0),
        "√": Operation.UnaryOperation(sqrt),
        "×": Operation.BinaryOperation(multiply),
        "÷": Operation.BinaryOperation( { (op1, op2) in return op1 / op2 }),
        "+": Operation.BinaryOperation( { return $0 + $1 }),
        "-": Operation.BinaryOperation { $0 - $1 },
        //        "%": Operation.UnaryOperation(<#T##(Double) -> Double#>)
        "=": Operation.Equals,
        "x^y":Operation.BinaryOperation({return pow($0,$1)}),
        "ran":Operation.Constant(Double.random(in: 1...1000))
        
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double)  -> Double)
        case Equals
    }
    
    func performOperation(symbol: String){
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo  {
        var binaryFunction: (Double, Double) ->  Double
        var firstOperand: Double
    }
    
    var result: Double {
        get  {
            return accumulator
        }
    }
    
}
