import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hotel_details_page.dart';

const d_green = Color(0xFF54D3C2);

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  final List<Map<String, dynamic>> favoriteHotels = const [
    {
      'title': 'Grand Royal Hotel',
      'place': 'Wevley, London',
      'distance': 2,
      'review': 36,
      'picture': 'assets/images/img1.jpg',
      'price': '180',
    },
    {
      'title': 'Hilton',
      'place': 'Wevley, London',
      'distance': 11,
      'review': 34,
      'picture': 'assets/images/img4.jpg',
      'price': '910',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: favoriteHotels.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              itemCount: favoriteHotels.length,
              itemBuilder: (context, index) {
                return _buildFavoriteCard(context, favoriteHotels[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[300],
          ),
          SizedBox(height: 20),
          Text(
            'No Favorites Yet',
            style: GoogleFonts.nunito(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Start exploring and save your favorite hotels',
            style: GoogleFonts.nunito(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, Map hotelData) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailsPage(hotelData: hotelData),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                hotelData['picture'],
                width: isMobile ? 120 : 150,
                height: isMobile ? 120 : 150,
                fit: BoxFit.cover,
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 12 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotelData['title'],
                      style: GoogleFonts.nunito(
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.place, color: d_green, size: 16),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            hotelData['place'],
                            style: GoogleFonts.nunito(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '4.5',
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(${hotelData['review']} reviews)',
                          style: GoogleFonts.nunito(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$${hotelData['price']}/night',
                      style: GoogleFonts.nunito(
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: d_green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Delete button
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red[300]),
              onPressed: () {
                // Remove from favorites
              },
            ),
          ],
        ),
      ),
    );
  }
}
