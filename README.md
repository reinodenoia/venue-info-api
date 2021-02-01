# README

#### Project information:
* Ruby version: 2.6.6
* Rails version: 6.0.2.2
* Database: postgresql
* Testing gem: rspec

#### Deployment instructions

The service will be up and running with the database created, its migrations executed and data populated.
```
clone the repository 
cd venue-info-api
docker-compose build
docker-compose up
```

#### How to run the test suite

```
docker-ps
get the container_id from venue-info-api_web_1 image
docker exec -it container_id bash 
bundle exec rspec
```

#### API endpoints
- GET /api/venues/1
- GET /api/venues/1/plaftorms
- GET /api/venues/1/platforms/1
- PATCH /api/venues/1

##### Examples
* Request
```
curl --location --request GET 'localhost:3000/api/venues/1'
```

* Response
```
{
    "data": {
        "id": 1,
        "name": "Waelchi-Lindgren",
        "address": "9821 Boehm Falls",
        "additional_address": "Apt. 127",
        "lat": 15.8928681484,
        "lng": 101.3330876089,
        "category": 0,
        "closed": true,
        "hours": [
            "10:00-22:00",
            "10:00-22:00",
            "10:00-22:00",
            "10:00-22:00",
            "10:00-22:00",
            "11:00-18:00",
            "11:00-18:00"
        ],
        "website": "https://www.localistico.com",
        "phone": "+34666999666",
        "created_at": "2021-02-01T19:58:03.841Z",
        "updated_at": "2021-02-01T19:59:10.173Z"
    }
}
```

* Request 
```
curl --location --request GET 'localhost:3000/api/venues/1/platforms'
```

* Response
```
{
    "data": [
        {
            "platform": "platform_a",
            "internal_id": 1,
            "id": 1,
            "name": "Waelchi-Lindgren",
            "address": "9821 Boehm Falls",
            "lat": "15.8928681484",
            "lng": "101.3330876089",
            "category_id": 1000,
            "closed": true,
            "hours": "10:00-22:00|10:00-22:00|10:00-22:00|10:00-22:00|10:00-22:00|11:00-18:00|11:00-18:00",
            "created_at": "2021-01-28T10:28:59.362Z",
            "updated_at": "2021-02-01T19:59:09.229Z",
            "api_key": "34da2ea215823f4305193cf87b37a9b7"
        },
        {
            "platform": "platform_b",
            "internal_id": 2,
            "id": 1,
            "name": "Waelchi-Lindgren",
            "street_address": "9821 Boehm Falls",
            "lat": "15.8928681484",
            "lng": "101.3330876089",
            "category_id": 2000,
            "closed": true,
            "hours": "Mon:10:00-22:00|Tue:10:00-22:00|Wed:10:00-22:00|Thu:10:00-22:00|Fri:10:00-22:00|Sat:11:00-18:00|Sun:11:00-18:00",
            "created_at": "2021-01-28T10:28:59.387Z",
            "updated_at": "2021-02-01T19:59:09.656Z",
            "api_key": "34da2ea215823f4305193cf87b37a9b7"
        },
        {
            "platform": "platform_c",
            "internal_id": 3,
            "id": 1,
            "name": "Waelchi-Lindgren",
            "address_line_1": "9821 Boehm Falls",
            "address_line_2": "Apt. 127",
            "website": "https://www.localistico.com",
            "phone_number": "+34666999666",
            "lat": "15.8928681484",
            "lng": "101.3330876089",
            "closed": true,
            "hours": "10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,11:00-18:00,11:00-18:00",
            "created_at": "2021-01-28T10:28:59.412Z",
            "updated_at": "2021-02-01T19:59:10.094Z",
            "api_key": "34da2ea215823f4305193cf87b37a9b7"
        }
    ]
}
```

* Request 
```
curl --location --request GET 'localhost:3000/api/venues/1/platforms/1'
```

* Response 
```
{
    "data": {
        "id": 1,
        "name": "Waelchi-Lindgren",
        "address": "9821 Boehm Falls",
        "lat": "15.8928681484",
        "lng": "101.3330876089",
        "category_id": 1000,
        "closed": true,
        "hours": "10:00-22:00|10:00-22:00|10:00-22:00|10:00-22:00|10:00-22:00|11:00-18:00|11:00-18:00",
        "created_at": "2021-01-28T10:28:59.362Z",
        "updated_at": "2021-02-01T19:59:09.229Z",
        "api_key": "34da2ea215823f4305193cf87b37a9b7"
    }
}
```

* Request 
```
curl --location --request PATCH 'localhost:3000/api/venues/1' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "Waelchi-Lindgren",
    "address": "9821 Boehm Falls",
    "additional_address": "Apt. 127",
    "lat": 15.8928681484,
    "lng": 101.3330876089,
    "website": "https://www.localistico.com",
    "phone": "+34666999666",
    "category": 0,
    "closed": true,
    "hours": ["10:00-22:00",
              "10:00-22:00",
              "10:00-22:00",
              "10:00-22:00",
              "10:00-22:00",
              "11:00-18:00",
              "11:00-18:00"]
}'
```
* Response 
```
{
    "data": {
        "name": "Waelchi-Lindgren",
        "address": "9821 Boehm Falls",
        "additional_address": "Apt. 127",
        "lat": 15.8928681484,
        "lng": 101.3330876089,
        "category": 0,
        "closed": true,
        "website": "https://www.localistico.com",
        "phone": "+34666999666",
        "hours": [
            "10:00-22:00",
            "10:00-22:00",
            "10:00-22:00",
            "10:00-22:00",
            "10:00-22:00",
            "11:00-18:00",
            "11:00-18:00"
        ],
        "id": 1,
        "created_at": "2021-02-01T19:58:03.841Z",
        "updated_at": "2021-02-01T19:59:10.173Z"
    }
}
```
