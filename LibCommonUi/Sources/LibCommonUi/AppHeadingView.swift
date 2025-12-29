//
//  AppHeadingView.swift
//
//
//  Created by Kavimal Wijewardana on 9/3/23.
//

import SwiftUI
import KvColorPalette_iOS

// MARK: - UI component for Heading with title
public struct HeadingTitleView: View {

    var titleText: String
    var textSize: Int

    public init(titleText: String, textSize: Int = 48) {
        self.titleText = titleText
        self.textSize = textSize
    }

    public var body: some View {
        HStack {
            Text(self.titleText)
                .font(.system(size: CGFloat(self.textSize), weight: .medium))
                .foregroundColor(Color.themePalette.onSurface)
                .padding([.leading, .trailing, .top])
                .padding(.bottom, 5)
            Spacer()
        }
        .padding(.bottom, 2)
    }
}

// MARK: - UI component for Heading with title and back action
public struct HeadingTitleViewWithBack: View {

    var titleText: String
    var textSize: Int
    var backAction: () -> Void

    public init(titleText: String, textSize: Int = 48, backAction: @escaping () -> Void) {
        self.titleText = titleText
        self.textSize = textSize
        self.backAction = backAction
    }

    public var body: some View {
        HStack {
            Button(action: backAction, label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .foregroundColor(Color.themePalette.onSurface)
                    .frame(width: 15, height: 25, alignment: .center)
                    .padding(.leading)
                    .padding(.trailing)
            })

            Text(self.titleText)
                .font(.system(size: CGFloat(self.textSize), weight: .medium))
                .foregroundColor(Color.themePalette.onSurface)
                .padding(.trailing)
            Spacer()
        }
        .padding(.bottom, 2)
    }
}

// MARK: - UI component for Heading with title and back action
public struct HeadingTitleViewWithX: View {

    var titleText: String
    var closeAction: () -> Void

    public init(titleText: String, closeAction: @escaping () -> Void) {
        self.titleText = titleText
        self.closeAction = closeAction
    }

    public var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: closeAction, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(Color.themePalette.onSurface)
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(.trailing, 20)
                })
            }

            HStack {
                Text(self.titleText)
                    .font(.system(size: 48, weight: .medium))
                    .foregroundColor(Color.themePalette.onSurface)
                    .padding(.leading)
                Spacer()
            }
        }
        .padding(.bottom, 2)
    }
}

// MARK: - UI component for Heading with sub-title
public struct HeadingSubTitleView: View {

    var titleText: String

    public init(titleText: String) {
        self.titleText = titleText
    }

    public var body: some View {
        HStack {
            Text(self.titleText)
                .font(.system(size: 32, weight: .light))
                .foregroundColor(Color.themePalette.onSurface)
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 5)
            Spacer()
        }
        .padding(.bottom, 2)
    }
}

#Preview {
    HeadingTitleView(titleText: "Hello App")
}
