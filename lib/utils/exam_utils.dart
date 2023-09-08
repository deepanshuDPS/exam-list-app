import 'package:exam_list/responseModels/home/exam_data.dart';

num getTotalCategoryPosts(num categoryId, num gender, ExamData exam) {
  num categoryPosts = 0;
  var genderType = gender == 1 ? 1 : 2;
  // get posts of parent exams if it's filtered
  if (exam.filtered == true) {
    exam.categoryPosts?.forEach((element) {
      if (element.categoryIds?.contains(categoryId) == true &&
          element.gender?.contains(genderType) == true) {
        categoryPosts += (element.posts ?? 0);
      }
    });
  }

  if (exam.childExams.isNotEmpty) {
    for (var childExam in exam.childExams) {
      childExam.categoryPosts?.forEach((element) {
        if (element.categoryIds?.contains(categoryId) == true &&
            element.gender?.contains(genderType) == true) {
          categoryPosts += (element.posts ?? 0);
        }
      });
    }
  }

  return categoryPosts;
}

num getTotalPosts(ExamData exam) {
  num posts = 0;
  // get posts of parent exams if it's filtered
  if (exam.filtered == true) {
    posts += (exam.totalPosts ?? 0);
  }

  if (exam.childExams.isNotEmpty) {
    for (var childExam in exam.childExams) {
      childExam.categoryPosts?.forEach((element) {
        posts += (childExam.totalPosts ?? 0);
      });
    }
  }

  return posts;
}

String getExamFees(num categoryId, num gender, ExamData exam) {
  String examFees = "";
  var genderType = gender == 1 ? 1 : 2;

  // get posts of parent exams if it's filtered
  if (exam.filtered == true) {
    exam.categoryFees?.forEach((element) {
      if (element.categoryIds?.contains(categoryId) == true &&
          element.gender?.contains(genderType) == true) {
        examFees = "₹ ${element.fee ?? 0}";
      }
    });
  }

  if (exam.childExams.isNotEmpty) {
    for (var childExam in exam.childExams) {
      childExam.categoryFees?.forEach((element) {
        if (element.categoryIds?.contains(categoryId) == true &&
            element.gender?.contains(genderType) == true) {
          if (examFees.isEmpty) {
            examFees = "₹ ${element.fee ?? 0}";
          } else {
            examFees += "/${element.fee ?? 0}";
          }
        }
      });
    }
  }

  return examFees.isNotEmpty ? examFees : "₹ 0";
}
