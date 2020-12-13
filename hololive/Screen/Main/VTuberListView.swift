//
// VTuberListView.swift
//  hololive
//
//  Created by kinositayuu on 2020/09/30.
//

import SwiftUI
import URLImage

struct VTuberListView: View {
    @ObservedObject var dataSource = VTuberListStore()
    
    var body: some View {
            ScrollView {
                LazyVStack(alignment:.leading) {
                    ForEach(dataSource.items) { item in
                        VTuberRow(vtuber: item)
                            .onAppear {
                                dataSource.loadMoreContentIfNeeded(currentItem: item)
                            }
                    }
                }.padding([.leading, .bottom, .trailing], 8.0)
                
                if dataSource.isLoadingPage {
                    ProgressView().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
            .navigationBarTitle("ライバー一覧", displayMode: .inline)
        }
    
}

struct VTuberRow: View {
    var vtuber: VTuberModel
    
    var body: some View {
        HStack(alignment: .top){
            if let _url=URL(string:vtuber.iconUrl){
                NavigationLink(destination: VTuberDetailView(vtuberId: vtuber.id)) {
                    URLImage(url:_url) {
                          $0
                              .resizable()
                              .aspectRatio(contentMode: .fill)
                      }
                      .frame(width: 100, height: 100)
                      .clipped()
                }
            }
            VStack(alignment: .leading, spacing: 8.0){
                Text(vtuber.name)
                let url = Constants.TWITTER_URL+vtuber.twitterId
                if let _url = URL(string:url) {
                    Link(url, destination: _url)
                }
            }
        }
    }
}
