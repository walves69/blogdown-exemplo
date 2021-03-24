# Blogdown Exemplo

- criei projeto no git
- clonei pra minha maquina
- entrei na pasta
- usethis::create_project(".") - imagem 001
- abre automaticamente outro rstudio, neste outro:
- blogdown::new_site(".", theme = "monkeyWzr/hugo-theme-cactus")
- como ficou após criar as pastas imagem 002
- perguntou se queria um preview. não.
- ajustei a url base
- ajustei a pasta onde serão gerados os arquivos finais

TLDR;



    Abrir o RStudio limpo (sem estar em nenhum projeto)

    Criar o projeto com git/github
        usethis::create_project()
        usethis::use_git()
        usethis::use_github()

    Criar o site com o pacote {blogdown}
        install.packages("blogdown")
        blogdown::new_site("caminho", theme = "usuario/repositorio")
        https://themes.gohugo.io/ para escolher temas

    Configurar o site no arquivo config.toml

    Mexer nos posts dentro da pasta content/post
        Usar blogdown::new_post() para criar novos pots.

    Rodar blogdown::serve_site() para testar local.

    Rodar blogdown::build_site() para montar o site final.

    Subir para o Github para colocar em produção (se estiver usando o GH pages)

 
