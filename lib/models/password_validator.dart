class PasswordValidator {
  static String? validate(String senha) {
    // Rule checks return the message for the first failing rule or null if all pass.
    if (senha.length < 8) return "Regra 1: sua senha deve conter pelo menos 8 caracteres!";
    if (!RegExp(r'\d').hasMatch(senha)) return "Regra 2: sua senha deve conter pelo menos um número!";
    if (!RegExp(r'[!@#$%^&*()_+\-=\[\]{};:,.<>?]').hasMatch(senha)) return "Regra 3: adicione um caractere especial!";
    if (!RegExp(r'[A-Z]').hasMatch(senha)) return "Regra 4: adicione pelo menos uma letra MAIÚSCULA!";
    final digits = RegExp(r'\d').allMatches(senha).map((e) => int.parse(e.group(0)!)).toList();
    final sum = digits.fold(0, (a, b) => a + b);
    if (sum != 24) return "Regra 5: a soma dos números deve ser 24 (4 fatorial)!";
    const dias = ['segunda-feira','terça-feira','quarta-feira','quinta-feira','sexta-feira','sábado','domingo'];
    final lower = senha.toLowerCase();
    if (!dias.any((e) => lower.contains(e))) return "Regra 6: adicione um dia da semana!";
    if (!senha.contains('3')) return "Regra 7: inclua o decimal do binário 0011!";
    if (!RegExp(r'[IVXLCDM]').hasMatch(senha)) return "Regra 8: inclua um número romano!";
    if (!senha.contains('VA')) return "Regra 9: inclua VA (Vaticano)!";
    const fib = {1,2,3,5,8};
    for (var d in digits) { if (!fib.contains(d)) return "Regra 10: os números devem estar na sequência de Fibonacci!"; }
    if (!senha.contains('L')) return "Regra 11: inclua a letra L!";
    final romanValues = {'I':1,'V':5,'X':10,'L':50,'C':100,'D':500,'M':1000};
    int somaRomanos = 0;
    for (var ch in senha.split('')) somaRomanos += romanValues[ch] ?? 0;
    if (somaRomanos != 191) return "Regra 12: a soma dos números romanos deve ser 191!";
    if (!senha.contains("IFCE")) return "Regra 13: adicione IFCE!";
    if (!senha.contains("WVP")) return "Regra 14: A senha deve conter os criadores!";
    return null;
  }

  /// returns the first failing rule message (same as validate), or null if all pass.
  static String? nextRule(String senha) => validate(senha);
}
