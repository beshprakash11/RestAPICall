//
//  ProjectViewPV.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//

import SwiftUI

struct ProjectViewPV: View {
    @State private var data: [Project]?

    var body: some View {
        VStack{
            Text("Data View")
            ForEach(data ?? [], id: \.id){ model in
                HStack{
                    Text(model.name)
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(width: 250)
                        .background(.blue)
                    Text(model.status)
                        .foregroundColor(.red)
                        .padding(10)
                        .frame(width: 100)
                        .background(.gray)
                }
            }
            
        }
        .onAppear(perform: fetchData)
    }
    
    private func fetchData(){
        let service = ProjectServices()
        let viewModel = ProjectViewModel(service: service)
        
        viewModel.fetchData { result in
            switch result{
            case .success(let data):
                self.data = data
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

struct ProjectViewPV_Previews: PreviewProvider {
    static var previews: some View {
        ProjectViewPV()
    }
}
