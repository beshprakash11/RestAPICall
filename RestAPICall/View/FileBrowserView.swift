//
//  FileBrowserView.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//

import SwiftUI
import Foundation

struct FileBrowserView: View {
    @State private var contents: [String] = []
    @State private var newDir: URL?
    
    @State private var isRefresh: Bool = false
    
    var body: some View {
        VStack{
            fileCreateView()
            fileDeleteView()
            
            VStack{
                HStack(spacing: 5){
                    VStack{
                        List(contents, id:\.self){file in
                            Text(isRefresh ? file : file)
                        }
                    }
                    .frame(maxWidth: 350)
                    .border(.red, width: 2)
                    .padding(.top, 20)
                                        
                    //Display testfiles
                    VStack{
                        Text(isRefresh ? self.readTextFile() : self.readTextFile())
                        Spacer()
                    }
                    .frame(maxWidth: 350)
                    .padding(20)
                    .border(.red, width: 2)
                    .padding(.top, 20)
                }
            }
        }//VS
    }
    
    
    
}

struct FileBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        FileBrowserView()
    }
}

extension FileBrowserView{
    //MARK: CREATE VIEW
    func fileCreateView()-> some View{
        //Create data and directory
        HStack{
            //List directory
            Button(action: {
                do{
                    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    self.contents = try FileManager.default.contentsOfDirectory(atPath: documentURL.path)
                    
                }catch{
                    debugPrint(error.localizedDescription)
                }
            }, label: {
                Text("List fiels")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .padding(20)
                    .background(.blue)
                    .cornerRadius(8)
            })
            
            //Create directory
            Button(action: {
                let fileManger = FileManager.default
                do{
                    let documentURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let newDirName = "NewDir"
                    self.newDir = documentURL.appendingPathComponent(newDirName)
                    try fileManger.createDirectory(at: self.newDir!, withIntermediateDirectories: false, attributes: nil)
                    
                    
                }catch{
                    debugPrint(error.localizedDescription)
                }
            }, label: {
                Text("Create Dir")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .padding(20)
                    .background(.blue)
                    .cornerRadius(8)
            })
            
            //Create files
            Button(action: {
                let fileManger = FileManager.default
                do{
                    let documentURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let newDirName = "NewDir"
                    self.newDir = documentURL.appendingPathComponent(newDirName)
                   
                    // create files
                    let fileURL = documentURL.appendingPathComponent("MyText.txt")
                    
                    let fileURL1 = documentURL.appendingPathComponent("GCode.mpf")
                    
                    let newData = "G90\nTRAORI\nORIWKS\nG64\nG1 X0 Y30 Z30 A0 B0 C90 F15000 \nM30".data(using: .utf8)
                    
                    let data = "Hello, world! This is a file test!!".data(using: .utf8)
                    
                    try data?.write(to: fileURL)
                    try newData?.write(to: fileURL1)
                    
                }catch{
                    debugPrint(error.localizedDescription)
                }
            }, label: {
                Text("Create Files")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .padding(20)
                    .background(.blue)
                    .cornerRadius(8)
            })
            
            
        }//HS
    }
    
    //MARK: DELETE VIEW
    func fileDeleteView() -> some View{
        HStack{
            //Delete directory
            Button(action: {
                let fileManger = FileManager.default
                guard let documentURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
                let newDirName = "NewDir"
                let existDir = documentURL.appendingPathComponent(newDirName)
                
                if fileManger.fileExists(atPath: existDir.path){
                    do{
                        try fileManger.removeItem(at: existDir)
                    }catch{
                        
                    }
                }else{
                    debugPrint("No directory exists")
                }
                    
            }, label: {
                Text("Delete Dir")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .padding(20)
                    .background(.red)
                    .cornerRadius(8)
            })
            
            //Delete files
            Button(action: {
                let fileManger = FileManager.default
                guard let documentURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
                let fileURL = documentURL.appendingPathComponent("MyText.txt")
                
                let fileURL1 = documentURL.appendingPathComponent("GCode.mpf")
                
                if fileManger.fileExists(atPath: fileURL.path){
                    do{
                        try fileManger.removeItem(at: fileURL)
                    }catch{
                        
                    }
                }
                
                if fileManger.fileExists(atPath: fileURL1.path){
                    do{
                        try fileManger.removeItem(at: fileURL1)
                    }catch{
                        
                    }
                }
                
            }, label: {
                Text("Delete Files")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .padding(20)
                    .background(.red)
                    .cornerRadius(8)
            })
            
            //Refresh files
            Button(action: {
                self.isRefresh.toggle()
            }, label: {
                Text("Refresh files")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .padding(20)
                    .background(.green)
                    .cornerRadius(8)
            })
            
        }
    }
}

extension FileBrowserView{
    
    //MARK: Read Data
    func readTextFile() -> String{
        let fileManger = FileManager.default
        
        guard let documentURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else { return ""}
        
        let fielURL = documentURL.appendingPathComponent("GCode.mpf")
        
        do {
            let contents = try String(contentsOf: fielURL)
            return contents
        }catch{
            return "\(error.localizedDescription)"
        }
    }
}
