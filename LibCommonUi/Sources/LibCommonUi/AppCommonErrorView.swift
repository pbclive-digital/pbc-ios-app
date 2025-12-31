//
//  AppCommonErrorView.swift
//  LibCommonUi
//
//  Created by Kavimal Wijewardana on 12/29/25.
//
import SwiftUI
import LibCommonData
import KvColorPalette_iOS

public struct AppCommonErrorView: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var receivedViewMode: AppErrorType
    var navigateType: AppErrorNavigateType
    
    public init(viewMode: AppErrorType, navigateType: AppErrorNavigateType = .CLOSE) {
        self.receivedViewMode = viewMode
        self.navigateType = navigateType
    }
    
    public var body: some View {
        ZStack {
            AppBackgroundView()
            
            VStack {
                Spacer()
                switch(self.receivedViewMode) {
                case .NO_INTERNET:
                    HeadingTitleView(titleText: NSLocalizedString("label.error.no.internet", bundle: .module, comment: "a comment"))
                        .padding(.bottom, 50)

                    Image(systemName: "wifi.slash")
                        .resizable()
                        .foregroundColor(Color.themePalette.tertiary)
                        .frame(width: 200, height: 180)
                        .scaledToFit()
                        .padding(.bottom, 50)

                    Text("phrase.error.no.internet", bundle: .module)
                        .font(.system(size: 18, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.themePalette.onSurface)
                        .padding(.bottom, 80)
                    
                case .NO_CONNECTION:
                    HeadingTitleView(titleText: NSLocalizedString("label.error.no.connection", bundle: .module, comment: "a comment"))
                        .padding(.bottom, 50)

                    Image(systemName: "icloud.slash")
                        .resizable()
                        .foregroundColor(Color.themePalette.tertiary)
                        .frame(width: 220, height: 180)
                        .scaledToFit()
                        .padding(.bottom, 50)

                    Text("phrase.error.no.connection", bundle: .module)
                        .font(.system(size: 18, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.themePalette.onSurface)
                        .padding(.bottom, 80)
                    
                case .NEED_UPDATE:
                    HeadingTitleView(titleText: NSLocalizedString("label.error.update.needed", bundle: .module, comment: "a comment"))
                        .padding(.bottom, 50)

                    Image(systemName: "syringe")
                        .resizable()
                        .foregroundColor(Color.themePalette.tertiary)
                        .frame(width: 220, height: 180)
                        .scaledToFit()
                        .padding(.bottom, 50)

                    Text("phrase.error.update.needed", bundle: .module)
                        .font(.system(size: 18, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.themePalette.onSurface)
                        .padding(.bottom, 80)
                    
                case .UNATHORIZED:
                    HeadingTitleView(titleText: NSLocalizedString("label.error.unauthorized", bundle: .module, comment: "a comment"))
                        .padding(.bottom, 50)

                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .foregroundColor(Color.themePalette.tertiary)
                        .frame(width: 200, height: 180)
                        .scaledToFit()
                        .padding(.bottom, 50)

                    Text("phrase.error.unauthorized", bundle: .module)
                        .font(.system(size: 18, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.themePalette.onSurface)
                        .padding(.bottom, 80)
                    
                default:
                    HeadingTitleView(titleText: NSLocalizedString("label.error.service.unavailable", bundle: .module, comment: "a comment"))
                        .padding(.bottom, 50)

                    Image(systemName: "exclamationmark.circle")
                        .resizable()
                        .foregroundColor(Color.themePalette.tertiary)
                        .frame(width: 200, height: 180)
                        .scaledToFit()
                        .padding(.bottom, 50)

                    Text("phrase.error.service.unavailable", bundle: .module)
                        .font(.system(size: 18, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.themePalette.onSurface)
                        .padding(.bottom, 80)
                }
                
                Button {
                    switch(self.navigateType) {
                    case AppErrorNavigateType.CLOSE:
                        exit(0)
                    case AppErrorNavigateType.BACK:
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    AppButtonOutlineUI(buttonText: NSLocalizedString("label.close", bundle: .module, comment: "a comment"))
                }
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.bottom, 10)
        .navigationBarBackButtonHidden(true)
    }
}

struct CommonErrorView_Previews: PreviewProvider {
    static var previews: some View {
        AppCommonErrorView(viewMode: AppErrorType.NO_CONNECTION)
    }
}
