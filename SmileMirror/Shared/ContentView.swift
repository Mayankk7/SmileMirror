//
//  ContentView.swift
//  Shared
//
//  Created by Admin on 06/06/22.
//

import SwiftUI

struct ContentView: View {
    @State var GotoHome: Bool = false

    var body: some View {
        if GotoHome{
            MainApp()}
        else{
            AppHome(GotoHome : $GotoHome)
        }
        
    }
}

struct AppHome : View{
    @Binding var GotoHome: Bool
    var body: some View {
        VStack{
            Text("Welcome to Smile Mirror ").padding().border(Color.white)
            Button(action: {
                GotoHome = true
            }) {
                Text("Start").padding()
            }.frame(width: 300).background(Color.black).foregroundColor(.white).cornerRadius(10)
        }.frame(width: .infinity, height: .infinity)
    }
}

struct MainApp : View{
    @State private var isShown : Bool = false
    @State private var image : Image = Image(systemName: "")
    @State private var  sourceType: UIImagePickerController.SourceType = .camera
    
    var body : some View{
        VStack{
            Text("Smile is Magical !")
            image.resizable().frame(width: 200, height: 200)
            .border(Color.black)
            Button(action: {
                self.isShown.toggle()
                self.sourceType = .camera
            }) {
                Text("Open Camera").padding()}.background(Color.black).cornerRadius(10).foregroundColor(.white)
        }.sheet(isPresented : $isShown){
            A(isShown : self.$isShown, myimage: self.$image, mysourceType: self.$sourceType)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct A:UIViewControllerRepresentable{
    @Binding var isShown : Bool
    @Binding var myimage : Image
    @Binding var mysourceType : UIImagePickerController.SourceType
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<A>) {
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<A>) -> UIImagePickerController {
        let obj = UIImagePickerController()
        obj.sourceType = mysourceType
        obj.delegate = context.coordinator
        return obj
    }
    
    func makeCoordinator() -> C {
        return C(isShown: $isShown, myimage: $myimage)
    }
}


class C: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @Binding var isShown : Bool
    @Binding var myimage : Image
    
    init(isShown: Binding<Bool>, myimage: Binding<Image>){
        _isShown = isShown
        _myimage = myimage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(image)
            myimage = Image.init(uiImage : image)
        }
        isShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}
