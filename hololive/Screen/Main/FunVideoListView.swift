//
//  FunVideoListView.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/27.
//

import SwiftUI
import URLImage

struct FunVideoListView: View {
    @ObservedObject var dataSource = FunVideoListStore()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment:.leading) {
                ForEach(dataSource.items) { item in
                    FunVideoRow(video: item)
                        .onAppear {
                            dataSource.loadMoreContentIfNeeded(currentItem: item)
                        }
                }
            }.padding([.leading, .bottom, .trailing], 8.0)
            
            if dataSource.isLoadingPage {
                ProgressView().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        
    }
}

struct FunVideoRow: View {
    var video: FunVideoListItemModel
    
    var body: some View {
        HStack(alignment: .top){
            if let _url=URL(string:video.thumbnailUrl){
                URLImage(url:_url) {
                    $0
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 150.0, height: 100.0).padding(.top,0)
                
                .onTapGesture{
                    let url = NSURL(string: Constants.FUNVIDEO_WATCH_URL + video.id.description)
                    if UIApplication.shared.canOpenURL(url! as URL){
                        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                    }
                }
            }
            Text(video.title)
        }
    }
}
