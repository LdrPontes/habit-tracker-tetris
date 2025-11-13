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

    %% Skin from groups that are assets, not just colors
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

    user_skins {
        uuid id PK
        uuid user_id FK "User ID (NOT NULL, indexed, CASCADE DELETE)"
        uuid skin_id FK "Skin ID (NOT NULL, indexed)"
        timestamp created_at
        timestamp updated_at
    }

    pieces {
        uuid id PK
        text name "Piece Name (ex: I, O, T, S, Z, J, L) (UNIQUE)"
        jsonb shape "2D matrix representing the piece shape"
        jsonb default_skin "default piece_skin"
        enum piece_size "size of the piece (SMALL, MEDIUM, LARGE)"
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
        int order "Task Order (UNIQUE(user_id, order) WHERE deleted_at IS NULL)"
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at "Soft delete (nullable)"
    }

    boards {
        uuid id PK
        uuid user_id FK "User ID (NOT NULL, indexed, CASCADE DELETE)"
        jsonb grid "current board grid (2D matrix)"
        jsonb placed_pieces "array of placed pieces (denormalized data, includes piece, skin, position, task info)"
        timestamp created_at
        timestamp updated_at
    }

    %% Will be deleted when piece is placed on the board
    user_pieces {
        uuid id PK
        uuid user_id FK "User ID (NOT NULL, indexed, CASCADE DELETE)"
        jsonb task_snapshot "Task snapshot (preserves task data when task is soft-deleted)"
        timestamp earned_at "When task was completed (NOT NULL)"
        timestamp created_at
        timestamp updated_at
    }

    user_onboarding {
        uuid id PK
        uuid user_id FK "User ID (NOT NULL, indexed, CASCADE DELETE)"
        timestamp completed_at "When onboarding was completed (NOT NULL)"
        jsonb questions_answers "Questions and answers"
        text version "Onboarding version (NOT NULL). Format: 1.0.0"
        timestamp created_at
        timestamp updated_at
    }

    user_transactions {
        uuid id PK
        uuid user_id FK "User ID (NOT NULL, indexed, SET NULL ON USER DELETE)"
        text description "Transaction Description (NULLABLE)"
        int amount "Transaction Amount (NOT NULL). Positive for COIN_PURCHASE, ACHIEVEMENT_EARNED, negative for SKIN_PURCHASE"
        text transaction_type "Transaction Type (COIN_PURCHASE, SKIN_PURCHASE, ACHIEVEMENT_EARNED)"
        timestamp created_at "When transaction was created (NOT NULL)"
        timestamp updated_at "When transaction was updated (NOT NULL)"
    }

    user_rewards {
        uuid id PK
        text description "Reward Description (NULLABLE)"
        uuid user_id FK "User ID (NOT NULL, indexed, SET NULL ON USER DELETE)"
        text reward_type "Reward Type (COIN, SKIN) (NOT NULL)"
        int coin_amount "Coin Amount (NULLABLE). Only for COIN rewards"
        uuid skin_id FK "Skin ID (NULLABLE, indexed, SET NULL ON SKIN DELETE)"
        timestamp created_at "When reward was created (NOT NULL)"
        timestamp updated_at "When reward was updated (NOT NULL)"
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
    users ||--|| user_onboarding : "has one"
    users ||--o{ user_transactions : "has many (SET NULL ON USER DELETE)"
    users ||--o{ user_rewards : "has many (SET NULL ON USER DELETE)"
    users ||--o{ user_skins : "has many"
    user_skins ||--o{ skins : "references (CASCADE DELETE)"
    user_rewards ||--o{ skins : "references (SET NULL ON SKIN DELETE)"
```

# Types

## piece_skin (JSONB)
```json
{  
  "id": "uuid", // skin.id | null if not in a skin_group (like default_skin)
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
        "id": "uuid", // skin.id | null if not in a skin_group (like default_skin)
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
            "id": "uuid", // skin.id | null if not in a skin_group (like default_skin)
            "type": "color" | "svg",
            "value": "hex" | "string",
        }
    }
}
```