//
//  ContentView.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/16/22.
//

import SwiftUI
import SafariServices


struct ContentView: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var action: Int? = 0
    @State private var showSafari: Bool = false
    @State private var x: Int = 0
    @State private var y: CGFloat = -500
    @State private var showHome: Bool = false
    var body: some View {
        let timer = Timer.publish(every: 0.001, on: .current, in: .common).autoconnect()
        
        
        NavigationStack{
            
            ZStack{
                Rectangle()
                    
                Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
                
                VStack{
                    
                    
                    ZStack(alignment: .top)
                    {
//
                            Text("Cornell Hitch")
                                .foregroundColor(.black)
                                .padding()
                                .multilineTextAlignment(.center)
                            
                                .font(.system(size: 40, design: .monospaced))
                        
                                .offset(y:y)
                                
                                .onReceive(timer) { input in
                                    if y < -270{
                                        y += 1
                                  
                                    }
                                    else{
                                        y = -270
                                    }
                                            }
                        
                    }
                    .frame(width:.infinity)
                    ZStack(alignment: .bottom){
                        HStack{
                            Spacer()
                                .frame(width:10)
                            ZStack{
                                VStack{
                                    ZStack{
                                        Color.gray.opacity(0.4)
                                            .frame(width: 350, height: 60)
                                            .clipShape(Capsule())
                                        TextField("Email", text: $email)
                                            .padding(.leading, 50)
                                    }
                                    
                                    ZStack{
                                        
                                        Color.gray.opacity(0.4)
                                            .frame(width: 350, height: 60)
                                            .clipShape(Capsule())
                                        TextField("Enter name", text: $name)
                                            .padding(.leading, 50)
                                    }
                                    
                                    VStack{
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.blue.opacity(0.2), lineWidth: 2)
                                                .frame(height:20)
                                            
                                            Text("Log in")
                                            Button("        "){
                                                showHome = true
                                                NetworkManager.getUsers{response in
                                                    print(response)
                                                }
                                                
                                                
                                            }
                                            NavigationLink(destination: CreateRideView(user: name)) {
                                                        Text("      ")
                                                    }
                                            

                                            
                                               
                                                
                                            
                                        }
                                       
                                        
                                                                                

                                        ZStack{
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.blue.opacity(0.2), lineWidth: 2)
                                                .frame(height:20)
                                            HStack{
                                                Image("google")
                                                    .resizable()
                                                    .frame(width:20,height:20)
                                                    .cornerRadius(2)
                                                Text("Sign in")
                                                
                                            }
                                            
                                            Button("        "){
                                                showSafari = true
                                                NetworkManager.createUser(email: "jnm224@cornell.edu", name: "Josh M")
                                            }
                                            
                                            .sheet(isPresented: $showSafari){
                                                SafariView(url:URL(string: "http://35.194.68.103/login/")!)
                                                
                                                
                                                
                                                
                                            }
                                            //
                                        }
                                        .offset(y:200)

                                    }
                                    
                                        
                                    .frame(width:140,height:60)
                                    .font(.system(size: 20, design: .rounded))
                                   
                                    
                                    
                                    
                                }
                                
                                
                                
                                //                                            NetworkManager.login()
                            }
                        }
                    }
                    
                    
                    
                }
                                
                
                
                
                
                
                
                
                
                
                
            }
        }
        
      
    }
    
    
    //    DMView(dms: [
    //        Message(sender_id:221031446, timestamp: "12:30 AM", body: """
    //Good morning, my name is Josh and I am looking for a ride to Syracuse
    //on November 30th. I noticed you're already headed there, do you have any more room?
    //"""),
    //        Message(sender_id:112031839, timestamp: "12:35 AM", body:
    //"""
    //Hi Josh.
    //Sure, I have room for one more. I plan on leaving at 4 AM on that day, and gas would be $5 per person.
    //"""),
    //        Message(sender_id:221031446, timestamp: "12:37 AM", body: """
    //Perfect, thanks so much!
    //"""),Message(sender_id:112031839, timestamp: "12:38 AM", body:
    //"""
    //No problem, let's meet behind RPCC on the day of.
    //""")], sender_id: 221031446, recipient_id: 112031839)
    
    
    

    
    
    
}




struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}





//private extension ContentView{
//    var usernameTextView: some View{
//        TextField("Username",
//                  text:$username,
//                  prompt: Text("Username"))
//            .textContentType(.username)
//    }
//}
//
//private extension ContentView{
//    var passwordTextView: some View{
//        TextField("Password",
//                  text:$password,
//                  prompt: Text("Password"))
//            .textContentType(.password)
//    }
//}
