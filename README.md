# Setup da api

- Instale as dependencias com `bundle install`
- Use `rails dev:setup` para criar o banco de dados e rodar as migrations
- Crie o arquivo `.env` utilizando como exemplo o arquivo: `.env-model.txt`
- Inicie o servidor com `rails s`
- Para vizualizar a documentação da API va para o endereço: `http://localhost:3000/api-docs/`

## Testes
Para rodar os testes unitarios utilize o comando `bundle exec rspec spec`


# Obsevações
### Autenticação de usuários
Utilizei `devise` para fazer a autenticação de usuarios e a gem `cancancan` para administrar o nivel de acesso de cada usuario nas rotas (apenas admins podem criar, editar e apagar produtos e skus).

### Paginação
Utilizei a gem `kaminari` para adicionar paginação nas requisições de produtos e skus pois acredito ser a maneira mais simples.