//
//  SharedDocumentView.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//

import SwiftUI
struct SharedDocumentView: View {
    @State var fileName: String = ""
    @State var openFile: Bool = false
    @State var saveFile: Bool = false
    @State var fileURL: URL?
    var body: some View {
        VStack{
            Text(fileName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            Button(action: {
                self.openFile.toggle()
            }, label: {
                Text("Select Folder")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(20)
                    .background(.primary)
            })
            
            Button(action: {
                self.saveFile.toggle()
            }, label: {
                Text("Save File")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(20)
                    .background(.primary)
            })
        }
        //Load files
        .fileImporter(isPresented: $openFile, allowedContentTypes: [.png, .jpeg]) { result in
            do{
                fileURL = try result.get()
                
                debugPrint("New file: ", fileURL)
                
                //geting file name
                self.fileName = fileURL!.lastPathComponent
                
                debugPrint("Filename: ",fileName)
                
            }catch{
                debugPrint("Error in loading:", error.localizedDescription)
            }
        }
       
        
        
    }
}


struct SharedDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        SharedDocumentView()
    }
}
