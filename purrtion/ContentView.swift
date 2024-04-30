//
//  ContentView.swift
//  purrtion
//
//  Created by Vebrillia Santoso on 24/04/24.
//

import SwiftUI



struct ChatMessage: Identifiable {
    var id = UUID()
    var text: String
    var isMe: Bool
}

struct ContentView: View {
    @State private var cat: Cat = Cat(name: "", age: 0, weight:0)
    @State private var name = ""
    @State private var age = ""
    @State private var weight = ""
    @State private var messages: [ChatMessage] = []
    @State private var currentQuestionIndex = 0
    @State private var ageUnit = "months"
    @State private var weightUnit = "kg"
    @State private var showAlert = false
    @State private var navigateToDetails = false
    
    let questions = ["Hi, there! what is your cat’s name?", "What a cute name! How old is your cat?", "Great! What is your cat's weight?"]
    
    var body: some View {
        NavigationStack{
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(messages) { message in
                        HStack {
                            if message.isMe {
                                Spacer()
                                Text(message.text)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.black)
                                    .clipShape(ChatBubble(isFromMe: message.isMe))
                                    .padding(.horizontal, 10)
                            } else {
                                Text(message.text)
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(Color.orange.opacity(0.7))
                                    .clipShape(ChatBubble(isFromMe: message.isMe))
                                    .padding(.horizontal, 10)
                                Spacer()
                            }
                        }
                        
                    }
                }
            }
            .padding(.vertical)
            
            HStack {
                if currentQuestionIndex == 1 {
                    Picker(selection: $age, label: Text("")) {
                        //                        ForEach(1..<21) { age in
                        //                            Text("\(age)")
                        //                        }
                        Text("1").tag("1")
                        Text("2").tag("2")
                        Text("3").tag("3")
                        Text("4").tag("4")
                        Text("5").tag("5")
                        Text("6").tag("6")
                        Text("7").tag("7")
                        Text("8").tag("8")
                        Text("9").tag("9")
                        Text("10").tag("10")
                        Text("11").tag("11")
                        Text("12").tag("12")
                        Text("13").tag("13")
                        Text("14").tag("14")
                        Text("15").tag("15")
                        Text("16").tag("16")
                        Text("17").tag("17")
                        Text("18").tag("18")
                        Text("19").tag("19")
                        Text("20").tag("20")
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding(10)
                    
                    Picker(selection: $ageUnit, label: Text("")) {
                        Text("months").tag("months")
                        Text("years").tag("years")
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding(10)
                } else if currentQuestionIndex == 2 {
                    Picker(selection: $weight, label: Text("")) {
                        //                            ForEach(1..<21) { age in
                        //                                Text("\(age)")
                        Text("1").tag("1")
                        Text("2").tag("2")
                        Text("3").tag("3")
                        Text("4").tag("4")
                        Text("5").tag("5")
                        Text("6").tag("6")
                        Text("7").tag("7")
                        Text("8").tag("8")
                        Text("9").tag("9")
                        Text("10").tag("10")
                        Text("11").tag("11")
                        Text("12").tag("12")
                        Text("13").tag("13")
                        Text("14").tag("14")
                        Text("15").tag("15")
                        Text("16").tag("16")
                        Text("17").tag("17")
                        Text("18").tag("18")
                        Text("19").tag("19")
                        Text("20").tag("20")
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding(10)
                    
                    Picker(selection: $weightUnit, label: Text("")) {
                        Text("kg").tag("kg")
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding(10)
                }
                
                
                else {
                    TextField(questions[currentQuestionIndex], text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(10)
                        .keyboardType(.default)
                }
                
                Button(action: {
                    sendMessage(message: currentQuestionIndex == 1 ? age : name)
                }) {
                    Text("Send")
                        .padding(10)
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 20)
        .onAppear {
            // Display initial question
            messages.append(ChatMessage(text: questions[currentQuestionIndex], isMe: false))
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("Successfully added your cat!"), dismissButton: .default(Text("Done"), action: {
                navigateToDetails = true
            }))
        }
        .navigationBarTitle("")
        .navigationDestination(isPresented: $navigateToDetails) {
            CatDetails(cat: cat)
        }
    }
}
    
    func sendMessage(message: String) {
        if currentQuestionIndex == 0{
            messages.append(ChatMessage(text: message, isMe: true))
            cat.name = name
        } else if currentQuestionIndex == 1{
            let ageString = "\(age) \(ageUnit)"
            messages.append(ChatMessage(text: ageString, isMe: true))
            
            if ageUnit == "years" {
                if let ageInt = Int(age) {
                    cat.age = ageInt * 12
                }
            } else {
                if let ageInt = Int(age) {
                    cat.age = ageInt
                }
            }
            
        } else if currentQuestionIndex == 2{
            let weightString = "\(weight) \(weightUnit)"
            messages.append(ChatMessage(text: weightString, isMe: true))
            
            if let weightInt = Int(weight) {
                cat.weight = weightInt
            }
        }
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else{
            showAlert = true
            return
        }
        
        
        
        // Simulate system response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            messages.append(ChatMessage(text: questions[currentQuestionIndex], isMe: false))
        }
        
    }
        
}

struct ChatBubble: Shape {
    var isFromMe: Bool
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let cornerRadius: CGFloat = 10
        
        let path = Path { p in
            if isFromMe {
                p.move(to: CGPoint(x: 25, y: height))
                p.addLine(to: CGPoint(x:  20, y: height))
                p.addCurve(to: CGPoint(x: 0, y: height - 20),
                           control1: CGPoint(x: 8, y: height),
                           control2: CGPoint(x: 0, y: height - 8))
                p.addLine(to: CGPoint(x: 0, y: 20))
                p.addCurve(to: CGPoint(x: 20, y: 0),
                           control1: CGPoint(x: 0, y: 8),
                           control2: CGPoint(x: 8, y: 0))
                p.addLine(to: CGPoint(x: width - 21, y: 0))
                p.addCurve(to: CGPoint(x: width - 4, y: 20),
                           control1: CGPoint(x: width - 12, y: 0),
                           control2: CGPoint(x: width - 4, y: 8))
                p.addLine(to: CGPoint(x: width - 4, y: height - 11))
                p.addCurve(to: CGPoint(x: width, y: height),
                           control1: CGPoint(x: width - 4, y: height - 1),
                           control2: CGPoint(x: width, y: height))
                p.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
                p.addCurve(to: CGPoint(x: width - 11, y: height - 4),
                           control1: CGPoint(x: width - 4, y: height + 0.5),
                           control2: CGPoint(x: width - 8, y: height - 1))
                p.addCurve(to: CGPoint(x: width - 25, y: height),
                           control1: CGPoint(x: width - 16, y: height),
                           control2: CGPoint(x: width - 20, y: height))
                
                
                
            } else {
                p.move(to: CGPoint(x: width - 25, y: height))
                p.addLine(to: CGPoint(x: width - 20, y: height))
                p.addCurve(to: CGPoint(x: width, y: height - 20),
                           control1: CGPoint(x: width - 8, y: height),
                           control2: CGPoint(x: width, y: height - 8))
                p.addLine(to: CGPoint(x: width, y: 20))
                p.addCurve(to: CGPoint(x: width - 20, y: 0),
                           control1: CGPoint(x: width, y: 8),
                           control2: CGPoint(x: width - 8, y: 0))
                p.addLine(to: CGPoint(x: 21, y: 0))
                p.addCurve(to: CGPoint(x: 4, y: 20),
                           control1: CGPoint(x: 12, y: 0),
                           control2: CGPoint(x: 4, y: 8))
                p.addLine(to: CGPoint(x: 4, y: height - 11))
                p.addCurve(to: CGPoint(x: 0, y: height),
                           control1: CGPoint(x: 4, y: height - 1),
                           control2: CGPoint(x: 0, y: height))
                p.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
                p.addCurve(to: CGPoint(x: 11.0, y: height - 4.0),
                           control1: CGPoint(x: 4.0, y: height + 0.5),
                           control2: CGPoint(x: 8, y: height - 1))
                p.addCurve(to: CGPoint(x: 25, y: height),
                           control1: CGPoint(x: 16, y: height),
                           control2: CGPoint(x: 20, y: height))
                
            }
        }
        return path
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

#Preview {
    ContentView()
}
