//
//  SwiftUIView.swift
//  
//
//  Created by Kavimal Wijewardana on 9/16/23.
//

import SwiftUI
import KvColorPalette_iOS

// MARK: - UI component for TextField
public struct AppTextFieldOutlineUI: View {
    
    private var hint: String!
    @State private var valueText: Binding<String>
    @State private var isDisable = false
    
    public init(hint: String, valueText: Binding<String>!) {
        self.hint = hint
        self.valueText = valueText
    }
    
    public var body: some View {
        TextField(self.hint, text: self.valueText)
            .padding(.all)
            .frame(height: 45)
            .padding(4)
            .disabled(isDisable)
            .overlay(
                RoundedRectangle(cornerRadius: 5.0)
                    .strokeBorder(Color.themePalette.quaternary, style: StrokeStyle(lineWidth: 1.0))
            )
    }
}

// MARK: - UI component for Multiline TextField
public struct AppMultilineTextFieldOutlineUI: View {
    
    private var hint: String!
    @State private var valueText: Binding<String>
    @State private var isDisable = false
    
    public init(hint: String, valueText: Binding<String>!) {
        self.hint = hint
        self.valueText = valueText
    }
    
    public var body: some View {
        TextField(self.hint, text: self.valueText, axis: .vertical)
            .font(.system(size: 12, weight: .light))
            .padding(.all, 10)
            .frame(height: 90, alignment: .top)
            .disabled(isDisable)
            .overlay(
                RoundedRectangle(cornerRadius: 5.0)
                    .strokeBorder(Color.themePalette.quaternary, style: StrokeStyle(lineWidth: 1.0))
            )
    }
}

struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var valueText: String = "Value"
        AppTextFieldOutlineUI(hint: "HINT", valueText: $valueText)
    }
}
