//
//  LiveListView.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/12.
//

import SwiftUI
import URLImage

struct LiveLitView: View {
    @ObservedObject var dataSource = LiveListStore()
    
    @State private var selectedIndex = LiveType.schedule
    
    var body: some View {
        ScrollView {
            Picker("", selection: self.$selectedIndex) {
                Text("配信予定")
                    .tag(LiveType.schedule)
                Text("配信中")
                    .tag(LiveType.onair)
                Text("アーカイブ")
                    .tag(LiveType.archive)
            }
            .onChange(of: self.selectedIndex, perform: {_ in
                dataSource.initLoad(selectType: self.selectedIndex)
            })
            .pickerStyle(SegmentedPickerStyle())
            
            LazyVStack(alignment:.leading) {
                ForEach(dataSource.items) { item in
                    LiveCellRow(live: item)
                        .onAppear {
                            dataSource.loadMoreContentIfNeeded(selectType: self.selectedIndex,currentItem: item)
                        }
                }
            }.padding([.leading, .bottom, .trailing], 8.0)
            
            if dataSource.isLoadingPage {
                ProgressView().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        
    }
}
