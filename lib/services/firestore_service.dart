
import 'package:chat_application/models/homework_detail.dart';
import 'package:chat_application/models/lesson_detail.dart';
import 'package:chat_application/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  AuthService authService = AuthService();

  Future<void> addLessonScreen(String lessonType, String lessonDetail, String lessonImage, String dateCreated, String studentUsername, String teacherUsername) async {
    final trimmedLessonType = lessonType.trim();
    final trimmedLessonDetail = lessonDetail.trim();
    final trimmedStudentUsername = studentUsername.trim();
    final trimmedTeacherUsername = teacherUsername.trim();
    if (trimmedLessonType.isEmpty) throw ArgumentError('lessonType cannot be empty');
    if (trimmedLessonDetail.isEmpty) throw ArgumentError('lessonDetail cannot be empty');
    if (trimmedStudentUsername.isEmpty) throw ArgumentError('studentUsername cannot be empty');
    if (trimmedTeacherUsername.isEmpty) throw ArgumentError('teacherUsername cannot be empty');
    await FirebaseFirestore.instance.collection('LessonDetail').add({
      'teacherUsername': trimmedTeacherUsername,
      'lessonType': trimmedLessonType,
      'LessonDetail': trimmedLessonDetail,
      'lessonImage': lessonImage,
      'dateCreated': dateCreated,
      'studentUsername': trimmedStudentUsername,
    });
  }

  Stream<List<LessonDetail>> getTeacherLessonDetail(String teacherUsername) {
    return FirebaseFirestore.instance
        .collection('LessonDetail')
        .orderBy("dateCreated", descending: true)
        .where('teacherUsername', isEqualTo: teacherUsername)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<LessonDetail>((doc) => LessonDetail.fromMap(doc.data(), doc.id))
            .toList());
  }

  Stream<List<LessonDetail>> getStudentLessonDetail(String studentUsername) {
    return FirebaseFirestore.instance
        .collection('LessonDetail')
        .orderBy("dateCreated", descending: true)
        .where('studentUsername', isEqualTo: studentUsername)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<LessonDetail>((doc) => LessonDetail.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> removeLesson(String id) async {
    await FirebaseFirestore.instance.collection('LessonDetail').doc(id).delete();
  }

  Future<void> editLesson(String id, String dateCreated, String lessonType, String studentUsername, String lessonImage, String lessonDetail, String teacherUsername) async {
    final trimmedLessonType = lessonType.trim();
    final trimmedLessonDetail = lessonDetail.trim();
    final trimmedStudentUsername = studentUsername.trim();
    final trimmedTeacherUsername = teacherUsername.trim();
    if (trimmedLessonType.isEmpty) throw ArgumentError('lessonType cannot be empty');
    if (trimmedLessonDetail.isEmpty) throw ArgumentError('lessonDetail cannot be empty');
    if (trimmedStudentUsername.isEmpty) throw ArgumentError('studentUsername cannot be empty');
    if (trimmedTeacherUsername.isEmpty) throw ArgumentError('teacherUsername cannot be empty');
    await FirebaseFirestore.instance.collection('LessonDetail').doc(id).set({
      'teacherUsername': trimmedTeacherUsername,
      'lessonType': trimmedLessonType,
      'LessonDetail': trimmedLessonDetail,
      'lessonImage': lessonImage,
      'dateCreated': dateCreated,
      'studentUsername': trimmedStudentUsername,
    });
  }

  Stream<List<HomeworkDetail>> getTeacherHomeworkDetail(String teacherUsername) {
    return FirebaseFirestore.instance
        .collection('HomeworkDetail')
        .where('teacherUsername', isEqualTo: teacherUsername)
        .orderBy('dueDate')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<HomeworkDetail>((doc) => HomeworkDetail.fromMap(doc.data(), doc.id))
            .toList());
  }

  Stream<List<HomeworkDetail>> getStudentHomeworkDetail(String studentUsername) {
    return FirebaseFirestore.instance
        .collection('HomeworkDetail')
        .where('studentUsername', isEqualTo: studentUsername)
        .orderBy('dueDate')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<HomeworkDetail>((doc) => HomeworkDetail.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addHomeworkScreen(String homeworkDetail, String studentUsername, dynamic datePicked, String teacherUsername) async {
    final trimmedHomeworkDetail = homeworkDetail.trim();
    final trimmedStudentUsername = studentUsername.trim();
    final trimmedTeacherUsername = teacherUsername.trim();
    if (trimmedHomeworkDetail.isEmpty) throw ArgumentError('homeworkDetail cannot be empty');
    if (trimmedStudentUsername.isEmpty) throw ArgumentError('studentUsername cannot be empty');
    if (trimmedTeacherUsername.isEmpty) throw ArgumentError('teacherUsername cannot be empty');
    await FirebaseFirestore.instance.collection('HomeworkDetail').add({
      'teacherUsername': trimmedTeacherUsername,
      'HomeworkDetail': trimmedHomeworkDetail,
      'dueDate': datePicked,
      'studentUsername': trimmedStudentUsername,
      'isDone': false,
    });
  }

  Future<void> removeHomework(String id) async {
    await FirebaseFirestore.instance.collection('HomeworkDetail').doc(id).delete();
  }

  Future<void> changeToDone(String id, bool isDone) async {
    await FirebaseFirestore.instance.collection('HomeworkDetail').doc(id).update({
      'isDone': !isDone,
    });
  }

  Future<void> editHomework(String id, String homeworkDetail, String studentUsername, dynamic datePicked) async {
    await FirebaseFirestore.instance.collection('HomeworkDetail').doc(id).update({
      'HomeworkDetail': homeworkDetail,
      'dueDate': datePicked,
      'studentUsername': studentUsername,
    });
  }

  Future<bool> checkUsernameUnique(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }

  Future<bool> checkEmailUnique(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isEmpty;
  }
}
