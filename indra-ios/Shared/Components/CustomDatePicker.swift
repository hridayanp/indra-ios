///
///  CustomDatePicker.swift
///  indra-ios
///
///  Created by Hridayan Phukan on 08/02/25.
///

import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDate: String
    
    private let years = Array(1900...2100)
    private let months = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]
    
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonthIndex: Int = Calendar.current.component(.month, from: Date()) - 1
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())
    
    @State private var activePicker: PickerType? = nil
    @State private var showBottomSheet: Bool = false
    
    enum PickerType: Identifiable {  // Make it Identifiable to force updates
        case day, month, year
        var id: Int { hashValue }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                // Day Picker
                Text("\(selectedDay)")
                    .font(.system(size: 16, weight: .medium))
                    .frame(maxWidth: 60, maxHeight: 25)
                    .padding(8) // Ensures space inside the border
                    .overlay(
                        RoundedRectangle(cornerRadius: 6) // Rounded edges for a modern look
                            .stroke(Color.white.opacity(0.7), lineWidth: 1) // 1px border with slight transparency
                    )
                    .onTapGesture {
                        activatePicker(.day)
                    }
                
                // Month Picker (Center)
                Text(months[selectedMonthIndex])
                    .font(.system(size: 16, weight: .medium))
                    .frame(maxWidth: .infinity, maxHeight: 25)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6) // Rounded edges for a modern look
                            .stroke(Color.white.opacity(0.7), lineWidth: 1) // 1px border with slight transparency
                    )
                    .onTapGesture {
                        activatePicker(.month)
                    }
                
                // Year Picker
                Text("\(selectedYear, format: .number.grouping(.never))")
                    .font(.system(size: 16, weight: .medium))
                    .frame(maxWidth: 60, maxHeight: 25)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6) // Rounded edges for a modern look
                            .stroke(Color.white.opacity(0.7), lineWidth: 1) // 1px border with slight transparency
                    )
                    .onTapGesture {
                        activatePicker(.year)
                    }
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(.top, 0)
            .padding(.horizontal)
            .background(Color.clear)
        }
        .sheet(item: $activePicker) { picker in // ✅ Use item-based sheet to refresh
            BottomSheetPickerView(pickerType: picker)
                .presentationDetents([.height(150)])
        }
    }
    
    // MARK: - Activate Picker & Open Bottom Sheet
    private func activatePicker(_ picker: PickerType) {
        activePicker = picker // ✅ Set the picker first
    }
    
    // MARK: - Picker Bottom Sheet View
    @ViewBuilder
    private func BottomSheetPickerView(pickerType: PickerType) -> some View {
        ZStack {
            GlassmorphicBackground()
                .padding(.horizontal, 16)
            
            VStack(spacing: 0) {
                // Header
                //            HStack {
                //                Spacer()
                //                Button("Done") {
                //                    activePicker = nil // ✅ Close sheet properly
                //                }
                //                .foregroundColor(.blue)
                //                .padding()
                //            }
                //            .background(Color.white)
                
                // Picker
                Picker("", selection: bindingFor(pickerType)) {
                    switch pickerType {
                    case .day:
                        ForEach(1...getDaysInMonth(), id: \.self) { day in
                            Text("\(day)").tag(day)
                        }
                    case .month:
                        ForEach(months.indices, id: \.self) { index in
                            Text(months[index]).tag(index)
                        }
                    case .year:
                        ForEach(years, id: \.self) { year in
                            Text("\(year, format: .number.grouping(.never))")
                                .tag(year)
                        }
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 200)
                .background(Color.white)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(16)
        }
    }
    
    // MARK: - Get the Correct Binding for Each Picker
    private func bindingFor(_ pickerType: PickerType) -> Binding<Int> {
        switch pickerType {
        case .day:
            return Binding(
                get: { self.selectedDay },
                set: { newValue in
                    self.selectedDay = newValue
                    updateSelectedDate()
                }
            )
        case .month:
            return Binding(
                get: { self.selectedMonthIndex },
                set: { newIndex in
                    self.selectedMonthIndex = newIndex
                    updateSelectedDate()
                }
            )
        case .year:
            return Binding(
                get: { self.selectedYear },
                set: { newValue in
                    self.selectedYear = newValue
                    updateSelectedDate()
                }
            )
        }
    }
    
    // MARK: - Update Selected Date
    private func updateSelectedDate() {
        let monthIndex = selectedMonthIndex + 1
        selectedDate = String(format: "%04d-%02d-%02d", selectedYear, monthIndex, selectedDay)
    }
    
    // MARK: - Get the Number of Days in the Selected Month
    private func getDaysInMonth() -> Int {
        let dateComponents = DateComponents(year: selectedYear, month: selectedMonthIndex + 1)
        let calendar = Calendar.current
        return calendar.range(of: .day, in: .month, for: calendar.date(from: dateComponents)!)?.count ?? 30
    }
}

#Preview {
    @Previewable @State var date = ""
    return BaseView{CustomDatePicker(selectedDate: $date)}
}
