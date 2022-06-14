//
//  practice.swift
//  CoreDataPractice
//
//  Created by Jannatun Nahar Papia on 14/6/22.
//

//import SwiftUI
//
//struct TextFieldClearButton: ViewModifier {
//    @Binding var fieldText: String
//
//    func body(content: Content) -> some View {
//        content
//            .overlay {
//                if !fieldText.isEmpty {
//                    HStack {
//                        Spacer()
//                        Button {
//                            fieldText = ""
//                        } label: {
//                            Image(systemName: "multiply.circle.fill")
//                        }
//                        .foregroundColor(.secondary)
//                        .padding(.trailing, 4)
//                    }
//                }
//            }
//    }
//}
//
//extension View {
//    func showClearButton(_ text: Binding<String>) -> some View {
//        self.modifier(TextFieldClearButton(fieldText: text))
//    }
//}
//
//
////struct TextFieldClearButton_Previews: PreviewProvider {
////    static var previews: some View {
////        TextFieldClearButton(fieldText: text)
////    }
////}
//
//struct TextFieldButton: View {
//
//    @State private var text = ""
//    @FocusState private var isTextFieldFocused: Bool
//
//    var body: some View {
//        VStack {
//            TextField("", text: $text)
//                .textFieldStyle(.roundedBorder)
//                .focused($isTextFieldFocused)
//                .showClearButton($text)
//        }
//        .padding()
//        .background(Color.purple)
//    }
//}
//
////struct TextFieldClearButton_Previews: PreviewProvider {
////    static var previews: some View {
////        TextFieldClearButton(fieldText: text)
////    }
////}
