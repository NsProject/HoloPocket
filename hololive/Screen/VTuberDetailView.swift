//
//  VTuberDetailView.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/01.
//

import SwiftUI
import URLImage

struct VTuberDetailView: View {
    @ObservedObject var dataSource:VTuberDetailStore
    var vtuberId:Int
    
    init(vtuberId :Int) {
        self.dataSource = VTuberDetailStore()
        self.vtuberId=vtuberId
    }
    
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment:.leading) {
                if let _vtuber = dataSource.vtuber{
                    VTuberDetailRow(vtuber: _vtuber)
                    Divider()
                }
            }
            
            Spacer().frame(height: 100)
            
            
            if self.dataSource.onair.count > 0{
                LazyVStack(alignment:.leading) {
                    Divider()
                    Text("放送中").padding(.top,8)
                    ForEach(dataSource.onair) { item in
                        LiveCellRow(live: item)
                    }
                }
            }
            
            
            if self.dataSource.schedules.count > 0{
                LazyVStack(alignment:.leading) {
                    Divider()
                    Text("放送予定").padding(.top,8)
                    ForEach(dataSource.schedules) { item in
                        LiveCellRow(live: item)
                    }
                }
            }
            
            if self.dataSource.archives.count > 0{
                LazyVStack(alignment:.leading) {
                    Divider()
                    Text("アーカイブ").padding(.top,8)
                    ForEach(dataSource.archives) { item in
                        LiveCellRow(live: item)
                    }
                }
            }
            
            if self.dataSource.funVideos.count > 0{
                LazyVStack(alignment:.leading) {
                    Divider()
                    Text("ファン動画").padding(.top,8)
                    ForEach(dataSource.funVideos) { item in
                        FunVideoRow(video: item)
                    }
                }
            }
        }
        .onAppear{
            self.dataSource.loadVTuber(self.vtuberId)
            self.dataSource.loadOnair(self.vtuberId)
            self.dataSource.loadSchedules(self.vtuberId)
            self.dataSource.loadArchives(self.vtuberId)
            self.dataSource.loadFunVideos(self.vtuberId)
        }.navigationBarTitle(self.dataSource.vtuber == nil ? "": self.dataSource.vtuber!.name)
    }
}

struct LiveCellRow: View {
    var live: LiveModel
    
    var body: some View {
        HStack(alignment: .top){
            if let _url=URL(string:live.thumbnailUrl){
                URLImage(url:_url) {
                    $0
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 150.0, height: 100.0).padding(.top,0)
                .onTapGesture{
                    let url = NSURL(string: Constants.VIDEO_WATCH_URL + live.id.description)
                    if UIApplication.shared.canOpenURL(url! as URL){
                        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                    }
                }
            }
            Text(live.title)
        }
    }
}


struct VTuberDetailRow: View {
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
                Text(vtuber.twitterId)
            }
        }
    }
}


