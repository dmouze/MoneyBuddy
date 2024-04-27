import 'package:english_words/english_words.dart'; // Importuje pakiet english_words, który zawiera generator losowych słów.
import 'package:flutter/material.dart'; // Importuje pakiet flutter/material.dart, który zawiera zestaw narzędzi i widgetów do tworzenia interfejsów użytkownika w aplikacji Flutter.
import 'package:provider/provider.dart'; // Importuje pakiet provider, który umożliwia zarządzanie stanem aplikacji i dostarcza narzędzia do implementacji wzorca projektowego "provider".

void main() {
  runApp(MyApp()); // Uruchamia aplikację, przekazując główny widget aplikacji - MyApp.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Definiuje klasę MyApp jako bezstanową (StatelessWidget) z opcjonalnym kluczem.

  @override
  Widget build(BuildContext context) { // Tworzy interfejs użytkownika aplikacji.
    return ChangeNotifierProvider( // Dostarcza dostępu do obiektu MyAppState dla poddrzewa widgetów.
      create: (context) => MyAppState(), // Tworzy instancję klasy MyAppState i udostępnia ją.
      child: MaterialApp( // Tworzy główny materiałowy interfejs użytkownika.
        title: 'Namer App', // Ustawia tytuł aplikacji.
        theme: ThemeData( // Definiuje motyw aplikacji.
          useMaterial3: true, // Ustawia flagę na true, aby korzystać z Material3.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange), // Konfiguruje schemat kolorów z domyślnym kolorem głębokiej pomarańczy.
        ),
        home: MyHomePage(), // Ustawia stronę główną aplikacji na MyHomePage.
      ),
    );
  }
}

class MyAppState extends ChangeNotifier { // Definiuje klasę, która będzie przechowywać stan aplikacji.
  var current = WordPair.random(); // Inicjalizuje zmienną przechowującą aktualną parę słów jako losową parę słów.

  void getNext() { // Metoda do pobierania kolejnej losowej pary słów.
    current = WordPair.random(); // Przypisuje nową losową parę słów do zmiennej current.
    notifyListeners(); // Powiadamia słuchaczy o zmianach w stanie.
  }

  var favorites = <WordPair>[]; // Inicjalizuje listę ulubionych par słów jako pustą listę.

  void toggleFavorite() { // Metoda do dodawania/usuwania pary słów do/z listy ulubionych.
    if (favorites.contains(current)) { // Sprawdza, czy aktualna para słów jest już w ulubionych.
      favorites.remove(current); // Jeśli tak, usuwa ją z listy ulubionych.
    } else {
      favorites.add(current); // Jeśli nie, dodaje ją do listy ulubionych.
    }
    notifyListeners(); // Powiadamia słuchaczy o zmianach w stanie.
  }
}

class MyHomePage extends StatefulWidget { // Definiuje klasę MyHomePage jako widget ze stanem.
  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Tworzy stan dla MyHomePage.
}

class _MyHomePageState extends State<MyHomePage> { // Definiuje stan MyHomePage.
  var selectedIndex = 0; // Inicjalizuje indeks wybranej strony na 0.

  @override
  Widget build(BuildContext context) { // Tworzy interfejs użytkownika strony głównej.
    Widget page; // Inicjalizuje zmienną do przechowywania wybranej strony.

    switch (selectedIndex) { // Wybiera stronę na podstawie indeksu.
      case 0:
        page = GeneratorPage(); // Jeśli indeks wynosi 0, wybiera GeneratorPage.
      case 1:
        page = FavoritesPage(); // Jeśli indeks wynosi 1, wybiera FavoritesPage.
      default:
        throw UnimplementedError('no widget for $selectedIndex'); // Jeśli indeks nie pasuje do żadnej strony, zgłasza błąd.
    }

    return LayoutBuilder(builder: (context, constraints) { // Tworzy układ strony w zależności od rozmiarów ekranu.
      return Scaffold( // Tworzy materiałowy szkielet strony.
        body: Row( // Układ strony w postaci poziomego rzędu.
          children: [
            SafeArea( // Zapewnia obszar bezpieczny, aby uniknąć nachodzenia na paski systemowe.
              child: NavigationRail( // Tworzy panel nawigacyjny.
                extended: constraints.maxWidth >= 600, // Określa, czy panel nawigacyjny jest rozszerzony w zależności od szerokości ekranu.
                destinations: [ // Definiuje cele nawigacyjne.
                  NavigationRailDestination(
                    icon: Icon(Icons.home), // Ikona dla strony głównej.
                    label: Text('Home'), // Etykieta dla strony głównej.
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite), // Ikona dla ulubionych.
                    label: Text('Favorites'), // Etykieta dla ulubionych.
                  ),
                ],
                selectedIndex: selectedIndex, // Ustawia indeks wybranej strony.
                onDestinationSelected: (value) { // Obsługuje wybór celu nawigacyjnego.
                  setState(() { // Wywołuje setState, aby zaktualizować stan widgetu.
                    selectedIndex = value; // Ustawia nowy indeks wybranej strony.
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer, // Ustawia kolor tła kontenera na kolor główny z motywu aplikacji.
                child: page, // Wyświetla wybraną stronę.
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget { // Definiuje GeneratorPage jako bezstanowy widget.
  @override
  Widget build(BuildContext context) { // Tworzy interfejs użytkownika GeneratorPage.
    var appState = context.watch<MyAppState>(); // Pobiera stan aplikacji.

    var pair = appState.current; // Pobiera aktualną parę słów.

    IconData icon; // Inicjalizuje zmienną na ikonę.
    if (appState.favorites.contains(pair)) { // Sprawdza, czy para słów jest w ulubionych.
      icon = Icons.favorite; // Jeśli tak, ustawia ikonę na ulubione.
    } else {
      icon = Icons.favorite_border; // Jeśli nie, ustawia ikonę na pustą ulubioną.
    }

    return Center( // Wyśrodkowuje zawartość.
      child: Column( // Układ w kolumnie.
        mainAxisAlignment: MainAxisAlignment.center, // Wyśrodkowuje w pionie.
        children: [
          BigCard(pair: pair), // Wyświetla duży element karteczki z aktualną parą słów.
          SizedBox(height: 10), // Pusty odstęp pionowy.
          Row( // Układ w rzędzie.
            mainAxisSize: MainAxisSize.min, // Minimalna wielkość osi głównej.
            children: [
              ElevatedButton.icon( // Przycisk z ikoną.
                onPressed: () { // Obsługa naciśnięcia przycisku.
                  appState.toggleFavorite(); // Przełącza stan ulubionych pary słów.
                },
                icon: Icon(icon), // Ikona przycisku.
                label: Text('Like'), // Etykieta przycisku.
              ),
              SizedBox(width: 10), // Pusty odstęp poziomy.
              ElevatedButton( // Podniesiony przycisk.
                onPressed: () { // Obsługa naciśnięcia przycisku.
                  appState.getNext(); // Pobiera następną losową parę słów.
                },
                child: Text('Next'), // Etykieta przycisku.
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget { // Definiuje BigCard jako bezstanowy widget.
  const BigCard({ // Konstruktor BigCard.
    super.key,
    required this.pair,
  });

  final WordPair pair; // Parę słów do wyświetlenia w karcie.

  @override
  Widget build(BuildContext context) { // Tworzy interfejs użytkownika dla karty BigCard.
    final theme = Theme.of(context); // Pobiera motyw aplikacji.
    final style = theme.textTheme.displayMedium!.copyWith( // Kopiuje styl tekstu z motywu aplikacji.
      color: theme.colorScheme.onPrimary, // Ustawia kolor tekstu na kolor na tle głównym.
    );

    return Card( // Tworzy kartę.
      color: theme.colorScheme.primary, // Ustawia kolor tła karty na kolor główny.
      child: Padding( // Dodaje wypełnienie wewnątrz karty.
        padding: const EdgeInsets.all(20), // Ustawia odstęp we wszystkich kierunkach.
        child: Text( // Tekst wewnątrz karty.
          pair.asLowerCase, // Wyświetla parę słów w małych literach.
          style: style, // Styl tekstu.
          semanticsLabel: "${pair.first} ${pair.second}", // Etykieta semantyczna dla pary słów.
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget { // Definiuje FavoritesPage jako bezstanowy widget.
  @override
  Widget build(BuildContext context) { // Tworzy interfejs użytkownika FavoritesPage.
    var appState = context.watch<MyAppState>(); // Pobiera stan aplikacji.

    if (appState.favorites.isEmpty) { // Sprawdza, czy lista ulubionych jest pusta.
      return Center( // Wyśrodkowuje zawartość.
        child: Text('No favorites yet.'), // Wyświetla informację o braku ulubionych.
      );
    }

    return ListView( // Lista pionowa.
      children: [
        Padding( // Wypełnienie.
          padding: const EdgeInsets.all(20), // Odstępy we wszystkich kierunkach.
          child: Text('You have ' // Tekst informacyjny o liczbie ulubionych.
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites) // Pętla po parach ulubionych.
          ListTile( // Element listy.
            leading: Icon(Icons.favorite), // Ikona przed tekstem.
            title: Text(pair.asLowerCase), // Tekst pary słów w małych literach.
          ),
      ],
    );
  }
}
