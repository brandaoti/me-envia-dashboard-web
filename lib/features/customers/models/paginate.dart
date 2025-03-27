class Paginate {
  final int totalPage;
  final int currentPage;

  const Paginate({
    required this.totalPage,
    required this.currentPage,
  });

  Paginate copyWith({
    int? totalPage,
    int? currentPage,
  }) {
    return Paginate(
      totalPage: totalPage ?? this.totalPage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Paginate &&
        other.totalPage == totalPage &&
        other.currentPage == currentPage;
  }

  @override
  int get hashCode => totalPage.hashCode ^ currentPage.hashCode;

  @override
  String toString() =>
      'Paginate(totalPage: $totalPage, currentPage: $currentPage)';
}
