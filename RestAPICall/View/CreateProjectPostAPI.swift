//
//  CreateProjectPostAPI.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//

import SwiftUI
import Combine

struct CreateProjectPostAPI: View {
    @State var refresh: Bool = false
    var body: some View {
        VStack(alignment: .center){
            HStack{
                Spacer()
                //Create files
                Button(action: {
                    self.createGCode()
                }, label: {
                    Text("Create Gcode")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(20)
                        .frame(maxWidth: 250)
                        .background(.primary)
                        .cornerRadius(10)
                })
                Spacer()
                //Create files
                Button(action: {
                    self.postData()
                }, label: {
                    Text("Post Gcode")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(20)
                        .frame(maxWidth: 250)
                        .background(.green)
                        .cornerRadius(10)
                })
                Spacer()
                //Refres files
                Button(action: {
                    self.refresh.toggle()
                }, label: {
                    Text("Refresh")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(20)
                        .frame(maxWidth: 250)
                        .background(.green)
                        .cornerRadius(10)
                })
                Button(action: {
                    self.deletGcode()
                }, label: {
                    Text("Delete")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(20)
                        .frame(maxWidth: 250)
                        .background(.red)
                        .cornerRadius(10)
                })
                Spacer()
                
            }//:HS
            Divider().padding(20)
            VStack{
                Text(refresh ? self.readGcode() : self.readGcode())
                Spacer()
            }
            .padding(.top, 20)
            Spacer()
        }//VS:
        .padding(.top, 50)
        
    }
}

struct CreateProjectPostAPI_Previews: PreviewProvider {
    static var previews: some View {
        CreateProjectPostAPI()
    }
}


extension CreateProjectPostAPI{
    //MARK: Create GCode in local URL
    func createGCode(){
        let fileManager = FileManager.default
        
        if let documentDirecotroy = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first{
            let gcodeURL = documentDirecotroy.appendingPathComponent("GCode.txt")
            let gcodeData = "G90\nTRAORI\nORIWKS\nG64; Ref. points\nG1 X0 Y0 Z0\nM30; Progoram teraminate".data(using: .utf8)
            
            //create files
            fileManager.createFile(atPath: gcodeURL.path, contents: gcodeData, attributes: nil)
            
        }else{
            debugPrint("Cannot create files")
        }
    }
    
    //MARK: Read gcode from the local directory
    func readGcode() -> String{
        let fileManger = FileManager.default
        guard let documentURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else { return "No Data"}
        let fileURL = documentURL.appendingPathComponent("GCode.txt")
        
        do{
            let contents = try String(contentsOf: fileURL)
            return contents
        }catch let error{
            return "Data reading error: \(error.localizedDescription)"
        }
    }
    
    //MARK: Delete files
    func deletGcode(){
        let fileManger = FileManager.default
        guard let documentURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else { return}
        let fileURL = documentURL.appendingPathComponent("GCode.txt")
        
        if fileManger.fileExists(atPath: fileURL.path){
            do{
                try fileManger.removeItem(at: fileURL)
            }catch {
                debugPrint("Erro to deletion")
            }
        }else{
            debugPrint("Fle does not exists")
        }
    }
    
    //MARK: Post data to the RESTAPI
    func postData(){
        let fileManger = FileManager.default
        guard let documentURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentURL.appendingPathComponent("GCode.txt")
        
        //API_URL for posting data
        let api_url = URL(string: "http://192.168.178.30:8001/file/")!
        var request = URLRequest(url: api_url)
        request.httpMethod = "POST"
        let data = try? Data(contentsOf: fileURL)
        
    }
}
