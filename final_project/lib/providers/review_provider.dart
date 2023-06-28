import 'package:final_project/controllers/review_controller.dart';
import 'package:final_project/models/review.dart';
import 'package:flutter/material.dart';

class ReviewProvider with ChangeNotifier {
  List<Review> reviews = [];
  static final ReviewProvider _reviewProvider = ReviewProvider._internal();

  factory ReviewProvider() {
    return _reviewProvider;
  }

  ReviewProvider._internal() {
    fetchReviews();
  }

  fetchReviews() async {
    var result = await ReviewController().getAll();
    reviews.addAll(result);
    notifyListeners();
    return reviews;
  }

  Future<List<Review>> fetchProductReviews(int id) async {
    List<Review> productreviews = [];
    for (var review in reviews) {
      if (review.productId == id) {
        productreviews.add(review);
      }
    }
    notifyListeners();
    return productreviews;
  }

  Future<bool> checkReviewed(int id) async {
    for (var review in reviews) {
      if (review.productId == id) return true;
    }
    return false;
  }

  addReview(Review review) async {
    dynamic jsonObj = await ReviewController().create(review).then((value) {
      reviews.add(review);
    }).onError((error, stackTrace) {
      print(error);
    });
    notifyListeners();
  }
}
