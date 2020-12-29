//
//  ContentView.swift
//  SwiftUI_Add_Animation
//
//  Created by Hung-Chun Tsai on 2020-12-28.
//

import SwiftUI
import PureSwiftUI

private let buttonBlue = Color(red: 42/255, green: 99/255, blue: 228/255)

private typealias TitleAndSymbol = (title: String, symbol: SFSymbolName)

private let buttonTitlesAndSymbols: [[TitleAndSymbol]] = [
    [("Favorite", .star), ("Tag", .tag), ("Share", .square_and_arrow_up)],
    [("Comment", .text_bubble), ("Delete", .trash)]
]

private let defaultAnimation = Animation.easeOut(duration: 0.5)
private let hideAnimation = defaultAnimation
private let showAnimation = Animation.spring(response: 0.6, dampingFraction: 0.6)

struct ContentView: View {
    @State private var showingButton = true
    @State private var homeLocation = CGPoint.zero
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 10){
                Text("Carter, Tsai").fontSize(40).yOffset(-60)
                Text("SwiftUI - Menu Animation").yOffset(-60)
                
            }
            Color.black.opacity(0.8)
                .opacityIfNot(self.showingButton, 0)
                .animation(defaultAnimation)
            VStack(spacing:60){
                Spacer()
                ForEach(0..<buttonTitlesAndSymbols.count) { rowIndex in
                    HStack(spacing: 60) {
                        ForEach(0..<buttonTitlesAndSymbols[rowIndex].count) { colIndex in
                            MyPalButton(tilteAndSymbol: buttonTitlesAndSymbols[rowIndex][colIndex])
                                .offsetToPositionIfNot(self.showingButton, self.homeLocation)
                                .opacityIfNot(self.showingButton, 0)
                                
                            
                        }
                    }
                }
                
                Circle()
                    .fill(buttonBlue)
                    .overlay(SFSymbol(.plus).foregroundColor(.white)
                                .rotateIf(self.showingButton, -45.degree))
                    .frame(48)
                    .geometryReader{(geo: GeometryProxy) in
                        self.homeLocation = geo.globalCenter
                }
                    .onTapGesture {
                        withAnimation(self.showingButton ? hideAnimation : showAnimation) {
                            self.showingButton.toggle()
                        }
                        
                    }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}

struct MyPalButton: View {
    fileprivate let tilteAndSymbol: TitleAndSymbol
    
    var body: some View {
        Circle()
            .fillColor(.white)
            .overlay(SFSymbol(tilteAndSymbol.symbol))
            .overlay(CaptionText(tilteAndSymbol.title.uppercased(), .white, .semibold).fixedSize() .yOffset(40))
            .frame(50)
    }
}
