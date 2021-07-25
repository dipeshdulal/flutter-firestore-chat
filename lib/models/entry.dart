class Entry {
  String room_id = "";
  String username = "";

  bool isValid() {
    return room_id != "" && username != "";
  }
}
