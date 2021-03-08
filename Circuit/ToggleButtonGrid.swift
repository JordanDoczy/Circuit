//
//  LayoutView.swift
//  Circuit
//
//  Created by Jordan Doczy on 3/6/21.
//

import SwiftUI

struct ToggleButtonGrid: View {

    @EnvironmentObject var model: Model
    
    var layout: [GridItem] {
        (0..<model.columns).map { _ in GridItem(.flexible()) }
    }

    var body: some View {
        ZStack {
            LinearGradient(Color.darkStart1, Color.darkEnd1)
            LazyVGrid(columns: layout, spacing: 50) {
                ForEach (model.buttons.indices) { i in
                    if model.buttons[i] == Model.nilVal {
                        Spacer()
                    } else {
                        ToggleButton(state: $model.buttons[i]) {
                            getNeighbors(from: i).forEach { index in
                                model.buttons[index].isOn = true
                            }
                            
                            //model.buttons[i].direction = .w
                        }
                    }
                }
                Button("Print") {
                    print(model.buttons)
                }
            }
            .id(UUID())
            .padding(20)
        }
        .ignoresSafeArea(.all)
    }
    
    func getNeighbors(from index: Int) -> [Int] {
        
        let size = model.buttons.count
        let columns = model.columns
        let direction = model.buttons[index].direction
        let row = index / columns
        
        switch(direction) {
        case .n:
            var indicies: [Int] = []
            var i = index - columns
            while i > 0 {
                indicies.append(i)
                i -= columns
            }
            return indicies
        case .s:
            var indicies: [Int] = []
            var i = index + columns
            while i < size {
                indicies.append(i)
                i += columns
            }
            return indicies
        case .e:
            var indicies: [Int] = []
            var i = index + 1
            while i < (row+1) * columns {
                indicies.append(i)
                i += 1
            }
            return indicies
        case .w:
            var indicies: [Int] = []
            var i = index - 1
            while i > (row+1) {
                indicies.append(i)
                i -= 1
            }
            return indicies
        case .none:
            return []
        }
    }

}

struct ToggleButton: View {

    @Binding var state: UInt8
    var action: (() -> Void)?

    var body: some View {
        Toggle(isOn: $state.isOn) {
            state.direction.image
                .foregroundColor(.white)
        }
        .toggleStyle(ToggleButtonStyle() {
          action?()
        })
    }
}

struct ToggleButtonStyle: ToggleStyle {
    
    var action: (() -> Void)?
    
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
            action?()
        }) {
            configuration.label
                .padding(30)
                .contentShape(Circle())
            
        }
        .buttonStyle(CircleButtonStyle(isHighlighted: configuration.isOn))
        
    }
}

struct CircleButtonStyle: ButtonStyle {
    
    var isHighlighted = false
    
    init(isHighlighted: Bool = false) {
        self.isHighlighted = isHighlighted
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(ButtonBackground(isHighlighted: configuration.isPressed || isHighlighted, shape: Circle()))
    }
}

struct ButtonBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S

    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightStart, Color.lightEnd))
                    .shadow(color: Color.lightLight, radius: 10)
                shape
                    .stroke(Color.nearBlack, lineWidth: 8)
                    .blur(radius: 4)
                    .offset(x: 2, y: 2)
                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))

                shape
                    .stroke(Color.nearBlack, lineWidth: 8)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2)
                    .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .shadow(color: Color.lightStart, radius: 5)
            }
        }
    }
}

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)

    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)

    static let darkStart1 = Color(red: 100 / 255, green: 120 / 255, blue: 130 / 255)
    static let darkEnd1 = Color(red: 50 / 255, green: 50 / 255, blue: 65 / 255)

    static let lightGray = Color(red: 100 / 255, green: 120 / 255, blue: 225 / 255)

    
    static let lightStart = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255, opacity: 0.5)
    static let lightEnd = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    
    static let lightLight = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255, opacity: 0.2)
    
    static let nearBlack = Color(red: 10 / 255, green: 10 / 255, blue: 10 / 255)

}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

#if DEBUG
var model = Model()

struct ToggleButtonGrid_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButtonGrid()
            .environmentObject(model)
    }
}
#endif
