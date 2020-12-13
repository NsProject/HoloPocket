//
//  LiveListStore.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/12.
//

import Foundation
import Combine
import Alamofire

class LiveListStore: ObservableObject {
    @Published var items = [LiveModel]()
    @Published var isLoadingPage = false
    
    private var currentPage = 1
    private var canLoadMorePages = true
    
    init() {
        loadMoreContent(selectType:.schedule)
    }
    
    func loadMoreContentIfNeeded(selectType:LiveType,currentItem item: LiveModel?) {
        guard let item = item else {
            loadMoreContent(selectType:selectType)
            return
        }
        
        let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
        if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadMoreContent(selectType:selectType)
        }
    }
    
    func initLoad(selectType:LiveType) {
        currentPage=1
        canLoadMorePages = true
        isLoadingPage = false
        items = [LiveModel]()
        loadMoreContent(selectType:selectType)
    }
    
    private func loadMoreContent(selectType:LiveType) {
        guard !isLoadingPage && canLoadMorePages else{
            return
        }
        
        isLoadingPage = true
        
        let path: String = {
            switch selectType{
            case .schedule:
                return "schedules"
            case .onair:
                return "onair"
            case .archive:
                return "archives"
            }
        }()
        
        let url = URL(string:  Constants.API_URL + "lives/"+path+"?page="+currentPage.description)!
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            guard let data = response.data else {
                return
            }
            do {
                let items = try JSONDecoder().decode(LiveListModel.self, from: data)
                
                self.canLoadMorePages = items.currentPage != items.lastPage
                self.isLoadingPage = false
                self.currentPage += 1
                self.items = self.items + items.data
                
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
}
