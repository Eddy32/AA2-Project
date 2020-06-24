# AA2-Project
Repositório dedicado ao projeto da unidade curricular de Aprendizagem Automática 2 do perfil de Data Science. Este repositório contém todos os ficheiros relativos à elaboração do trabalho prático e necessários ao seu teste, todavia devido à dimensão dos datasets e dos modelos guardados, disponibilizamos estes dados nos seguintes links:
  * [Versões reduzidas do dataset já pronto a ser utilizado em notebooks de redes](https://drive.google.com/drive/folders/1qb2-IsXkw4G-dug9CNsiD_-8PtruLJYU?usp=sharing)
  * [Modelos já treinados guardados para futuro carregamento](https://drive.google.com/drive/folders/1pg_f4ER_v8yb7BHu3CNvHjBCAqFC6AV7?usp=sharing)
  * [Dataset original completo pré-processamento](https://data.vision.ee.ethz.ch/cvl/rrothe/imdb-wiki/)

Este trabalho consiste no desenvolvimento de redes neuronais, capazes de identificar o genero e a idade de uma pessoa, utilizando apenas uma foto do seu rosto (especificamente de 256*256 pixeis).

# Considerações Iniciais:
Visto estarmos perante uma enorme área como Data Science, consideramos relevante para o trabalho, uma fase inicial de pesquisa relativa ao estado da arte de um problema como este, de modo a criar perspetivas realistas dos resultados possiveis e esperados de obter.

Assim, verificamos uma enorme consistência entre toda a comunidade, relativamente à abordagem como problema de classificação e a utilização de 8 bins standard (em vez de prever a idade exata da pessoa, prever dentro de um certo intervalo pré-definido).
Todavia, estes eram compostos por intervalos não contíguos, ou seja, os bins não eram adjacentes (eg, 25-32 e 38-43), algo que consideramos uma "batota" e "simplificação" do problema, tendo em conta que no nosso dataset possuiamos entradas para todos as idades. Deste modo, utilizamos na mesma 8 bins que mantivessem a distribuição normal dos dados, mas que fossem contínuos, de modo a não ser necessário descartar entradas do dataset. Todavia, apenas consideramos fotos de pessoas entre 18 a 65 anos, visto que estas extremidades eram muito reduzidas no dataset e inconclusivas para aprendizagem.

Visto que todo o processamento e treino das redes é algo bastante penoso a um nivel computacional, decidimos optar pela utilização de tensorflow-gpu. Deste modo, fomos capazes de treinar as redes utilizando os recursos disponibilizados pela placa gráfica, adicionalmente, visto que as redes a serem utilizadas serão CNN's, o aumento de performance é significativo (maior parte dos calculos são produtos matriciais que ocorrem muito mais eficientemente numa gráfica dedicada, devido ao elevado número de CUDA cores).

![1.2](./img/sota.png)
Tal como se pode ver na imagem acima, este é o estado da arte relativamente a este problema e apesar da nossa abordagem ser distinta e num dataset diferente, iremos ao máximo tentar aproximar-nos desta métrica (sendo que a utilização de 8 bins contíguo torna bastante mais complexa esta meta).

# Abordagem:
Numa primeira instancia, foi necessário o processamento do ficheiro matlab proveniente do dataset, de modo a gerar-se o result.csv (ficheiro que contem todas as labels de todas as fotos). De seguida, foi necessária a implementação de um notebook que fosse capaz de processar todas estas fotos e gerar ficheiros de dimensão desejada (considerando qual a funcionalidade que se deseja testar e onde -> visto a dimensão dos ficheiros cresce significativamente com o número de fotos) para um posterior processamento.

Neste ponto, somos capazes de nos afastar do dataset "nativo" e apenas usar estes ficheiros gerados para os treinos das redes, podendo assim faze-lo em qualquer máquina sem necessidade da pasta com todas as fotos. Aqui, a abordagem a seguir foi a criação de múltiplas redes distintas e sucessivo teste das mesmas, de modo a obter a melhor solução possível para o problema proposto. 

Assim, a nossa linha de teste foi a seguinte:
* **[PCA Age](https://github.com/Eddy32/AA2-Project/blob/master/PCAAge.ipynb):** fase inicial de utilização das *principal components*
*  **[VGG_Face Age](https://github.com/Eddy32/AA2-Project/blob/master/VGGFaceAge.ipynb):** fase intemédia utilização da rede VGG_Face
*  **[Xception Age](https://github.com/Eddy32/AA2-Project/blob/master/XceptionAge.ipynb):** fase conclusiva -> melhor rede para o problema de idade
*  **[Xception Gender](https://github.com/Eddy32/AA2-Project/blob/master/GenderXception.ipynb):** utilização da Xception para classificação do géreno

Por fim, consideramos também interessante, uma tentativa de abordagem a este desafio, como um problema de regressão. Deste modo desenvolvemos um notebook com 2 redes diferentes para a previsão de idades, tentando obter sucesso também por esta frente:
*  **[Previsão Idade Regressão](https://github.com/Eddy32/AA2-Project/blob/master/AgeEstimationRegression.ipynb):** abordagem por regressão ao problema de estimação de idade



considerando que até foi de relativo sucesso para a abordagem em si (desvio até ±10anos), mas sempre pior que a solução obtida com a Xception.

# Resultados Obtidos:
Após todo o trabalho desenvolvido, consideramos de sucesso as seguintes abordagens (sendo essas expostas aqui, mas todos os notebooks apresentam os resultados obtidos):
* #### Xception Idade

Esta foi a rede considerada de mais sucesso tanto para a previsão das idades como de género. Esta, como se pode observar pelas figura abaixo, para o problema de idade obteve uma accuracy total de 44.16% (a 15% do state of the art) e uma precisão por 1 Off de 82.64% (< 8% do state of the art). Não só consideramos de sucesso os valores obtidos pela "elevada" precisão para o problema que é, como pela aproximação significativa ao SotA numa versão do problema, que a nosso ver é um pouco mais complexa.

![acc1off](./img/acc1off.png)

Consideramos também relevante os valores de 1Off e de Accuracy para cada bin específico, de modo a tornar os resultados obtidos mais palpáveis (percebendo assim melhor onde esta acerta e erra).

![acc1offBC](./img/acc1offBC.png)

* #### Xception Género

Para a determinação do género, consideramos de extremo sucesso e precisão a rede Xception, tendo assim obtido uma accuracy de 91.38% em fase de testes.

* #### Regressão
Apesar de esta abordagem não nos ter dado resultados tão bons como previamente obtidos (utlização da Xception), consideramos que um mae de ±10 (ou seja, que uma previsão estará até ±10 anos errada), algo relativamente positivo. 

## Conclusão
Após todo o trabalho concluído, consideramos que obtivemos uma resolução de sucesso, sendo esta bastante capaz de responder as perguntas para as quais foi criada. Consideramos também, que na fase de escolha do projeto fomos um pouco "inocentes" na escolha deste tema, sem uma devida análise da complexidade da mesma, todavia foi um excelente desafio e meio de obtençao de conhecimentos extras, numa área tão crítica e atualmente relevante como Data Science.

