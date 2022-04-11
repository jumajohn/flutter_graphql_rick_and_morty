const String readCharactersRepositories = '''
        query params(\$page:Int!){
      characters(page:\$page){


        info{
              count
              pages
        }

      results{

            id
            name
            status
            species
            type
            gender
            origin{
              id
              name
            }
            image
            created
            location{
                    id
                    name
                    type
                    dimension
                    created
             }

            episode{

                    id
                    episode
                    name
                    air_date
                    created
            }

         }

    }
 }
      ''';
