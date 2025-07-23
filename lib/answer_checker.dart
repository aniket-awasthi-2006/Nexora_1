import 'package:string_similarity/string_similarity.dart';

double checkSimilarity(String answer, String user) {
  // Preprocess
  answer = answer.toLowerCase().trim();
  user = user.toLowerCase().trim();

  // Step 1: Basic similarity score
  double score = StringSimilarity.compareTwoStrings(answer, user);

  // Step 2: Additional logic like keyword match
  List<String> keywords = answer.split(" ");
  int matched = keywords.where((word) => user.contains(word)).length;

  double keywordScore = matched / keywords.length;

  // Final score as blend
  return (score + keywordScore) / 2 * 100;
}
