//
//  ProjectViewCombine.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//

import SwiftUI

struct ProjectViewCombine: View {
    @ObservedObject var viewModel = ProjectViewModelX()
    var body: some View {
        VStack{
            Text("Data View")
            ForEach(viewModel.projectInfo, id: \.id){ model in
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
                    Image(systemName: model.active ? "checkmark.square.fill" : "square")
                        .foregroundColor(.blue)
                        .padding(10)
                        .frame(width: 50)
                        .background(.gray)
                }
            }
            
        }
    }
}

struct ProjectViewCombine_Previews: PreviewProvider {
    static var previews: some View {
        ProjectViewCombine()
    }
}
