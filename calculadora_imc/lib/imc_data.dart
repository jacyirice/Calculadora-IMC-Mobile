class ImcResult {
  final String img;
  final String interval;
  final String title;
  final String description;

  ImcResult(this.img, this.interval, this.title, this.description);
}

class ImcResults {
  final List results = [
    ImcResult("assets/img/imc_06.png", "18,5 ou menos", "Abaixo do normal",
        "Procure um médico. Algumas pessoas têm um baixo peso por características do seu organismo e tudo bem. Outras podem estar enfrentando problemas, como a desnutrição. É preciso saber qual é o caso."),
    ImcResult("assets/img/imc_05.png", "Entre 18,6 e 24,9", "Normal",
        "Que bom que você está com o peso normal! E o melhor jeito de continuar assim é mantendo um estilo de vida ativo e uma alimentação equilibrada."),
    ImcResult("assets/img/imc_04.png", "Entre 25,0 e 29,9", "Sobrepeso",
        "Ele é, na verdade, uma pré-obesidade e muitas pessoas nessa faixa já apresentam doenças associadas, como diabetes e hipertensão. Importante rever hábitos e buscar ajuda antes de, por uma série de fatores, entrar na faixa da obesidade pra valer."),
    ImcResult("assets/img/imc_03.png", "Entre 30,0 e 34,9", "Obesidade grau I",
        "Sinal de alerta! Chegou na hora de se cuidar, mesmo que seus exames sejam normais. Vamos dar início a mudanças hoje! Cuide de sua alimentação. Você precisa iniciar um acompanhamento com nutricionista e/ou endocrinologista."),
    ImcResult("assets/img/imc_02.png", "Entre 35,0 e 39,9", "Obesidade grau II",
        "Mesmo que seus exames aparentem estar normais, é hora de se cuidar, iniciando mudanças no estilo de vida com o acompanhamento próximo de profissionais de saúde."),
    ImcResult("assets/img/imc_01.png", "Acima de 40,0", "Obesidade grau III",
        "Aqui o sinal é vermelho, com forte probabilidade de já existirem doenças muito graves associadas. O tratamento deve ser ainda mais urgente."),
  ];
  ImcResults();

  ImcResult getMyImcResult(double peso, double altura) {
    double imc = peso / altura * altura;
    if (imc <= 18.5)
      return results[0];
    else if (imc <= 18.6 && imc <= 24.9)
      return results[1];
    else if (imc <= 25.0 && imc <= 29.9)
      return results[2];
    else if (imc <= 30.0 && imc <= 34.9)
      return results[3];
    else if (imc <= 35.0 && imc <= 39.9)
      return results[4];
    return results[5];
  }
}
