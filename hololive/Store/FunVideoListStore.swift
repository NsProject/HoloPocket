//
//  FunVideoListStore.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/27.
//

import Foundation
import Combine
import Alamofire

class FunVideoListStore: ObservableObject {
    @Published var items = [FunVideoListItemModel]()
    @Published var isLoadingPage = false
    
    private var currentPage = 1
    private var canLoadMorePages = true
    
    init() {
        loadMoreContent()
    }
    
    func loadMoreContentIfNeeded(currentItem item: FunVideoListItemModel?) {
        guard let item = item else {
            loadMoreContent()
            return
        }
        
        let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
        if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadMoreContent()
        }
    }
    
    private func loadMoreContent() {
        guard !isLoadingPage && canLoadMorePages else{
            return
        }
        
        isLoadingPage = true
        
        let url = URL(string:  Constants.API_URL + "videos?page="+currentPage.description)!
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            guard let data = response.data else {
                return
            }
            do {
                let items = try JSONDecoder().decode(FunVideoListModel.self, from: data)
                
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
