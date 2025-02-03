import SwiftUI

struct NewsView: View {
    @StateObject var viewModel = MenuViewModel()
    @Binding var isInDetailView: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.newsItems) { item in
                        NavigationLink(destination: NewsDetailView(newsItem: item, isInDetailView: $isInDetailView)) {
                            VStack(alignment: .leading)  {
                                HStack(alignment: .top) { // Ensure proper alignment
                                    // Left section: Main content
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.title)
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.leading)
                                        
                                        HStack {
                                            Text(item.date)
                                                .font(.caption)
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.leading)
                                            Text("•")
                                                .foregroundColor(.white)
                                            Text(item.author)
                                                .font(.caption)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading) // Ensure it uses full width and aligns left
                                    
                                    // Right section: Image
                                    AsyncImage(url: URL(string: item.imageUrl)) { image in
                                        image.resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                .padding()
                                .background(Color(hex: "#0B1D29")) // Card background
                                .cornerRadius(8)
                            }
                        }
                        Divider()
                            .frame(height: 2)
                            .background(Color(hex: "#d8d8d8"))
                    }
                }
                .padding()
            }
            .background(Color(hex: "#0B1D29")) // Ensure entire scroll area has the background
            .ignoresSafeArea()
            .onAppear {
                viewModel.loadNewsData() // Load news when the view appears
            }
            .toolbarBackground(Color(hex: "#0B1D29"), for: .navigationBar)
        }
        .background(Color(hex: "#0B1D29")) // NavigationStack background
    }
}

// MARK: - NewsDetailView
struct NewsDetailView: View {
    var newsItem: NewsItem
    @Environment(\.dismiss) private var dismiss
    @Binding var isInDetailView: Bool
    
    var body: some View {
        VStack {
            // Banner image
            AsyncImage(url: URL(string: newsItem.imageUrl)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .padding(.top, 20)
            } placeholder: {
                ProgressView()
            }
            
            // Title
            Text(newsItem.title)
                .font(.title)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            // Scrollable Content
            ScrollView {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Nulla vitae massa. Donec eleifend risus nec augue. Donec aliquet. Vivamus tellus. In ut quam vitae odio lacinia tincidunt. Integer nisi libero, tincidunt at fermentum ut, scelerisque in neque.")
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#0B1D29")) // Full-screen background color
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .toolbarBackground(Color(hex: "#0B1D29"), for: .navigationBar) // Toolbar background
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss() // Dismiss the view
                }) {
                    Image(systemName: "arrow.left.circle.fill") // Left arrow icon
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white) // Icon color
                }
            }
        }
        .onAppear {
            isInDetailView = true // Hide toolbar from MenuView
        }
        .onDisappear {
            isInDetailView = false // Show toolbar again when exiting NewsDetailView
        }
    }
}

//#Preview {
//    NewsView(isInDetailView: .constant(false))
//}
