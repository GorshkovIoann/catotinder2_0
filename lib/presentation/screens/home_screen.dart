import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/cat_service.dart';
import '../../domain/entities/cat.dart';
import '../../domain/entities/liked_cat.dart';
import '../../injection/injection.dart';
import 'details_screen.dart';
import 'liked_cats_screen.dart';
import '../widgets/like_button.dart';
import '../widgets/dislike_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/liked_cats_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CatService catService = CatService();
  Cat? currentCat;
  int likeCounter = 0;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadNewCat();
  }

  Future<void> loadNewCat() async {
    int attempts = 0;
    Cat? cat;
    while (attempts < 3 && cat == null) {
      try {
        cat = await catService.fetchRandomCat();
      } catch (e) {
        print('Error loading cat: $e');
      }
      attempts++;
    }
    if (cat != null) {
      setState(() {
        currentCat = cat;
        errorMessage = null;
      });
    } else {
      setState(() {
        errorMessage = 'Не удалось загрузить данные. Попробуйте позже.';
      });
      // При необходимости можно показать AlertDialog с ошибкой
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Ошибка сети'),
              content: const Text(
                'Не удалось загрузить данные. Проверьте интернет соединение.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('ОК'),
                ),
              ],
            ),
      );
    }
  }

  void onSwipe(bool liked) {
    if (liked && currentCat != null) {
      setState(() {
        likeCounter++;
      });
      // Добавляем лайкнутого котика через кубит
      getIt<LikedCatsCubit>().addLikedCat(
        LikedCat(cat: currentCat!, likedAt: DateTime.now()),
      );
    }
    loadNewCat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Cat Tinder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LikedCatsScreen()),
              );
            },
          ),
        ],
      ),
      body:
          errorMessage != null
              ? Center(child: Text(errorMessage!))
              : currentCat == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity != null) {
                        if (details.primaryVelocity! > 0) {
                          onSwipe(true);
                        } else {
                          onSwipe(false);
                        }
                      }
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(cat: currentCat!),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: currentCat!.url,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const CircularProgressIndicator(),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentCat!.breedName,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LikeButton(onPressed: () => onSwipe(true)),
                      const SizedBox(width: 20),
                      DislikeButton(onPressed: () => onSwipe(false)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Likes: $likeCounter',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
    );
  }
}
