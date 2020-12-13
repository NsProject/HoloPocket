//
//  MainView.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/12.
//

import Foundation
import SwiftUI
import URLImage
import FontAwesome_swift

struct MainView: View {
    
    @State private var tabSelection = MainTabType.vtubers
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection){
                VTuberListView()
                    .tabItem {
                        VStack {
                            Image(uiImage: UIImage.fontAwesomeIcon(name: .user, style: .solid, textColor: .black, size: CGSize(width: 40, height: 40)))
                            Text("ライバー")
                        }
                    }.tag(MainTabType.vtubers)
                
                LiveLitView()
                    .tabItem {
                        VStack {
                            Image(uiImage: UIImage.fontAwesomeIcon(name: .play, style: .solid, textColor: .black, size: CGSize(width: 40, height: 40)))
                            Text("配信情報")
                        }
                    }.tag(MainTabType.lives)
                
                FunVideoListView()
                    .tabItem {
                        VStack {
                            Image(uiImage: UIImage.fontAwesomeIcon(name: .photoVideo, style: .solid, textColor: .black, size: CGSize(width: 40, height: 40)))
                            Text("ファン動画")
                        }
                    }.tag(MainTabType.funVideos)
            }
            .navigationBarTitle(Text(navigationBarTitle), displayMode: .inline)
        }
    }
}

private extension MainView {
    var navigationBarTitle: String {
        switch(tabSelection){
        case .vtubers:
            return "ライバー"
        case .lives:
            return "配信情報"
        case .funVideos:
            return "ファン動画"
        }
    }
}
