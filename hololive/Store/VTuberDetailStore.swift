//
//  VTuberDetailStore.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/01.
//

import Foundation
import Combine

class VTuberDetailStore: ObservableObject {
    @Published var vtuber:VTuberModel?=nil
    @Published var archives=[LiveModel]()
    @Published var schedules=[LiveModel]()
    @Published var onair=[LiveModel]()
    @Published var funVideos=[FunVideoListItemModel]()
    
    
    func loadVTuber(_ vtuberId:Int) {
        let url = URL(string:  Constants.API_URL + "vtubers/"+vtuberId.description)!
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: VTuberModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .map({ response in
                return response
            })
            .catch({ _ in Just(self.vtuber) })
            .assign(to: &$vtuber)
    }
    
    func loadOnair(_ vtuberId:Int) {
        let url = URL(string:  Constants.API_URL + "vtubers/"+vtuberId.description+"/lives/onair")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: LiveListModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .map({ response in
                let tmp =  response.data.prefix(4)
                let newArray = Array(tmp)
                return newArray
            })
            .catch({ _ in Just(self.onair) })
            .assign(to: &$onair)
    }
    
    func loadSchedules(_ vtuberId:Int) {
        let url = URL(string:  Constants.API_URL + "vtubers/"+vtuberId.description+"/lives/schedules")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: LiveListModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .map({ response in
                let tmp =  response.data.prefix(4)
                let newArray = Array(tmp)
                return newArray
            })
            .catch({ _ in Just(self.schedules) })
            .assign(to: &$schedules)
    }
    
    func loadArchives(_ vtuberId:Int) {
        let url = URL(string:  Constants.API_URL + "vtubers/"+vtuberId.description+"/lives/archives")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: LiveListModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .map({ response in
                let tmp =  response.data.prefix(4)
                let newArray = Array(tmp)
                return newArray
            })
            .catch({ _ in Just(self.archives) })
            .assign(to: &$archives)
    }
    
    func loadFunVideos(_ vtuberId:Int) {
        let url = URL(string:  Constants.API_URL + "vtubers/"+vtuberId.description+"/fanmadeVideos")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: FunVideoListModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .map({ response in
                let tmp =  response.data.prefix(4)
                let newArray = Array(tmp)
                return newArray
            })
            .catch({ _ in Just(self.funVideos) })
            .assign(to: &$funVideos)
    }
    
}
