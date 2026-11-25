import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/models/project.dart';

void main() {
  test(
    'DRF project JSON round-trips with snake_case and no server ID in POST',
    () {
      const response = '''
      {
        "id":"d885f64e-3049-4fec-8b6d-d7a7922af244",
        "title":"Aplikasi Portofolio",
        "description":"Proyek dengan data Django",
        "tech_stack":"Django, Flutter",
        "project_url":"https://example.com/portfolio",
        "project_image_url":"https://example.com/portfolio.png",
        "star_count":2,
        "is_starred":false
      }
    ''';
      final project = Project.fromJson(
        jsonDecode(response) as Map<String, dynamic>,
      );
      expect(project.id, 'd885f64e-3049-4fec-8b6d-d7a7922af244');
      expect(project.techStack, 'Django, Flutter');
      expect(project.projectImageUrl, 'https://example.com/portfolio.png');

      expect(project.toJson(), {
        'title': 'Aplikasi Portofolio',
        'description': 'Proyek dengan data Django',
        'tech_stack': 'Django, Flutter',
        'project_url': 'https://example.com/portfolio',
        'project_image_url': 'https://example.com/portfolio.png',
      });
    },
  );

  test('missing and null URL values deserialize as empty strings', () {
    const data = {
      'title': 'Legacy project',
      'description': 'Before URLs were added',
      'tech_stack': 'Django',
    };
    for (final json in [
      data,
      {...data, 'project_url': null, 'project_image_url': null},
    ]) {
      final project = Project.fromJson(json);
      expect(project.id, isNull);
      expect(project.projectUrl, isEmpty);
      expect(project.projectImageUrl, isEmpty);
    }
  });
}
