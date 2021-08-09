class Migration {
  final int version;
  final String? script;
  final bool isBreakingChange;

  Migration({
    required this.version,
    this.script,
    this.isBreakingChange = false,
  }) {
    assert(isBreakingChange != (script != null));
  }
}
