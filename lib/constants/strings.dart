const String BASE_URL = 'http://10.0.2.2:8000/menus/?format=json';
String deleteUrl(id) {
  return 'http://10.0.2.2:8000/menus/$id/delete';
}
