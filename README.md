# Blog API

This is a simple blog API built with Ruby on Rails and PostgreSQL. The API includes user authentication and basic CRUD operations for posts.

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/CodingBeaXt/blog_api.git
cd blog_api
```

### 2. Install Dependencies
Make sure you have Ruby and Bundler installed. Then run:
```bash
bundle install
```
### 3. Set Up the Database
Make sure PostgreSQL is running and create the database:
```bash
rails db:create
rails db:migrate
```
You can also seed the database with an initial user:
```bash
rails db:seed
```
### 4. Run the Rails Server
Make sure you have Ruby and Bundler installed. Then run:
```bash
rails server
```
By default, the server runs on `http://localhost:3000`.

## Running Tests
To run the tests for this API:
```bash
rails test
```
Ensure that your test database is set up:
```bash
rails db:test:prepare
```
The test suite includes tests for the `PostsController` and `SessionsController`.

## API Endpoints
### 1. User Authentication
Login: `POST /login`

Request Body:
```bash
{
  "email": "test@example.com",
  "password": "password123"
}
```
Response:

```bash
{
  "auth_token": "your_auth_token"
}
```

Logout: `DELETE /logout`

Request Header:
```bash
Authorization: Token your_auth_token
```
Response:

```bash
{
  "message": "Logged out successfully"
}
```

### 2. Posts
List All Posts: `GET /posts`

Response:
```bash
[
  {
    "id": 1,
    "title": "First Post",
    "content": "This is the content of the first post.",
    "user_id": 1,
    "created_at": "2024-08-15T12:34:56.789Z",
    "updated_at": "2024-08-15T12:34:56.789Z"
  },
  ...
]

```

Show a Specific Post: `GET /posts/:id`

Response:
```bash
{
  "id": 1,
  "title": "First Post",
  "content": "This is the content of the first post.",
  "user_id": 1,
  "created_at": "2024-08-15T12:34:56.789Z",
  "updated_at": "2024-08-15T12:34:56.789Z"
}
```

Create a New Post: `POST /posts`

Request Header:
```bash
Authorization: Token your_auth_token
```
Request Body:
```bash
{
  "post": {
    "title": "New Post",
    "content": "This is my post content."
  }
}
```
Response:
```bash
{
  "id": 2,
  "title": "New Post",
  "content": "This is my post content.",
  "user_id": 1,
  "created_at": "2024-08-15T12:35:56.789Z",
  "updated_at": "2024-08-15T12:35:56.789Z"
}

```

### 2. Error Handling
Unauthorized Access: If you try to create a post without logging in, you'll receive an error:

Response:
```bash
{
  "error": "Unauthorized"
}
```

Post Not Found: If you try to access a post that doesn't exist:

Response:
```bash
{
  "error": "Post not found"
}
```
