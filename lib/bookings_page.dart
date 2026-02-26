import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const d_green = Color(0xFF54D3C2);

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  final List<Map<String, dynamic>> upcomingBookings = const [
    {
      'title': 'Grand Royal Hotel',
      'place': 'Wevley, London',
      'picture': 'assets/images/img1.jpg',
      'checkIn': 'Dec 12, 2024',
      'checkOut': 'Dec 22, 2024',
      'price': '1800',
      'status': 'Confirmed',
      'nights': 10,
    },
  ];

  final List<Map<String, dynamic>> pastBookings = const [
    {
      'title': 'Hotel Ibis',
      'place': 'Wevley, London',
      'picture': 'assets/images/img2.jpg',
      'checkIn': 'Nov 01, 2024',
      'checkOut': 'Nov 05, 2024',
      'price': '880',
      'status': 'Completed',
      'nights': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Trips',
            style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottom: TabBar(
            indicatorColor: d_green,
            labelColor: d_green,
            unselectedLabelColor: Colors.grey,
            labelStyle: GoogleFonts.nunito(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBookingsList(context, upcomingBookings, true),
            _buildBookingsList(context, pastBookings, false),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsList(
    BuildContext context,
    List<Map<String, dynamic>> bookings,
    bool isUpcoming,
  ) {
    if (bookings.isEmpty) {
      return _buildEmptyState(isUpcoming);
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(context, bookings[index], isUpcoming);
      },
    );
  }

  Widget _buildEmptyState(bool isUpcoming) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isUpcoming ? Icons.calendar_today : Icons.history,
            size: 80,
            color: Colors.grey[300],
          ),
          SizedBox(height: 20),
          Text(
            isUpcoming ? 'No Upcoming Trips' : 'No Past Trips',
            style: GoogleFonts.nunito(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10),
          Text(
            isUpcoming
                ? 'Start booking your dream vacation!'
                : 'Your travel history will appear here',
            style: GoogleFonts.nunito(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, Map booking, bool isUpcoming) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
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
      child: Column(
        children: [
          // Header with status
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isUpcoming ? d_green.withOpacity(0.1) : Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isUpcoming ? Icons.check_circle : Icons.done_all,
                      color: isUpcoming ? d_green : Colors.grey,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      booking['status'],
                      style: GoogleFonts.nunito(
                        color: isUpcoming ? d_green : Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (isUpcoming)
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.nunito(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    booking['picture'],
                    width: isMobile ? 80 : 100,
                    height: isMobile ? 80 : 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['title'],
                        style: GoogleFonts.nunito(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        booking['place'],
                        style: GoogleFonts.nunito(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          _buildDateChip(
                            Icons.login,
                            booking['checkIn'],
                            'Check-in',
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.grey,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          _buildDateChip(
                            Icons.logout,
                            booking['checkOut'],
                            'Check-out',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Footer with price
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${booking['nights']} nights',
                  style: GoogleFonts.nunito(color: Colors.grey[600]),
                ),
                Text(
                  '\$${booking['price']}',
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: d_green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip(IconData icon, String date, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: d_green),
            SizedBox(width: 4),
            Text(
              date,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: GoogleFonts.nunito(color: Colors.grey[500], fontSize: 10),
        ),
      ],
    );
  }
}
