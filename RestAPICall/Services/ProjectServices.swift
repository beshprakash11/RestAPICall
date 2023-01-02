//
//  ProjectServices.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//

import Foundation

class ProjectServices{
    func fetchProject(completion: @escaping (Result<[Project],Error>) -> Void){
        let url = URL(string: "http://192.168.178.30:8000/project/")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data{
                let decoder = JSONDecoder()
                do{
                    let model = try decoder.decode([Project].self, from: data)
                    completion(.success(model))
                }catch{
                    completion(.failure(error))
                    debugPrint(error.localizedDescription)
                }
            }
        }.resume()
    }
}
