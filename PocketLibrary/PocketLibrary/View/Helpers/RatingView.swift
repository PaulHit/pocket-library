import SwiftUI

// A reusable star rating view
struct RatingView: View {
    // 1. Takes a @Binding, so it can change the
    // rating value in the parent view.
    @Binding var rating: Int
    
    private let maxRating = 5
    private let onColor = Color.yellow
    private let offColor = Color.gray.opacity(0.5)
    
    var body: some View {
        HStack {
            Text("Your Rating")
            Spacer()
            
            // 2. Create 5 star buttons
            ForEach(1...maxRating, id: \.self) { number in
				Button {
					// 3. Tapping a star updates the rating
					rating = number
				} label: {
					Image(systemName: number > rating ? "star" : "star.fill")
						.font(.title2) // <-- Makes stars bigger
						.foregroundColor(number > rating ? offColor : onColor)
				}
				.buttonStyle(.plain) // <-- STOPS the row from highlighting
			}
        }
    }
}

#Preview {
    // This is how you preview a view with a @Binding
    struct PreviewWrapper: View {
        @State private var rating = 3
        var body: some View {
            RatingView(rating: $rating)
        }
    }
    return PreviewWrapper()
}
