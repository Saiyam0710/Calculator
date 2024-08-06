//
//  ContentView.swift
//  Calculator
//
//  Created by Target Integration on 09/09/23.
//

import SwiftUI

enum CalButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "/"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var butonColor: Color{
        switch self{
        case .add, .divide, .multiply, .subtract, .equal :
            return .orange
            
        case .clear, .negative, .percent:
            return Color(.darkGray)
            
        default:
            return Color(.lightGray)
        }
    }
}
enum Operation{
    case add, subtract, multiply, divide, none
}
struct ContentView: View {
    
    @State var currentOperation: Operation = .none
    @State var runningNumber = 0
    @State var value = "0";
    let buttons: [[CalButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea(.all)
            VStack{
                Spacer()
                // text display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 75))
                    .foregroundColor(Color.white)
                }
                //buttons
                
                ForEach(buttons, id:\.self){row in
                    HStack(spacing: 12) {
                        ForEach(row, id:\.self){item in
                            Button {
                                self.didTap(button: item)
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                
                                    .background(item.butonColor)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                                     
                            }

                            
                        }
                    }.padding(.bottom,3)
                }
            }
        }
    }
    
    func didTap(button: CalButton){
        switch button {
        case .add, .divide, .multiply, .subtract, .equal :
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal{
                self.value = "0"
            }
            
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }else{
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalButton) -> CGFloat{
        
        if(item == .zero){
            return ((UIScreen.main.bounds.width - (4*12))/4 ) * 2
        }
        return (UIScreen.main.bounds.width - (5*12))/4
    }
    
    func buttonHeight() -> CGFloat{
        return(UIScreen.main.bounds.width - (5*12))/4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
