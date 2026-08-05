import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/article.dart';
import 'detail_page.dart';
import '../theme/royal_colors.dart';

import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late final Stream<List<Map<String, dynamic>>> _articlesStream;

  int _currentPage = 0;
  bool _isLoadingMore = false;

  final TextEditingController _searchController =
      TextEditingController();

  String? _selectedCategory;
  String? _selectedCity;

  static const List<String> categories = [
    "Art",
    "Électronique",
    "Mode",
    "Véhicules",
    "Immobilier",
  ];

  static const List<String> cities = [
    "Dakar",
    "Thiès",
    "Kaolack",
    "Saint-Louis",
    "Toutes les villes",
  ];

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(_onScroll);

    _articlesStream = Supabase.instance.client
        .from('articles')
        .stream(primaryKey: ['id'])
        .order(
          'created_at',
          ascending: false,
        );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 500 &&
        !_isLoadingMore) {
      _loadMore();
    }
  }

  void _loadMore() {
    setState(() {
      _isLoadingMore = true;
      _currentPage++;
    });

    developer.log(
      'Chargement page $_currentPage',
      name: 'HomePage',
    );
  }

  void _resetSearch() {
    setState(() {
      _currentPage = 0;
      _isLoadingMore = false;

      _searchController.clear();

      _selectedCategory = null;
      _selectedCity = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EE),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildFiltersSection(),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _articlesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(
                        Color(0xFFD4AF37),
                      ),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 80,
                            color:
                                Colors.red.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Erreur de chargement",
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  Colors.red.shade600,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            snapshot.error.toString(),
                            textAlign:
                                TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors
                                  .grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(
                                      0xFF1F2937),
                              foregroundColor:
                                  const Color(
                                      0xFFD4AF37),
                            ),
                            child: const Text(
                              "Réessayer",
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final rawData =
                    snapshot.data ?? [];

                var articles = rawData
                    .map(
                      (e) => Article.fromMap(e),
                    )
                    .toList();

                if (_searchController
                    .text.isNotEmpty) {
                  final query =
                      _searchController.text
                          .toLowerCase();

                  articles = articles
                      .where(
                        (a) => a.nom
                            .toLowerCase()
                            .contains(query),
                      )
                      .toList();
                }

                if (_selectedCategory != null) {
                  articles = articles
                      .where(
                        (a) =>
                            a.categorie ==
                            _selectedCategory,
                      )
                      .toList();
                }

                if (_selectedCity != null &&
                    _selectedCity !=
                        "Toutes les villes") {
                  articles = articles
                      .where(
                        (a) =>
                            a.ville ==
                            _selectedCity,
                      )
                      .toList();
                }

                if (articles.isEmpty) {
                  final isSearching =
                      _searchController
                              .text.isNotEmpty ||
                          _selectedCategory !=
                              null ||
                          (_selectedCity !=
                                  null &&
                              _selectedCity !=
                                  "Toutes les villes");

                  return Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                              24),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 80,
                            color:
                                Colors.grey.shade300,
                          ),
                          const SizedBox(
                              height: 16),
                          Text(
                            "Aucun article trouvé",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors
                                  .grey.shade600,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                              height: 8),
                          if (isSearching)
                            ElevatedButton(
                              onPressed:
                                  _resetSearch,
                              style:
                                  ElevatedButton
                                      .styleFrom(
                                backgroundColor:
                                    const Color(
                                        0xFF1F2937),
                                foregroundColor:
                                    const Color(
                                        0xFFD4AF37),
                              ),
                              child: const Text(
                                "Réinitialiser la recherche",
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  controller:
                      _scrollController,
                  padding:
                      const EdgeInsets.all(12),
                  itemCount:
                      articles.length +
                          (_isLoadingMore
                              ? 1
                              : 0),
                  itemBuilder:
                      (context, index) {
                    if (index ==
                        articles.length) {
                      return const Padding(
                        padding:
                            EdgeInsets.all(
                                16),
                        child: Center(
                          child:
                              CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<
                                    Color>(
                              Color(0xFFD4AF37),
                            ),
                          ),
                        ),
                      );
                    }

                    final article =
                        articles[index];

                    return _buildArticleCard(
                      article,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

    PreferredSizeWidget _buildAppBar() {
    final user = Supabase.instance.client.auth.currentUser;

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 90,
      backgroundColor: RoyalColors.background,
      elevation: 0,
      titleSpacing: 20,
      title: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: RoyalColors.primaryGradient,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.gavel_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bonjour 👋",
                  style: TextStyle(
                    color:
                        RoyalColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? "Bienvenue",
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: RoyalColors.text,
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: RoyalColors.card,
              borderRadius:
                  BorderRadius.circular(16),
              border: Border.all(
                color: RoyalColors.border,
              ),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      color: RoyalColors.background,
      padding: const EdgeInsets.fromLTRB(
        18,
        8,
        18,
        18,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: RoyalColors.card,
              borderRadius:
                  BorderRadius.circular(18),
              border: Border.all(
                color: RoyalColors.border,
              ),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (_) =>
                  setState(() {}),
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    "Rechercher une enchère...",
                hintStyle: const TextStyle(
                  color:
                      RoyalColors.textHint,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: RoyalColors.gold,
                ),
                suffixIcon:
                    _searchController
                            .text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController
                                  .clear();
                              _resetSearch();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          )
                        : null,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient:
                  RoyalColors.primaryGradient,
              borderRadius:
                  BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Découvrez les meilleures enchères",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Achetez, vendez et enchérissez sur des milliers d'articles.",
                  style: TextStyle(
                    color: Colors.white
                        .withValues(
                            alpha: .85),
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration:
                      BoxDecoration(
                    color: Colors.white
                        .withValues(
                            alpha: .18),
                    borderRadius:
                        BorderRadius
                            .circular(
                                30),
                  ),
                  child: const Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      Icon(
                        Icons
                            .local_fire_department,
                        color:
                            RoyalColors.gold,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Enchères populaires",
                        style: TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          SingleChildScrollView(
            scrollDirection:
                Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  label:
                      _selectedCategory ??
                          "Catégorie",
                  isActive:
                      _selectedCategory !=
                          null,
                  onTap:
                      _showCategoryPicker,
                ),

                const SizedBox(width: 8),

                _buildFilterChip(
                  label:
                      _selectedCity ??
                          "Ville",
                  isActive:
                      _selectedCity !=
                          null,
                  onTap: _showCityPicker,
                ),

                const SizedBox(width: 8),

                if (_selectedCategory !=
                        null ||
                    _selectedCity !=
                        null)
                  GestureDetector(
                    onTap:
                        _resetSearch,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration:
                          BoxDecoration(
                        color: Colors
                            .red
                            .shade100,
                        borderRadius:
                            BorderRadius
                                .circular(
                                    20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.close,
                            size: 14,
                            color: Colors
                                .red
                                .shade600,
                          ),
                          const SizedBox(
                              width: 4),
                          Text(
                            "Réinitialiser",
                            style:
                                TextStyle(
                              fontSize:
                                  12,
                              color: Colors
                                  .red
                                  .shade600,
                              fontWeight:
                                  FontWeight
                                      .w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildFilterChip({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFD4AF37)
                  .withValues(alpha: 0.20)
              : Colors.grey.shade100,
          borderRadius:
              BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? const Color(0xFFD4AF37)
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                    FontWeight.w500,
                color: isActive
                    ? const Color(
                        0xFFD4AF37)
                    : Colors.grey
                        .shade600,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: isActive
                  ? const Color(
                      0xFFD4AF37)
                  : Colors.grey
                      .shade600,
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(16),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Text(
                "Sélectionner une catégorie",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 16),

              ...categories.map(
                (category) => ListTile(
                  title: Text(category),
                  trailing:
                      _selectedCategory ==
                              category
                          ? const Icon(
                              Icons.check,
                              color: Color(
                                  0xFFD4AF37),
                            )
                          : null,
                  onTap: () {
                    setState(() {
                      _selectedCategory =
                          category;
                      _currentPage = 0;
                    });

                    Navigator.pop(
                        context);
                  },
                ),
              ),

              if (_selectedCategory !=
                  null)
                ListTile(
                  title: const Text(
                      "Effacer le filtre"),
                  textColor: Colors.red,
                  onTap: () {
                    setState(() {
                      _selectedCategory =
                          null;
                      _currentPage = 0;
                    });

                    Navigator.pop(
                        context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCityPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(16),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Text(
                "Sélectionner une ville",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 16),

              ...cities.map(
                (city) => ListTile(
                  title: Text(city),
                  trailing:
                      _selectedCity ==
                              city
                          ? const Icon(
                              Icons.check,
                              color: Color(
                                  0xFFD4AF37),
                            )
                          : null,
                  onTap: () {
                    setState(() {
                      _selectedCity =
                          city;
                      _currentPage = 0;
                    });

                    Navigator.pop(
                        context);
                  },
                ),
              ),

              if (_selectedCity !=
                  null)
                ListTile(
                  title: const Text(
                      "Effacer le filtre"),
                  textColor: Colors.red,
                  onTap: () {
                    setState(() {
                      _selectedCity =
                          null;
                      _currentPage = 0;
                    });

                    Navigator.pop(
                        context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

    Widget _buildArticleCard(Article article) {
    final estTerminee =
        article.createdAt != null &&
            DateTime.now().isAfter(
              article.createdAt!.add(
                Duration(
                  hours: article.duree,
                ),
              ),
            );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DetailPage(article: article),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: .08,
              ),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'article-${article.id}',
                  child: article
                          .imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl:
                              article.imageUrl,
                          height: 200,
                          width:
                              double.infinity,
                          fit: BoxFit.cover,
                          placeholder:
                              (_, __) =>
                                  Container(
                            height: 200,
                            color: Colors
                                .grey.shade200,
                            child:
                                const Center(
                              child:
                                  CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<
                                        Color>(
                                  Color(
                                    0xFFD4AF37,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          errorWidget:
                              (_, __, ___) =>
                                  Container(
                            height: 200,
                            color: Colors
                                .grey.shade200,
                            child: const Icon(
                              Icons
                                  .image_outlined,
                              size: 60,
                              color:
                                  Colors.grey,
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          color: Colors
                              .grey.shade200,
                          child: const Icon(
                            Icons
                                .image_outlined,
                            size: 60,
                            color:
                                Colors.grey,
                          ),
                        ),
                ),

                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration:
                        BoxDecoration(
                      color: estTerminee
                          ? Colors.red
                              .withValues(
                                  alpha:
                                      .90)
                          : const Color(
                                  0xFFD4AF37)
                              .withValues(
                                  alpha:
                                      .90),
                      borderRadius:
                          BorderRadius
                              .circular(16),
                    ),
                    child: Text(
                      estTerminee
                          ? "TERMINÉE"
                          : "EN COURS",
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 11,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding:
                  const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration:
                        BoxDecoration(
                      color: const Color(
                              0xFFD4AF37)
                          .withValues(
                              alpha: .10),
                      borderRadius:
                          BorderRadius
                              .circular(4),
                    ),
                    child: Text(
                      article.categorie,
                      style:
                          const TextStyle(
                        fontSize: 10,
                        color: Color(
                            0xFFD4AF37),
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 8),

                  Text(
                    article.nom,
                    maxLines: 2,
                    overflow:
                        TextOverflow
                            .ellipsis,
                    style:
                        const TextStyle(
                      fontSize: 14,
                      fontWeight:
                          FontWeight
                              .bold,
                      color: Color(
                          0xFF1F2937),
                    ),
                  ),

                  const SizedBox(
                      height: 6),

                  Text(
                    "${article.prix} FCFA",
                    style:
                        const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight
                              .bold,
                      color: Color(
                          0xFFD4AF37),
                    ),
                  ),

                  const SizedBox(
                      height: 8),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons
                                .location_on_outlined,
                            size: 12,
                            color: Color(
                                0xFF9CA3AF),
                          ),
                          const SizedBox(
                              width: 4),
                          Text(
                            article.ville,
                            style:
                                const TextStyle(
                              fontSize:
                                  11,
                              color: Color(
                                  0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons
                                .local_fire_department_outlined,
                            size: 12,
                            color: Colors
                                .orange
                                .shade600,
                          ),
                          const SizedBox(
                              width: 4),
                          Text(
                            "${article.nbEncheres}",
                            style:
                                TextStyle(
                              fontSize:
                                  11,
                              color: Colors
                                  .orange
                                  .shade600,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}