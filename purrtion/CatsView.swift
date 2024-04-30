//
//  catsView.swift
//  purrtion
//
//  Created by Vebrillia Santoso on 26/04/24.
//

import SwiftUI

struct CatsView: View {
    @State private var navigateToAdd = false
    
    var body: some View {
        NavigationStack{
        ZStack() {
            Text("Your cats")
                .font(Font.custom("Helvetica Neue", size: 32).weight(.bold))
                .foregroundColor(.black)
                .offset(x: -121.50, y: -401)
                .padding(.top , 60)
                .padding(.leading, 10)
            ZStack() {
                VStack(alignment: .leading, spacing: 21) {
                    Text("You haven’t added your cat yet. Let’s find the purrfect food portion for it ")
                        .font(Font.custom("SF Compact Display", size: 18))
                        .foregroundColor(.black)
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 100, height: 33)
                            .background(.white)
                            .cornerRadius(10)
                            .offset(x: 0, y: 0)
                        Button("HERE"){
                            navigateToAdd = true
                        }
                            .font(Font.custom("Helvetica Neue", size: 16).weight(.bold))
                            .foregroundColor(.black)
                            .offset(x: 0.50, y: -0.50)
                            .navigationDestination(isPresented: $navigateToAdd) {
                                ContentView()
                            }
                            .navigationBarBackButtonHidden(false)
                        
                    }
                    .frame(width: 100, height: 33)
                }
                .padding(
                    EdgeInsets(top: 14, leading: 16, bottom: 16.58, trailing: 144)
                )
                .frame(width: 377, height: 147.58)
                .background(Color(red: 0.93, green: 0.58, blue: 0.34))
                .cornerRadius(10)
                .offset(x: -3, y: 15.21)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 166, height: 167.08)
                    .background(
                        Image("firstcat")
                            .resizable()
                    )
                    .offset(x: 108.50, y: -5.46)
                
            }
            .frame(width: 383, height: 178)
            .offset(x: 3.50, y: -269)
        }
        .frame(width: 430, height: 932)
        .background(Color(red: 1, green: 1, blue: 0.96))
//        .navigationBarItems(leading:
//                    HStack {
//            Text("Your Cats").font(.largeTitle).fontWeight(.bold)
//            Spacer()
//                    }
//                            )
    }
        
}
    
}

#Preview {
    CatsView()
}
