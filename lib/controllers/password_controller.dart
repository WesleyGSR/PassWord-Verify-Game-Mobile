class PasswordController {
  String? validate(String senha) {
    senha = senha.trim();

    if (senha.length < 8) {
      return "Regra 1: sua senha deve conter pelo menos 8 caracteres!";
    }
    if (!RegExp(r'\d').hasMatch(senha)) {
      return "Regra 2: sua senha deve incluir pelo menos um número.";
    }
    if (!RegExp(r'[!@#\$%^&*()_\+\-\=\[\]\{\};:,.<>?]').hasMatch(senha)) {
      return "Regra 3: inclua um caractere especial.";
    }
    if (!RegExp(r'[A-Z]').hasMatch(senha)) {
      return "Regra 4: inclua pelo menos uma letra MAIÚSCULA.";
    }

    final numbers = RegExp(r'\d').allMatches(senha).map((m) => int.parse(m.group(0)!)).toList();
    if (numbers.fold(0, (a, b) => a + b) != 24) {
      return "Regra 5: a soma dos números da sua senha devem ser o resultado de 4!(fatorial)";
    }

    const dias = [
      'segunda-feira','terça-feira','quarta-feira','quinta-feira','sexta-feira','sabado','domingo', 'segunda','terca','quarta','quinta','sexta','sabado','domingo'
    ];
    final low = senha.toLowerCase();
    if (!dias.any((d) => low.contains(d))) {
      return "Regra 6: inclua um dia da semana.";
    }

    if (!senha.contains("3")) {
      return "Regra 7: sua senha deve incluir o decimal correspondente a '0011'!";
    }

    if (!RegExp(r'[IVXLCDM]').hasMatch(senha)) {
      return "Regra 8: inclua um número romano.";
    }

    if (!senha.contains("VA")) {
      return "Regra 9: sua senha deve incluir a sigla do menor país do mundo!";
    }

    const fib = {1,2,3,5,8};
    for (final d in numbers) {
      if (!fib.contains(d)) return "Regra 10: números devem estar na sequência de Fibonacci.";
    }

    if (!senha.contains("L")) {
      return "sua senha deve incluir o último termo da equação de Drake!";
    }

    final romanValues = {'I':1,'V':5,'X':10,'L':50,'C':100,'D':500,'M':1000};
    var soma = 0;
    for (final ch in senha.split('')) {
      soma += romanValues[ch] ?? 0;
    }
    if (soma != 191) return "Regra 12: soma dos romanos deve ser 191.";

    if (!senha.contains("IFCE")) {
      return 'Inclua na senha " .. ..-. -.-. . "';
    }

    if (!senha.contains("PWV")) {
      return "Regra 14: A senha deve conter a sigla dos criadores!";
    }

    return null;
  }
}
