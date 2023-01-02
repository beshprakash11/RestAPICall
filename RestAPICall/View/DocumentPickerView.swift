//
//  DocumentPickerView.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//


import SwiftUI
import UIKit

struct DocumentPickerView: View{
    @State var show: Bool = false
    @State var fileName: String = ""
    @State var pickedDataURL: [URL] = []
    
    var body: some View {
        VStack{
            Text(fileName)
            Button(action: {
                self.show.toggle()
            }, label: {
                Text("Document Picker")
            })
            .fileImporter(isPresented: $show, allowedContentTypes: [.data, .jpeg, .png, .pdf, .plainText], allowsMultipleSelection: true) { result in
                /*if let pickURL = try? result.get(){
                    self.pickedDataURL = pickURL
                    debugPrint("Picked URL: ", pickedDataURL)
                }*/
                switch result{
                case .success(let urls):
                    self.pickedDataURL = urls
                    
                    self.postImageToAPI()
                case .failure(let error):
                    debugPrint("Error occurs: ", error.localizedDescription)
                }
            }
        }//:VS
    }
}

struct DocumentPickerView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentPickerView()
    }
}
extension DocumentPickerView{
    func postImageToAPI(){
        /*for url in pickedDataURL{
            guard let imageDataArray = try? Data(contentsOf: url) else { continue }
            debugPrint("Image data: ",imageDataArray)
        }*/
        let urlData = pickedDataURL.map { try? Data(contentsOf: $0)}
        debugPrint("Image data: ",urlData)
        debugPrint("Image URL: ", pickedDataURL)
    }
}
