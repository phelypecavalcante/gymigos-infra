# Auth Flow

Sequence diagram for registration, login, token refresh, and logout.

## Register

```mermaid
sequenceDiagram
  actor User
  participant Client as Web / Mobile
  participant API as gymigos-api
  participant DB as PostgreSQL

  User->>Client: Fill registration form
  Client->>API: POST /auth/register
  API->>DB: Check email/username uniqueness
  DB-->>API: OK
  API->>DB: Insert user (hashed password)
  DB-->>API: User created
  API-->>Client: 201 UserResponse
  Client-->>User: Registration successful
```

## Login

Clients send `X-Client-Type: web | mobile` to identify the session type. Each user may have at most one active session per client type — logging in replaces the previous session of the same type atomically.

```mermaid
sequenceDiagram
  actor User
  participant Client as Web / Mobile
  participant API as gymigos-api
  participant DB as PostgreSQL

  User->>Client: Enter email + password
  Client->>API: POST /auth/login (X-Client-Type: web|mobile)
  API->>DB: Fetch user by email
  DB-->>API: User record
  API->>API: Verify password hash
  API->>DB: Upsert refresh token by (user_id, client_type)
  Note over DB: Replaces existing session for that client type
  DB-->>API: OK
  API-->>Client: 200 UserResponse + Set-Cookie (access_token, refresh_token)
  Client-->>User: Logged in
```

## Token Refresh

```mermaid
sequenceDiagram
  participant Client as Web / Mobile
  participant API as gymigos-api
  participant DB as PostgreSQL

  Client->>API: POST /auth/refresh (refresh_token cookie)
  API->>DB: Validate token hash + expiry
  DB-->>API: Token valid
  API-->>Client: 204 + Set-Cookie (new access_token)
```

## Logout

```mermaid
sequenceDiagram
  actor User
  participant Client as Web / Mobile
  participant API as gymigos-api
  participant DB as PostgreSQL

  User->>Client: Click logout
  Client->>API: POST /auth/logout (refresh_token cookie)
  API->>DB: Delete refresh token by hash
  DB-->>API: OK
  API-->>Client: 204 + Clear cookies
  Client-->>User: Logged out
```
