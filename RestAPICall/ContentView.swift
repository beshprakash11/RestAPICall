//
//  ContentView.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//

import SwiftUI
struct GCode: Decodable, Identifiable{
    let id: Int
    let file_name: String
}
struct ContentView: View {
    @State private var gcode: [GCode]?
    @State private var imageURL: URL?
    
    var body: some View {
        VStack {
            ForEach(gcode ?? [], id: \.id){ model in
                Text(model.file_name)
            }
        }
        .onAppear(perform: fetchData)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView{
    private func fetchData(){
        let url = URL(string: "http://192.168.178.30:8001/file/")!
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let data = data{
                let decoder = JSONDecoder()
                do{
                    let model = try decoder.decode([GCode].self, from: data)
                    DispatchQueue.main.async {
                        self.gcode = model
                    }
                }catch{
                    debugPrint("Error")
                }
            }
        }.resume()
    }
}

struct ImageData: Decodable{
    let url: String
}
