```mermaid
erDiagram
    skin_groups {
        uuid id PK
        text name "Group Name (UNIQUE)"
        text description "Group Description"
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at "Soft delete (nullable)"
    }

    skins {
        uuid id PK
        text name "Skin Name"
        text description "Skin Description"
        uuid skin_group_id FK "Skin Group ID (NOT NULL, indexed, CASCADE SOFT DELETE)"
        text asset "Asset"
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at "Soft delete (nullable)"
    }

    pieces {
        uuid id PK
        text name "Piece Name (ex: I, O, T, S, Z, J, L) (UNIQUE)"
        jsonb shape "2D matrix representing the piece shape"
        jsonb piece_skin "Piece Skin (color or SVG asset path)"
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at "Soft delete (nullable)"
    }

    tasks {
        uuid id PK
        uuid user_id FK "User ID (NOT NULL, indexed, CASCADE DELETE)"
        uuid piece_id FK "Piece ID (NOT NULL, indexed)"
        jsonb piece_skin "Piece Skin (color or SVG asset path)"
        text name "Task Name (NOT NULL)"
        text description "Task Description (nullable)"
        int order "Task Order (UNIQUE per user)"
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at "Soft delete (nullable)"
    }

    boards {
        uuid id PK
        uuid user_id FK "User ID (NOT NULL, indexed, CASCADE DELETE)"
        jsonb grid "current board grid (2D matrix)"
        jsonb placed_pieces "array of placed user_piece references"
        timestamp created_at
        timestamp updated_at
    }

    user_pieces {
        uuid id PK
        uuid user_id FK "User ID (NOT NULL, indexed, CASCADE DELETE)"
        jsonb task_snapshot "Task snapshot (for when task is deleted)"
        timestamp earned_at "When task was completed (NOT NULL)"
        timestamp created_at
        timestamp updated_at
    }

    user_onboarding {
        uuid id PK
        uuid user_id FK "User ID (NOT NULL, indexed, CASCADE DELETE)"
        timestamp completed_at "When onboarding was completed (NOT NULL)"
        jsonb questions_answers "Questions and answers"
        text version 
        timestamp created_at
        timestamp updated_at
    }

    %% Supabase Auth Users
    users {
        uuid id PK "Supabase Auth users.id"
        timestamp created_at
    }

    %% Relationships
    users ||--o{ tasks : "has many (CASCADE DELETE)"
    users ||--|| boards : "has one"
    users ||--o{ user_pieces : "has many (CASCADE DELETE)"
    pieces ||--o{ tasks : "used in"
    pieces ||--o{ user_pieces : "reference (nullable) via task_snapshot"
    tasks ||--o{ user_pieces : "reference (nullable, SET NULL) via task_snapshot"
    skin_groups ||--o{ skins : "has many"
    boards ||--o{ user_pieces : "references via placed_pieces"
    pieces ||--|| skins : "has one"
    users ||--|| user_onboarding : "has one"
```

# Types

## piece_skin (JSONB)
```json
{
  "type": "color" | "svg",
  "value": "hex" | "string",
}
```

## boards.placed_pieces (JSONB Array)
```json
[
  {
    "piece": {
      "id": "uuid", // piece.id
      "shape": "2D matrix representing the piece shape",
      "skin": { // piece_skin
        "type": "color" | "svg",
        "value": "hex" | "string",
      }
    },
    "x": "int", // column
    "y": "int", // row
    "rotation": "int",
    "placed_at": "timestamp",
    "task": {
        "name": "string",
        "created_at": "timestamp",
        "completed_at": "timestamp"
    }
  }
]
```
## user_pieces.task_snapshot (JSONB)
```json
{
    "name": "string",
    "created_at": "timestamp",
    "completed_at": "timestamp",
    "piece": {
        "id": "uuid", // piece.id
        "shape": "2D matrix representing the piece shape",
        "skin": { // piece_skin
            "type": "color" | "svg",
            "value": "hex" | "string",
        }
    }
}
```