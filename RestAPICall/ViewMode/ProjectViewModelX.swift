//
//  ProjectViewModelX.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//


import Foundation
import Combine

class ProjectViewModelX: ObservableObject{
    @Published var projectInfo: [Project] = []
    private var cancellabe = Set<AnyCancellable>()
    init(){
        fetchProject()
    }
    
    func fetchProject(){
        let url = URL(string: "http://192.168.178.30:8000/project/")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: [Project].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                
            }, receiveValue: { project in
                self.projectInfo = project
            })
            .store(in: &cancellabe)
    }
    
    
    
    
}
