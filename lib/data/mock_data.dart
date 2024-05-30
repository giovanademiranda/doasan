import 'notification_model.dart';
import 'post_model.dart';
import 'user_model.dart';

final User mockUser = User(
  name: 'John Doe',
  email: 'example@gmail.com',
  phone: '(15) 9 9999-9999',
  address: 'Rua: example doe 123',
  bloodType: 'A+',
  birthDate: '01/01/2000',
  weight: '65',
);

final User mockAdmin = User(
  name: 'Admin User',
  email: 'admin@email.com',
  phone: '(15) 9 9999-9999',
  address: 'Rua: admin street 456',
  bloodType: 'O+',
  birthDate: '01/01/1980',
  weight: '70',
);

List<Post> mockPosts = [
  Post(
    username: 'Admin',
    description:
        'Transfusões de sangue fazem a diferença entre a vida e a morte para centenas de pacientes todos os dias.',
    imageUrl:
        'https://mir-s3-cdn-cf.behance.net/project_modules/fs/303b7c20702805.562efbbd565ef.jpg',
  ),
  Post(
    username: 'Admin',
    description:
        'Transfusões de sangue fazem a diferença entre a vida e a morte para centenas de pacientes todos os dias.',
    imageUrl:
        'https://mir-s3-cdn-cf.behance.net/project_modules/fs/303b7c20702805.562efbbd565ef.jpg',
  ),
  Post(
    username: 'Admin',
    description:
        'Transfusões de sangue fazem a diferença entre a vida e a morte para centenas de pacientes todos os dias.',
    imageUrl:
        'https://mir-s3-cdn-cf.behance.net/project_modules/fs/303b7c20702805.562efbbd565ef.jpg',
  ),
  Post(
    username: 'Admin',
    description:
        'Transfusões de sangue fazem a diferença entre a vida e a morte para centenas de pacientes todos os dias.',
    imageUrl:
        'https://mir-s3-cdn-cf.behance.net/project_modules/fs/303b7c20702805.562efbbd565ef.jpg',
  ),
];

List<Notification> mockNotifications = [
  Notification(
    message: 'Você agendou uma doação de sangue',
    date: '25/06/2024',
    time: '07:00',
    location: 'Hemocentro de Sorocaba',
  ),
  Notification(
    message: 'Você agendou uma doação de sangue',
    date: '30/06/2024',
    time: '10:00',
    location: 'Hospital Regional',
  ),
];
