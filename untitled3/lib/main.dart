import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelime Oyunu',
      initialRoute: '/',
      routes: {

        '/wordgame': (context) => WordGameScreen(),
      },
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff68A4D9),
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/pictures/kelime.jpg", height: 450),
            Text(
              "HOŞGELDİNİZ!",
              style: TextStyle(fontSize: 25, color: Color(0xffFBD772)),
            ),
            Text(
              "Devam etmek için giriş yapın",
              style: TextStyle(height: 2, color: Color(0xffFBD772)),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Kullanıcı Adı",
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Parola",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Kullanıcı adı ve şifreyi alın
                String enteredUsername = userNameController.text;
                String enteredPassword = passwordController.text;

                // Kullanıcı adı ve şifreyi kontrol edin
                if (enteredUsername == "emirhan" && enteredPassword == "222") {
                  // Giriş başarılı, yeni sayfaya yönlendirin
                  Navigator.pushNamed(context, '/wordgame');
                } else if (enteredUsername == "dilara" && enteredPassword == "111") {
                  // Giriş başarılı, yeni sayfaya yönlendirin
                  Navigator.pushNamed(context, '/wordgame');
                } else {
                  // Kullanıcı adı veya şifre yanlışsa, kullanıcıyı uyarın
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Hata"),
                        content: Text("Kullanıcı adı veya şifre yanlış."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Tamam"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text("Giriş yap"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFBD772),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),

            TextButton(
              onPressed: () {},
              child: Text(
                "Üye Ol",
                style: TextStyle(
                  color: Color(0xffFBD772),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}









































class WordGameScreen extends StatefulWidget {
  @override
  _WordGameScreenState createState() => _WordGameScreenState();
}

class _WordGameScreenState extends State<WordGameScreen> {
  int wordLength = 0;
  String user1Word = "";
  String user2Word = "";
  late Timer _user1Timer;
  late Timer _user2Timer;
  int _user1Start = 60;
  int _user2Start = 60;
  int user1RemainingTime = 60;
  int user2RemainingTime = 60;

  @override
  void initState() {
    super.initState();
    startUser1Timer();
  }

  void checkUserWords() {
    if (user1Word.isNotEmpty && user2Word.isEmpty) {
      // Eğer sadece 1. kullanıcı kelime girmişse
      showWinner("1. Kullanıcı");
    } else if (user1Word.isEmpty && user2Word.isNotEmpty) {
      // Eğer sadece 2. kullanıcı kelime girmişse
      showWinner("2. Kullanıcı");
    } else if (user1Word.isEmpty && user2Word.isEmpty) {
      // Eğer her iki kullanıcı da kelime girmemişse
      // Burada herhangi bir işlem yapmayabilirsiniz veya bir uyarı mesajı verebilirsiniz.
    }
  }

  void showWinner(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Kazanan"),
          content: Text("$winner kazandı!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  // Oyunu sıfırla
                  wordLength = 0;
                  user1Word = "";
                  user2Word = "";
                  user1RemainingTime = 60;
                  user2RemainingTime = 60;
                });
                Navigator.of(context).popUntil((route) => route.isFirst); // İlk ekrana dön
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

















  void startUser1Timer() {
    const oneSec = const Duration(seconds: 1);
    _user1Timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_user1Start == 0) {
          setState(() {
            timer.cancel();
            checkUserWords(); // Süre dolduğunda kontrol et
          });
        } else {
          setState(() {
            _user1Start--;
            user1RemainingTime = _user1Start;
          });
        }
      },
    );
  }

  void startUser2Timer() {
    const oneSec = const Duration(seconds: 1);
    _user2Timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_user2Start == 0) {
          setState(() {
            timer.cancel();
            checkUserWords(); // Süre dolduğunda kontrol et
          });
        } else {
          setState(() {
            _user2Start--;
            user2RemainingTime = _user2Start;
          });
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelime Oyunu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hangi odaya girmek istiyorsunuz?',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  onPressed: () => selectWordLength(4),
                  child: Text('4'),
                ),
                ElevatedButton(
                  onPressed: () => selectWordLength(5),
                  child: Text('5'),
                ),
                ElevatedButton(
                  onPressed: () => selectWordLength(6),
                  child: Text('6'),
                ),
                ElevatedButton(
                  onPressed: () => selectWordLength(7),
                  child: Text('7'),
                ),

              ],
            ),
            SizedBox(height: 20.0),
            if (wordLength > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1. Kullanıcı: $wordLength harfli kelimenizi girin',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      TimerWidget(remainingTime: user1RemainingTime),
                      ElevatedButton(
                        onPressed: () {
                          _user1Timer.cancel();
                          startUser2Timer();
                        },
                        child: Text('Tamam'),
                      ),
                    ],
                  ),
                  TextField(
                    onChanged: (value) => user1Word = value,
                    decoration: InputDecoration(
                      hintText: 'Kelime giriniz',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '2. Kullanıcı: $wordLength harfli kelimenizi girin',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      TimerWidget(remainingTime: user2RemainingTime),
                      ElevatedButton(
                        onPressed: () {
                          _user2Timer.cancel();
                        },
                        child: Text('Tamam'),
                      ),
                    ],
                  ),
                  TextField(
                    onChanged: (value) => user2Word = value,
                    decoration: InputDecoration(
                      hintText: 'Kelime giriniz',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameScreen(
                            wordLength: wordLength,
                            user1Word: user1Word,
                            user2Word: user2Word,
                            user1RemainingTime:user1RemainingTime ,
                            user2RemainingTime:user2RemainingTime,
                          ),
                        ),
                      );
                    },
                    child: Text('Oyuna Başla'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void selectWordLength(int length) {
    setState(() {
      wordLength = length;
    });
  }
}


class TimerWidget extends StatelessWidget {
  final int remainingTime;

  TimerWidget({required this.remainingTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Text(
        '$remainingTime',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}












class GameScreen extends StatefulWidget {
  final int wordLength;
  final String user1Word;
  final String user2Word;
  final int user1RemainingTime;
  final int user2RemainingTime;

  GameScreen({
    required this.wordLength,
    required this.user1Word,
    required this.user2Word,
    required this.user1RemainingTime,
    required this.user2RemainingTime,
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<String> guessedWords;
  late int remainingAttempts;
  int greenSquareCount = 0;
  int yellowSquareCount = 0;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    guessedWords = [];
    remainingAttempts = widget.wordLength;
  }

  void checkGuess(String guess) {
    if (guess == widget.user2Word) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Tebrikler! Doğru tahmin ettiniz."),
        ),
      );
    } else {
      setState(() {
        remainingAttempts--;
        if (remainingAttempts == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Tahmin hakkınız kalmadı."),
            ),
          );
        }
      });
    }
  }

  void makeGuess() {
    String guess = textEditingController.text;
    if (guess.isNotEmpty) {
      setState(() {
        guessedWords.add(guess);
        remainingAttempts--;
        compareWords(guess);
        textEditingController.clear();
      });
    }
  }

  void compareWords(String guess) {
    for (int i = 0; i < widget.wordLength; i++) {
      if (i < guess.length && guess[i] == widget.user2Word[i]) {
        greenSquareCount++;
      } else if (widget.user2Word.contains(guess[i])) {
        yellowSquareCount++;
      }
    }
  }

  Widget buildLetterBoxes(String word) {
    List<Widget> letterBoxes = [];
    for (int i = 0; i < word.length; i++) {
      Color textColor = Colors.black;
      if (guessedWords.isNotEmpty && widget.user2Word.length == word.length) {
        if (word[i] == widget.user2Word[i]) {
          textColor = Colors.green;
        } else if (widget.user2Word.contains(word[i])) {
          textColor = Colors.yellow;
        }
      }
      letterBoxes.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Text(
              word[i],
              style: TextStyle(fontSize: 20, color: textColor),
            ),
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letterBoxes,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> guessRows = [];
    for (String word in guessedWords) {
      guessRows.add(buildLetterBoxes(word));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('1.kullanıcı tahmin Alanı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tahmin Hakkı: $remainingAttempts',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              children: guessRows,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Kelime tahmini giriniz',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: makeGuess,
                  child: Text('Tahmin Et'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Toplam Puanınız: ${greenSquareCount * 10 + yellowSquareCount * 5+widget.user1RemainingTime }',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtherUserScreen(
                      wordLength: widget.wordLength,
                      user1Word: widget.user1Word,
                      user2Word: widget.user2Word,
                      user2RemainingTime:widget.user2RemainingTime,
                      user1RemainingTime:widget.user1RemainingTime,

                    ),
                  ),
                );
              },
              child: Text('Diğer Kullanıcıya Geç'),
            ),
          ],
        ),
      ),
    );
  }
}






















class OtherUserScreen extends StatefulWidget {
  final int wordLength;
  final String user1Word;
  final String user2Word;
  final int user2RemainingTime;
  final int user1RemainingTime;


  OtherUserScreen({
    required this.wordLength,
    required this.user1Word,
    required this.user2Word,
    required this.user2RemainingTime,
    required this.user1RemainingTime,

  });

  @override
  _OtherUserScreenState createState() => _OtherUserScreenState();
}

class _OtherUserScreenState extends State<OtherUserScreen> {
  late List<String> guessedWords;
  late int remainingAttempts;
  int greenSquareCount = 0;
  int yellowSquareCount = 0;
  TextEditingController textEditingController = TextEditingController();
  final String user1Word = "";
  final String user2Word = "";


  @override
  void initState() {
    super.initState();
    guessedWords = [];
    remainingAttempts = widget.wordLength;
  }

  void makeGuess() {
    String guess = textEditingController.text;
    if (guess.isNotEmpty) {
      setState(() {
        guessedWords.add(guess);
        remainingAttempts--;
        compareWords(guess);
        textEditingController.clear();
      });
    }
  }

  void compareWords(String guess) {
    for (int i = 0; i < widget.wordLength; i++) {
      if (i < guess.length && guess[i] == widget.user1Word[i]) {
        greenSquareCount++;
      } else if (widget.user1Word.contains(guess[i])) {
        yellowSquareCount++;
      }
    }
  }

  Widget buildLetterBoxes(String word) {
    List<Widget> letterBoxes = [];
    for (int i = 0; i < word.length; i++) {
      Color textColor = Colors.black;
      if (guessedWords.isNotEmpty && widget.user1Word.length == word.length) {
        if (word[i] == widget.user1Word[i]) {
          textColor = Colors.green;
        } else if (widget.user1Word.contains(word[i])) {
          textColor = Colors.yellow;
        }
      }
      letterBoxes.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5.0),
            color: textColor == Colors.green
                ? Colors.green.withOpacity(0.5)
                : textColor == Colors.yellow
                ? Colors.yellow.withOpacity(0.5)
                : null,
          ),
          child: Center(
            child: Text(
              word[i],
              style: TextStyle(fontSize: 20, color: textColor),
            ),
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letterBoxes,
    );
  }




  /* void showWinner() {
    bool user1Correct = user1Word == widget.user2Word && user2Word != widget.user2Word;
    bool user2Correct = user2Word == widget.user2Word && user1Word != widget.user2Word;

    if (user1Correct || user2Correct) {
      // Sadece bir kullanıcı doğru tahmin etti, diğeri etmedi
      String winner = user1Correct ? "1. Kullanıcı" : "2. Kullanıcı";
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Kazanan"),
            content: Text("$winner kazandı!"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    guessedWords = [];
                    remainingAttempts = widget.wordLength;
                    greenSquareCount = 0;
                    yellowSquareCount = 0;
                  });
                  Navigator.of(context).popUntil((route) => route.isFirst); // İlk ekrana dön
                  Navigator.pushReplacement( // WordGameScreen ekranını yeniden başlat
                    context,
                    MaterialPageRoute(
                      builder: (context) => WordGameScreen(),
                    ),
                  );
                },
                child: Text("Tamam"),
              ),
            ],
          );
        },
      );
    } else {
      // Her iki kullanıcı da doğru tahmin etmedi veya her ikisi de doğru tahmin etti
      int user1TotalScore = greenSquareCount * 10 + yellowSquareCount * 5 + widget.user1RemainingTime;
      int user2TotalScore = greenSquareCount * 10 + yellowSquareCount * 5 + widget.user2RemainingTime;

      String winner;
      if (user1TotalScore > user2TotalScore) {
        winner = "1. Kullanıcı";
      } else if (user2TotalScore > user1TotalScore) {
        winner = "2. Kullanıcı";
      } else {
        winner = "Berabere";
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Kazanan"),
            content: Text("$winner kazandı!"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    guessedWords = [];
                    remainingAttempts = widget.wordLength;
                    greenSquareCount = 0;
                    yellowSquareCount = 0;
                  });
                  Navigator.of(context).popUntil((route) => route.isFirst); // İlk ekrana dön
                  Navigator.pushReplacement( // WordGameScreen ekranını yeniden başlat
                    context,
                    MaterialPageRoute(
                      builder: (context) => WordGameScreen(),
                    ),
                  );
                },
                child: Text("Tamam"),
              ),
            ],
          );
        },
      );
    }
  }
   */


  void showWinner() {
    int user1TotalScore = greenSquareCount * 10 + yellowSquareCount * 5 + widget.user1RemainingTime;
    int user2TotalScore = greenSquareCount * 10 + yellowSquareCount * 5 + widget.user2RemainingTime;

    String winner;
    if (user1TotalScore > user2TotalScore) {
      winner = "1. Kullanıcı";
    } else if (user2TotalScore > user1TotalScore) {
      winner = "2. Kullanıcı";
    } else {
      winner = "Berabere";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Kazanan"),
          content: Text("$winner kazandı!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  guessedWords = [];
                  remainingAttempts = widget.wordLength;
                  greenSquareCount = 0;
                  yellowSquareCount = 0;
                });
                Navigator.of(context).popUntil((route) => route.isFirst); // İlk ekrana dön
                Navigator.pushReplacement( // WordGameScreen ekranını yeniden başlat
                  context,
                  MaterialPageRoute(
                    builder: (context) => WordGameScreen(),
                  ),
                );
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }









  @override
  Widget build(BuildContext context) {
    List<Widget> guessRows = [];
    for (String word in guessedWords) {
      guessRows.add(buildLetterBoxes(word));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('2.kullanıcı tahmin Alanı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tahmin Hakkı: $remainingAttempts',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              children: guessRows,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Kelime tahmini giriniz',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: makeGuess,
                  child: Text('Tahmin Et'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Toplam Puanınız: ${greenSquareCount * 10 + yellowSquareCount * 5 + widget.user2RemainingTime}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: showWinner,
              child: Text('Kazananı Göster'),
            ),
          ],
        ),
      ),
    );
  }
}


