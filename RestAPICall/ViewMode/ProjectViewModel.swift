//
//  ProjectViewModel.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//
import SwiftUI

class ProjectViewModel{
    var data: [Project]?
    
    private let service: ProjectServices
    
    init(service: ProjectServices){
        self.service = service
    }
    
    func fetchData(completion: @escaping (Result<[Project], Error>) -> Void){
        service.fetchProject { result in
            completion(result)
        }
    }
}
