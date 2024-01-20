import 'package:exam_list/responseModels/exam/exam_data.dart';
import 'package:exam_list/utils/extras_utils.dart';

num getTotalCategoryPosts(num categoryId, num gender, ExamData exam) {
  num categoryPosts = 0;
  var genderType = gender == 1 ? 1 : 2;

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

  // get posts of parent exams if it's filtered
  if (exam.filtered == true) {
    exam.categoryPosts?.forEach((element) {
      if (element.categoryIds?.contains(categoryId) == true &&
          element.gender?.contains(genderType) == true) {
        categoryPosts += (element.posts ?? 0);
      }
    });
  }

  return categoryPosts;
}

num getTotalPosts(ExamData exam) {
  num posts = 0;

  if (exam.childExams.isNotEmpty) {
    for (var childExam in exam.childExams) {
      childExam.categoryPosts?.forEach((element) {
        posts += (childExam.totalPosts ?? 0);
      });
    }
  }

  // get posts of parent exams if it's filtered
  if (exam.filtered == true) {
    posts += (exam.totalPosts ?? 0);
  }

  return posts;
}

String getExamFees(num categoryId, num gender, ExamData exam) {
  String? examFees;
  var genderType = gender == 1 ? 1 : 2;
  // TODO : make set for fees and eliminate 0 from fees
  if (exam.childExams.isNotEmpty) {
    for (var childExam in exam.childExams) {
      childExam.categoryFees?.forEach((element) {
        if (element.categoryIds?.contains(categoryId) == true &&
            element.gender?.contains(genderType) == true) {
          if (examFees == null) {
            examFees = "₹ ${element.fee ?? 0}";
          } else {
            examFees = "${examFees!}/${element.fee ?? 0}";
          }
        }
      });
    }

    exam.categoryFees?.forEach((element) {
      if (element.categoryIds?.contains(categoryId) == true &&
          element.gender?.contains(genderType) == true) {
        examFees = "${examFees == null ? '₹ ' : '$examFees/'}${element.fee ?? 0}";
      }
    });
  }

  return examFees != null ? examFees! : "₹ 0";
}

// fetch all notices whether exist or not
List<Extras> getNotices(ExamData exam) {
  List<Extras> notices = [];

  if (exam.childExams.isNotEmpty) {
    for (var childExam in exam.childExams) {
      notices.addAll(childExam.notices ?? []);
    }
  }

  notices.addAll(exam.notices ?? []);

  return notices;
}

// fetch all notices whether exist or not
List<String> fetchAllExamIds(ExamData exam) {
  List<String> examIds = [];

  if (exam.childExams.isNotEmpty) {
    for (var childExam in exam.childExams) {
      examIds.add(childExam.id ?? '');
    }
  }

  examIds.add(exam.id ?? '');

  return examIds;
}
