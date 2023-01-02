//
//  ProjectView.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//

import SwiftUI

struct ProjectView: View {
    @State private var project: [Project]?
    var body: some View {
        VStack{
            Text("Fetch Project Data")
            ForEach(project ?? [], id: \.id) { proj in
                HStack{
                    Text(proj.name)
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(width: 250)
                        .background(.blue)
                    Text(proj.status)
                        .foregroundColor(.red)
                        .padding(10)
                        .frame(width: 100)
                        .background(.gray)
                }
            }
            
        }
        .onAppear(perform: fetchProject)
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}


extension ProjectView{
    private func fetchProject(){
        let url = URL(string: "http://192.168.178.30:8000/project/")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data{
                let decoder = JSONDecoder()
                do{
                    let model = try decoder.decode([Project].self, from: data)
                    DispatchQueue.main.async {
                        self.project = model
                    }
                }catch{
                    debugPrint(error.localizedDescription)
                }
            }
        }.resume()
    }
}
