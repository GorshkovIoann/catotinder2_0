import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/liked_cat.dart';
import '../blocs/liked_cats_cubit.dart';

class LikedCatsScreen extends StatelessWidget {
  const LikedCatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лайкнутые котики')),
      backgroundColor: Colors.pink[50],
      body: BlocBuilder<LikedCatsCubit, LikedCatsState>(
        builder: (context, state) {
          // Если список пуст, показываем сообщение
          if (state.allLikedCats.isEmpty) {
            return const Center(child: Text('Нет лайкнутых котиков'));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  hint: const Text('Фильтровать по породе'),
                  value: state.filter.isEmpty ? null : state.filter,
                  items: _buildFilterItems(state.allLikedCats),
                  onChanged: (value) {
                    context.read<LikedCatsCubit>().setFilter(value ?? '');
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.filteredCats.length,
                  itemBuilder: (context, index) {
                    final likedCat = state.filteredCats[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: ListTile(
                        leading: Image.network(
                          likedCat.cat.url,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(likedCat.cat.breedName),
                        subtitle: Text(
                          'Лайк: ${likedCat.likedAt.toLocal().toString().split('.')[0]}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<LikedCatsCubit>().removeLikedCat(
                              likedCat,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Собираем уникальные элементы для фильтрации по породе
  List<DropdownMenuItem<String>> _buildFilterItems(List<LikedCat> likedCats) {
    final breeds = <String>{};
    for (final likedCat in likedCats) {
      breeds.add(likedCat.cat.breedName);
    }
    return [
      const DropdownMenuItem<String>(value: '', child: Text('Все породы')),
      ...breeds.map(
        (breed) => DropdownMenuItem<String>(value: breed, child: Text(breed)),
      ),
    ];
  }
}
