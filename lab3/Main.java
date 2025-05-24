import java.util.Arrays;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {

    // public static void printPlacementsWithRepetitions()

    // получить следующий символ из алфавита символов
    public static char nextSymbol(char curSymbol, int n, char[] alphabet) {
        int i = 0;
        while ((i < n) && (alphabet[i] != curSymbol)) i++;
        return alphabet[i + 1];
    }

    // получить следующее размещение в лексикографическом порядке
    // с повторениями из алфавита длины n по k символов
    // текущее и следующее размещение в array
    // false если следующее размещение получить нельзя и было уже получено последнее в лексикографическом порядке
    public static boolean nextPlacement(char[] array,int n,int k, char[] alphabet) {
        int j = k - 1;
        // идти по размещению с конца и искать, пока не встретишь символ - НЕ ПОСЛЕДНИЙ в алфавите
        while ((j >= 0) && (array[j] == alphabet[n - 1])) {
            j--;
        }
        // если все символы размещения - последние в алфавите, больше размещений нет, выводим false
        if (j < 0) {
            return false;
        } else {
            // мы остановились на символе, который не последний в алфавите
            // на его место в размещении ставим следующий по алфавиту
            array[j] = nextSymbol(array[j],n, alphabet);
            // на все остальные места ставим первый по алфавиту
            for (int i = j + 1; i < k; i++) {
                array[i] = alphabet[0];
            }
            return true;
        }
    }
    // напечатать все размещения из алфавита длины n по k символов с повторениями
    public static void printPlacements(char[] array,int n,int k, char[] alphabet) {
        // задать первое по алфавиту размещение с повторениями - тупо все первые буквы алфавита
        for (int i = 0; i < k; i++) {
            array[i] = alphabet[0];
        }
        for (int i = 0; i < k; i++) {
            System.out.print(array[i]);
        }
        System.out.println();

        // nextPlacement меняет размещение в array на следующее по алфавиту и возвращает true
        // если следующий получить нельзя, то есть текущий это последнее в лексикографическом порядке размещение
        // то метод вернёт false и цикл остановится
        while (nextPlacement(array, n, k, alphabet)) {
            for (int i = 0; i < k; i++) {
                System.out.print(array[i]);
            }
            System.out.println();
        }
    }

    // получить следующее сочетание без повторений из алфавита длины n по
    // k символов
    // текущее и следующее сочетание в array
    // false если следующее сочетание получить нельзя и было уже получено последнее в лексикографическом порядке
    public static boolean nextCombination(char[] array,int n,int k, char[] alphabet) {
        int j = k - 1;
        int l = 1;
        // идём с конца и проверяем условие
        // является ли текущий символ максимально возможным на своей позиции
        while ((j >= 0) && (array[j] == alphabet[n - l])) {
            j--;
            l++;
        }
        // в какой-то момент условие нарушится, то есть на алфавите [a, b, c, d, e] и
        // сочетании [a, d, e] d, e - максимально возможные на своих позициях,
        // не может быть сочетания с e на втором месте.
        // а вот a не максимально возможное, можно на её место поставит b
        // следующее сочетание будет [b, c, d]

        if (j < 0) {
            // каждый символ сочетания - последний на позиции
            // например - [c, d, e] - следующего не существует
            return false;
        } else {
            array[j] = nextSymbol(array[j],n, alphabet);
            for (int i = j + 1; i < k; i++) {
                array[i] = nextSymbol(array[i-1], n ,alphabet);
            }
            return true;
        }
    }

    // напечатать все сочетания из алфавита длины n по k символов без повторений
    public static void printCombinations(char[] array,int n,int k, char[] alphabet) {
        // построить первое сочетание как первые k символов алфавита
        for (int i = 0; i < k; i++) {
            array[i] = alphabet[i];
        }
        for (int i = 0; i < k; i++) {
            System.out.print(array[i]);
        }
        System.out.println();
        // так же как в размещениях
        while (nextCombination(array, n, k, alphabet)) {
            for (int i = 0; i < k; i++) {
                System.out.print(array[i]);
            }
            System.out.println();
        }
    }

    // напечатать все размещения из алфавита длины n по k символов с повторениями рекурсивной функцией
    public static void printPlacementsRecursive(char[] array,int n,int k, char[] alpabet, int curPos) {
        if (curPos == k) {
            // дно рекурсии - значит, всё размещение целиком заполнено
            for (int i = 0; i < k; i++) {
                System.out.print(array[i]);
            }
            System.out.println();
        } else {
            // по очереди на текущую позицию ставим символ
            // и вызываем рекурсивно для следующего символа
            for (int i = 0; i < n; i++) {
                array[curPos] = alpabet[i];
                printPlacementsRecursive(array,n,k,alpabet,curPos + 1);
            }
        }
    }

    // напечатать все сочетания из алфавита длины n по k символов без повторений рекурсивной функцией
    public static void printCombinationsRecursive(char[] array,int n,int k, char[] alpabet, int curPos) {
        if (curPos == k) {
            // дно рекурсии - значит, всё сочетание целиком заполнено
            for (int i = 0; i < k; i++) {
                System.out.print(array[i]);
            }
            System.out.println();
        } else {
            // находим символ, с которого начнём заполнять текущий символ
            // это или символ за предыдущим
            // или первый в алфавите если он первый в сочетании
            char startChar = (curPos == 0) ? alpabet[0] : nextSymbol(array[curPos - 1], n, alpabet);
            // при выбора символа на позицию в сочетании нельзя брать все символы алфавита
            // пусть алфавит [a,b,c,d,e,f,g,h,i,j]
            // сочетание по 5, уже построено [ b, d, , , ]
            // строим 3 символ
            // нельзя на 3 место поставить i, тогда на 4 только j на пятое место нет символа, иначе просто пойдут
            // размещения а не сочетания
            // тогда первый возможный символ - e последний h
            // находим их позиции в алфавите
            int startCharNumber = Arrays.binarySearch(alpabet, startChar);
            int finishCharNumber = n - (k - curPos);
            // по очереди ставим возможный символ, вызываем рекурсию
            for (int i = startCharNumber; i <= finishCharNumber; i++) {
                array[curPos] = alpabet[i];
                System.out.println(String.format("Curpos: curPos=%d", curPos));
                printCombinationsRecursive(array,n,k,alpabet,curPos + 1);
            }
        }
    }

    // получить следующий символ из алфавита цифр
    public static int nextSymbolInt(int curSymbol, int n, int[] alphabet) {
        int i = 0;
        while ((i < n) && (alphabet[i] != curSymbol)) i++;
        return alphabet[i + 1];
    }

    // получить следующее сочетание без повторений из алфавита длины n по
    // k цифр
    // текущее и следующее сочетание в array
    // false если следующее сочетание получить нельзя и было уже получено последнее в лексикографическом порядке
    public static boolean nextCombinationInt(int[] array,int n,int k, int[] alphabet) {
        int j = k - 1;
        int l = 1;
        while ((j >= 0) && (array[j] == alphabet[n - l])) {
            j--;
            l++;
        }
        if (j < 0) {
            return false;
        } else {
            array[j] = nextSymbolInt(array[j],n, alphabet);
            for (int i = j + 1; i < k; i++) {
                array[i] = nextSymbolInt(array[i-1], n ,alphabet);
            }
            return true;
        }
    }

    // для переданного массива символов и массива позиций ставит "а" в слово на позиции
    public static void putAinPositions(char[] word, int[] positionsA) {
        for (int i = 0; i < 3; i++) {
            word[positionsA[i]] = 'a';
        }
    }
    // печатает все слова длины k алфавита длины n, в которых 3 буквы a
    public static void printWords3aOfK(char[] word, int n, int k, char[] alphabet) {
        // построить массив позиций для буквы a с помощью генерации сочетания строим первое сочетание
        // из позиций [0, 1, 2]
        // для сочетаний нужен алфавит, им будет алфавит позиций [0, 1, 2, ..., (k-1)].
        int[] positionsA = new int[3];
        int[] positionsAlphabet = new int[k];
        for (int i = 0; i < k; i++) {
            positionsAlphabet[i] = i;
        }
        for (int i = 0; i < 3; i++) {
            positionsA[i] = i;
        }
        // цикл перебора сочетаний позиций для буквы A
        do {
            // ставим a на позиции из сочетания в слово
            putAinPositions(word, positionsA);
            // остальные буквы забьём в новый алфавит
            // для него посчитаем длину
            // и построим начальное размещение длины количество пустых позиций без a - (k-3)
            // причём размещение с повторениями
            char[] newAlphabet = new char[n - 1];
            for (int i = 1; i < n; i++) {
                newAlphabet[i - 1] = alphabet[i];
            }
            char[] restOfWord = new char[k - 3];
            int lengthRestOfWord = k - 3;
            for (int i = 0; i < lengthRestOfWord; i++) {
                restOfWord[i] = newAlphabet[0];
            }
            // начнём перебор размещений с повторениями оставшихся букв
            do {
                // поставим буквы из размещения в пустые позиции в том порядке, в котором они вошли в размещение
                int posRestWord = 0;
                for (int i = 0; i < k; i++) {
                    if (word[i] != 'a') {
                        word[i] = restOfWord[posRestWord];
                        posRestWord++;
                    }
                }
                for (int i = 0; i < k; i++) {
                    System.out.print(word[i]);
                }
                System.out.println();
            } while (nextPlacement(restOfWord, n-1, lengthRestOfWord, newAlphabet));
            for (int i = 0; i < k; i++) {
                word[i] = ' ';
            }
        } while (nextCombinationInt(positionsA, k, 3, positionsAlphabet));
    }



    public static void main(String[] args) {
        //TIP Press <shortcut actionId="ShowIntentionActions"/> with your caret at the highlighted text
        // to see how IntelliJ IDEA suggests fixing it.
        System.out.println("Hello and welcome!");
        int n = 5;
        int k = 5;

        char[] array1 = new char[k];
        char[] alphabet = new char[n];
        alphabet[0] = 'a';
        alphabet[1] = 'b';
        alphabet[2] = 'c';
        alphabet[3] = 'd';
        alphabet[4] = 'e';
        printWords3aOfK(array1, n, k, alphabet);
        // printWords3aOfK(array1, n, k, alphabet);
    }
}