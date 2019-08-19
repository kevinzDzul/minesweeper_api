# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version is  2.5

* commant to run project

```
bundle install
rake db:create
rake db:migrate
rails s
``` 

* use schema pojo to build my json structure  http://www.jsonschema2pojo.org
in root project have a schema.json contain a example.


this is my structure
```
{

    "id": integer,
    "name": string,
    "row": integer,
    "column": integer,
    "mines": integer,
    "cell_open": integer,
    "status": string,
    "created_at": string,
    "updated_at": string,
    "board":[
    
      {
        "row":integer,
        "grid":[
            {
                "column":integer,
              "is_mine":boolean,
              "open": boolean,
              "near_mine":integer
                 
            
           },
           {
                "column":integer,
              "is_mine":boolean,
              "open": boolean,
              "near_mine":integer
            
           },
           {
                "column":integer,
              "is_mine":boolean,
              "open": boolean,
              "near_mine":integer
            
           },
               {
                "column":integer,
              "is_mine":boolean,
              "open": boolean,
              "near_mine":integer
            
           },
           {
                "column":integer,
              "is_mine":boolean,
              "open": boolean,
              "near_mine":integer
            
           }
        ]
      }
      ........
    ]
  }
```

