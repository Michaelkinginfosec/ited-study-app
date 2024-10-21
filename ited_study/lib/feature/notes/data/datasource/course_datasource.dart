import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/model/courses.dart';

abstract class CourseDatasource {
  Future<String> getCourses();
}

class CourseDatasourceImp implements CourseDatasource {
  final Dio dio;
  CourseDatasourceImp(this.dio);

  @override
  Future<String> getCourses() async {
    try {
      final response = await dio.get(
        '/notes',
      );
      if (response.statusCode == 200) {
        List<Courses> courses = (response.data as List)
            .map(
              (json) => Courses.fromJson(
                json as Map<String, dynamic>,
              ),
            )
            .toList();
        print(courses.length);
        print(courses[1].courseName);

        await storeCourses(courses);

        return 'Courses fetched successfully';
      } else {
        throw Exception('Failed to load courses');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404 || e.response!.statusCode == 400) {
          throw Exception('No courses available');
        } else {
          throw Exception('Failed with status code: ${e.response!.statusCode}');
        }
      } else {
        throw Exception('Network or server error: ${e.message}');
      }
    } catch (e) {
      throw SignUpException("Unexpected Error occurred $e ");
    }
  }

  Future<void> storeCourses(List<Courses> courses) async {
    final box = await Hive.openBox<Courses>('courses');
    for (var course in courses) {
      await box.put(course.id, course);
    }
    await getCourse();
  }

  Future<void> getCourse() async {
    final box = await Hive.openBox<Courses>('courses');
    final courses = box.values.toList();
    print(courses.length);
    print(courses);
  }
}
