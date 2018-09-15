# Frogogo-API

Rails API for a simple user administration system.

# Features

- Authentication with JWT tokens
- Perform CRUD operations on Users

# Technologies

- Ruby on Rails
- PostgreSQL

# Deployment and CI/CD

Deploy to AWS on push/merge to master if tests pass, keywords:

- CircleCI
- Capistrano
- AWS
- Amazon RDS

# Endpoints

All endpoints are protected and require authentication with JSON Web Tokens (JWT)
The following endpoint can be accessed using `http://ec2-18-216-160-159.us-east-2.compute.amazonaws.com` host

## Authentication

```http
POST /signin
```

#### Data

| name              | type   | notes                                    |
| :---------------- | :----- | :--------------------------------------- |
| auth              | object | **required.**                            |
| auth.phone_number | string | **required.** (test with: "123-123-123") |
| auth.password     | string | **required.** (test with: "password")    |

#### Request body example

    http://ec2-18-216-160-159.us-east-2.compute.amazonaws.com/signin

    json
    {
      "auth": {
        "phone_number": "123-123-123",
        "password": "password"
      }
    }

#### Response

    Status 201 Created

    json
    {
      "jwt": "eyJ0eXAiOiJzI1NiJ9.eyJleHAiOjE1MzcwOTc1NDcsInN1YiI.V3WjeYFN1sazil7b28e0FhgD_SQnP9OR4w0eJ3sNfic"
    }

## Get list of all users

```http
GET /api/v1/users
```

#### Headers

| name          | notes                             |
| :------------ | :-------------------------------- |
| Authorization | Ex: BEARER {post here JWT string} |
| Content-Type  | application/json                  |

#### Response

    Status 200 Ok

    json
    {
    "data": [
        {
            "id": "1",
            "type": "users",
            "attributes": {
                "phone-number": "123-123-123",
                "name": "John Doe"
            }
        },
        {
            "id": "2",
            "type": "users",
            "attributes": {
                "phone-number": "321-321-321",
                "name": "Fred White"
            }
        }
    ]

}

## Get a single user

```http
GET /api/v1/users/:user_id
```

#### Headers

| name          | notes                             |
| :------------ | :-------------------------------- |
| Authorization | Ex: BEARER {post here JWT string} |
| Content-Type  | application/json                  |

#### Response

    Status 200 Ok

    json
    {
      "data": {
        "id": "1",
        "type": "users",
        "attributes": {
          "phone-number": "123-123-123",
          "name": "John Doe"
        }
      }
    }

## Create a user

```http
POST /api/v1/users
```

#### Headers

| name          | notes                             |
| :------------ | :-------------------------------- |
| Authorization | Ex: BEARER {post here JWT string} |
| Content-Type  | application/json                  |

#### Data

| name              | type   | notes                                    |
| :---------------- | :----- | :--------------------------------------- |
| user              | object | **required.**                            |
| user.phone_number | string | **required.** **unique.**                |
| user.name         | string | **required.**                            |
| user.password     | string | **required.** **4-32 chars**             |

#### Request body example

    ec2-18-216-160-159.us-east-2.compute.amazonaws.com/api/v1/users

    json
    {
	    "user": {
    	  "phone_number": "111-111-111",
    	  "name": "Fred White",
    	  "password": "password"
	    }
    }

#### Response

    Status 201 Created

    json
    {
      "data": {
        "id": "4",
        "type": "users",
        "attributes": {
          "phone-number": "111-111-111",
          "name": "Fred White"
        }
      }
    }

## Update a user

```http
PATCH /api/v1/users/:user_id
```

#### Headers

| name          | notes                             |
| :------------ | :-------------------------------- |
| Authorization | Ex: BEARER {post here JWT string} |
| Content-Type  | application/json                  |

#### Data

| name              | type   | notes                                    |
| :---------------- | :----- | :--------------------------------------- |
| phone_number      | string | **unique.**                              |
| name              | string |                                          |
| password          | string | **4-32 chars**                           |

#### Request body example

    ec2-18-216-160-159.us-east-2.compute.amazonaws.com/api/v1/users/4

    json
    {
      "name": "Updated name",
      "password": "updated_password"
    }

#### Response

    Status 200 Ok

    json
    {
      "data": {
        "id": "4",
        "type": "users",
        "attributes": {
          "phone-number": "111-111-111",
          "name": "Updated name"
        }
      }
    }