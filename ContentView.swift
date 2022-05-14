//
//  ContentView.swift
//  iExpense
//
//  Created by Maxime on 09/05/2022.
//

import SwiftUI


struct ContentView: View {
    @StateObject var expenses = Expense()
    @State private var showingAddExpense = false
    private var sections = ["Personal", "Business"]
    var body: some View {
        NavigationView {
            List {
                ForEach(sections, id:\.self) { section in
                    Section(header: Text(section)) {
                        ForEach(expenses.items.filter{$0.type == section}) { item in
                            HStack {
                                VStack {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                    .foregroundColor(getColor(amount: item.amount))
                            }
                        }
                        .onDelete(perform: removeItem)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                HStack {
                    EditButton()
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func getColor(amount: Double) -> Color {
        if amount <= 10 {
            return Color.green
        } else if amount <= 100 {
            return Color.orange
        } else {
            return Color.red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
