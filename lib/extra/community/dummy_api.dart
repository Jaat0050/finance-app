// class Post {
//   final String agentName;
//   final String agentProfile;
//   final String postDate;
//   final String postImage;
//   final String postText;
//   final Map<String, int> stats;
//   final List<Comment> comments;

//   Post({
//     required this.agentName,
//     required this.agentProfile,
//     required this.postDate,
//     required this.postImage,
//     required this.postText,
//     required this.stats,
//     required this.comments,
//   });
// }

// class Comment {
//   final String commentorName;
//   final String commentorImage;
//   final String commentDate;
//   final bool commentedBefore;
//   final String commentText;

//   Comment({
//     required this.commentorName,
//     required this.commentorImage,
//     required this.commentDate,
//     required this.commentedBefore,
//     required this.commentText,
//   });
// }

// List<Post> postsData = [
//   Post(
//     agentName: "Rahul Sharma",
//     agentProfile:
//         "https://img.freepik.com/free-photo/close-up-portrait-young-man-isolated-black-studio-wall_155003-29362.jpg?size=626&ext=jpg&ga=GA1.1.1387841729.1707903743&semt=ais",
//     postDate: "Feb 5",
//     postImage:
//         "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
//     postText:
//         "What are the specific steps involved in processing a Personal loan application?",
//     stats: {"likes": 10, "comments": 5, "forwards": 3},
//     comments: [
//       Comment(
//         commentorName: "John Doe",
//         commentorImage:
//             "https://img.freepik.com/free-photo/businessman-dress-code-wearing-grey-jacket-posing_114579-15944.jpg?size=626&ext=jpg",
//         commentDate: "Feb 6",
//         commentedBefore: true,
//         commentText: "Great question!",
//       ),
//     ],
//   ),
//   Post(
//     agentName: "John Doe",
//     agentProfile:
//         "https://img.freepik.com/free-photo/portrait-young-indian-top-manager-t-shirt-tie-crossed-arms-smiling-white-isolated-wall_496169-1513.jpg?size=626&ext=jpg&ga=GA1.1.1387841729.1707903743&semt=ais",
//     postDate: "Feb 10",
//     postImage:
//         "https://img.freepik.com/free-photo/young-adult-enjoying-virtual-date_23-2149328221.jpg?size=626&ext=jpg",
//     postText: "Excited for the weekend getaway! 🌴☀️",
//     stats: {"likes": 15, "comments": 8, "forwards": 5},
//     comments: [
//       Comment(
//         commentorName: "Alice Johnson",
//         commentorImage:
//             "https://img.freepik.com/free-photo/portrait-young-indian-top-manager-t-shirt-tie-crossed-arms-smiling-white-isolated-wall_496169-1513.jpg?size=626&ext=jpg&ga=GA1.1.1387841729.1707903743&semt=ais",
//         commentDate: "Feb 11",
//         commentedBefore: true,
//         commentText: "Where are you going? Looks amazing!",
//       ),
//       Comment(
//         commentorName: "Emily White",
//         commentorImage:
//             "https://img.freepik.com/free-photo/beautiful-male-half-length-portrait-isolated-white-studio-background-young-emotional-hindu-man-blue-shirt-facial-expression-human-emotions-advertising-concept-standing-smiling_155003-25250.jpg?size=626&ext=jpg&ga=GA1.1.1387841729.1707903743&semt=ais",
//         commentDate: "Feb 12",
//         commentedBefore: false,
//         commentText: "Wishing you a fantastic time! 🌟",
//       ),
//     ],
//   ),
//   Post(
//     agentName: "Alice Johnson",
//     agentProfile:
//         "https://img.freepik.com/free-photo/beautiful-male-half-length-portrait-isolated-white-studio-background-young-emotional-hindu-man-blue-shirt-facial-expression-human-emotions-advertising-concept-standing-smiling_155003-25250.jpg?size=626&ext=jpg&ga=GA1.1.1387841729.1707903743&semt=ais",
//     postDate: "Feb 15",
//     postImage:
//         "https://img.freepik.com/free-photo/businessman-dress-code-wearing-grey-jacket-posing_114579-15944.jpg?size=626&ext=jpg",
//     postText: "Nature vibes 🌿 #NaturePhotography",
//     stats: {"likes": 20, "comments": 12, "forwards": 7},
//     comments: [
//       Comment(
//         commentorName: "Michael Smith",
//         commentorImage:
//             "https://img.freepik.com/free-photo/businessman-dress-code-wearing-grey-jacket-posing_114579-15944.jpg?size=626&ext=jpg",
//         commentDate: "Feb 16",
//         commentedBefore: true,
//         commentText: "Love the connection with nature!",
//       ),
//       Comment(
//         commentorName: "Emily White",
//         commentorImage:
//             "https://img.freepik.com/free-photo/businessman-dress-code-wearing-grey-jacket-posing_114579-15944.jpg?size=626&ext=jpg",
//         commentDate: "Feb 17",
//         commentedBefore: false,
//         commentText: "These photos are breathtaking! 😍",
//       ),
//     ],
//   ),
//   Post(
//     agentName: "Michael Smith",
//     agentProfile:
//         "https://img.freepik.com/free-photo/cheerful-indian-businessman-smiling-closeup-portrait-jobs-career-campaign_53876-129416.jpg?size=626&ext=jpg&ga=GA1.1.1387841729.1707903743&semt=ais",
//     postDate: "Feb 20",
//     postImage:
//         "https://img.freepik.com/free-photo/close-up-portrait-young-man-isolated-black-studio-background-photoshot-real-emotions-male-model-smiling-feeling-happy-facial-expression-pure-clear-human-emotions-concept_155003-25751.jpg?size=626&ext=jpg",
//     postText: "Coding all night long! 💻 #ProgrammingLife",
//     stats: {"likes": 25, "comments": 15, "forwards": 10},
//     comments: [
//       Comment(
//         commentorName: "Rahul Sharma",
//         commentorImage:
//             "https://img.freepik.com/free-photo/businessman-dress-code-wearing-grey-jacket-posing_114579-15944.jpg?size=626&ext=jpg",
//         commentDate: "Feb 21",
//         commentedBefore: true,
//         commentText: "Impressive dedication! 💪",
//       ),
//       Comment(
//         commentorName: "John Doe",
//         commentorImage:
//             "https://img.freepik.com/free-photo/beautiful-male-half-length-portrait-isolated-white-studio-background-young-emotional-hindu-man-blue-shirt-facial-expression-human-emotions-advertising-concept-standing-smiling_155003-25250.jpg?size=626&ext=jpg&ga=GA1.1.1387841729.1707903743&semt=ais",
//         commentDate: "Feb 22",
//         commentedBefore: false,
//         commentText: "Keep up the hard work! 👏",
//       ),
//     ],
//   ),
//   Post(
//     agentName: "Emily White",
//     agentProfile:
//         "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
//     postDate: "Feb 25",
//     postImage:
//         "https://img.freepik.com/free-photo/smiling-businessman-face-portrait-wearing-suit_53876-148138.jpg?size=626&ext=jpg",
//     postText: "Feeling blessed and grateful. 🙏❤️",
//     stats: {"likes": 30, "comments": 20, "forwards": 12},
//     comments: [
//       Comment(
//         commentorName: "Alice Johnson",
//         commentorImage:
//             "https://img.freepik.com/free-photo/cheerful-indian-businessman-smiling-closeup-portrait-jobs-career-campaign_53876-129416.jpg?size=626&ext=jpg&ga=GA1.1.1387841729.1707903743&semt=ais",
//         commentDate: "Feb 26",
//         commentedBefore: true,
//         commentText: "Gratitude is the best attitude! 😊",
//       ),
//       Comment(
//         commentorName: "Rahul Sharma",
//         commentorImage:
//             "https://img.freepik.com/free-photo/businessman-dress-code-wearing-grey-jacket-posing_114579-15944.jpg?size=626&ext=jpg",
//         commentDate: "Feb 27",
//         commentedBefore: false,
//         commentText: "You deserve all the happiness!",
//       ),
//     ],
//   ),
//   // Add more posts as needed
// ];
