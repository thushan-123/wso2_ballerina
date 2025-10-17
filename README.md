
# WSO2 API Gateway and Ballerina Integration Project

## Architecture



Client --> WSO2 API Gateway --> Ballerina Integration --> Express.js (student operations)



- **Client**: client sends http req to APi endpoints   
- **WSO2 API Gateway**: exposes endpoints to external client, manages  authentication, authorization.  
- **Ballerina Integration**: Middleware service that forwards API requests to the Express.js backend.  
- **Express.js**: CRUD API for managing student data, stores data in a JSON file.


## Features

- **Express.js API**
  - CRUD operations for students: Create, Read, Update, Delete
  - Data stored in `data/students.json`
  - Exposes REST API at port `3000`

- **Ballerina Integration**
  - Proxies requests to Express API endpoints
  - Exposes Rest  API endpoints at port 9090

- **WSO2 API Gateway**
  - API management, authentication
  - Access endpoints via HTTP (`8280`) or HTTPS (`8243`)
  - Admin console at `9443` with configurable username/password

---

## Setup and Run

1. Clone the repository and navigate to the project root:



2. Update **WSO2 admin credentials** in `docker-compose.yml` if needed:

```yaml
environment:
  - WSO2_ADMIN_USERNAME=admin
  - WSO2_ADMIN_PASSWORD=password
```

3. Start all services using Docker Compose:

```bash
docker compose up --build
```

<p>
Service	URL
Express.js API	http://localhost:3000

Ballerina Service	http://localhost:9090/studentService

WSO2 API Gateway	Management Console: https://localhost:9443

                    HTTP API: http://localhost:8280

                    HTTPS API: https://localhost:8243
</p>
## Testing the API

### Using Ballerina service directly:

* Get all students:

```bash
curl http://localhost:9090/studentService/getAll
```

* Get a student by ID:

```bash
curl http://localhost:9090/studentService/getById?id=1
```

* Add a new student:

```bash
curl -X POST http://localhost:9090/studentService/add \
-H "Content-Type: application/json" \
-d '{"name":"Thush","age":22,"grade":"A"}'
```

### Using WSO2 API Gateway:


```bash
curl -u admin:password http://localhost:8280/studentService/getAll
```



