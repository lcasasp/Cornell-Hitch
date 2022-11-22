//
//  ContentView.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/16/22.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        //        Color.blue
        //            .ignoresSafeArea()
        
        
        NavigationStack{
            VStack{
                
                
                ZStack(alignment: .top)
                {
                    Color.green
                        .ignoresSafeArea()
                    Text("Rideshare")
                        .foregroundColor(.black)
                        .padding()
                        .font(.system(size: 60, design: .monospaced))
                    
                    
                }
                ZStack{
                    Rectangle()
                    Color.yellow
                    
                    Section{
                        VStack(alignment: .center){
                            
                            TextField("Username",text:$username)
                                .padding(.top, 20)
                            
                            
                            TextField("Password",text:$username)
                                .padding(.top, 20)
                            
                        }
                        
                    }
                    
                    //                    .padding(.vertical)
                    //                    .background(Color.black.opacity(0.8).cornerRadius(15))
                }
                ZStack(alignment: .bottom){
                    
                    
                    Color.red
                        .ignoresSafeArea()
                        .foregroundColor(.black)
                    ZStack{
                        Color.blue
                            .frame(width:80,height:10)
                            .clipShape(Capsule())
                        
                        Text("Sign up")
                            .frame(width:80,height:10)
                            .padding()
                            .background(.blue.opacity(1))
                            .cornerRadius(15)
                    }
                }
                
                
            }
            
            
            
            
            
            
        }
    }
    
    
    //                ZStack(alignment: .center){
    //
    //
    //
    //                    ZStack(alignment:.center)
    //                    {
    //
    //
    //
    //                        Spacer()
    //
    //
    //
    //                        VStack{
    //
    //
    //                            Section{
    //
    //
    //                                ZStack{
    //
    //
    //                                    ZStack{
    //
    //                                        TextField("",text:$username)
    //                                            .padding(.leading)
    //                                            .padding(.top)
    //                                    }
    //
    //
    //
    //
    //                                            .padding(.vertical)
    //                                            .background(Color.gray.opacity(0.2).cornerRadius(15))
    //
    //                                    .foregroundColor(.black)
    //
    //                                    ZStack(alignment: .topLeading){
    //
    //                                        Text("Email")
    //
    //                                            .frame(width: 40, alignment: .leading)
    //                                            .font(.system(size: 12))
    //                                            .padding(.bottom, 25)
    //                                            .padding(.leading, -163)
    //
    //                                    }
    //                                }
    //
    //
    //
    //
    //
    //                                ZStack{
    //
    //                                    ZStack{
    //                                        SecureField("",
    //                                                    text:$password)
    //                                        .padding(.leading)
    //                                        .padding(.top)
    //                                    }
    //
    //
    //                                    .padding(.vertical)
    //                                    .background(Color.gray.opacity(0.2).cornerRadius(15))
    //
    //                                    .foregroundColor(.black)
    //
    //                                    ZStack(alignment:.topLeading){
    //                                        Text("Password")
    //
    //                                            .frame(width: 60, alignment: .leading)
    //                                            .font(.system(size: 12))
    //                                            .padding(.bottom, 25)
    //                                            .padding(.leading, -163)
    //
    //                                    }
    //
    //                                }
    //
    //                                Spacer()
    //                                    .frame( height:100)
    //                                ZStack{
    //                                    Color.blue
    //                                        .ignoresSafeArea()
    //                                        .clipShape(Capsule())
    //                                    Text("Sign in")
    //                                        .frame(width:80,height:10)
    //                                        .padding()
    //                                        .background(.blue.opacity(0.8))
    //                                        .cornerRadius(15)
    //                                }
    //                                Spacer()
    //                                    .frame( height:10)
    //                                ZStack{
    //                                    Color.blue
    //                                        .ignoresSafeArea()
    //                                        .clipShape(Capsule())
    //
    //                                    Text("Sign up")
    //                                        .frame(width:80,height:10)
    //                                        .padding()
    //                                        .background(.blue.opacity(0.8))
    //                                        .cornerRadius(15)
    //                                }
    //                            }
    //
    //
    //
    //
    //
    //                        }
    //
    //
    //
    //
    //
    //
    //                    }
    //                    Spacer()
    //
    //
    //
    //
    //
    //                }
    //
    //
    //                }
    //            }
    //
    //
    //            .padding()
    //
    //        }
    
    
    
    
    //        Section{
    //
    //            Button("Sign Up", action:{
    //                print("Yay")
    //            })
    //
    //        }
    
    
    
    
    //                    .alignmentGuide(HorizontalAlignment.center) { _ in  50 }
    
    
    
    
    
    
    
    
    
    
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
