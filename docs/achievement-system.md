# Achievement System Implementation Plan

## Overview

This document outlines the implementation plan for an achievement system integrated into the board game. Achievements are horizontal sections of the board (defined by y-coordinates) that grant rewards when specific conditions are met between two achievement lines.

A user **only earns an achievement** when, between two achievement lines, they satisfy a **rule**.

---

## Database Schema

### New Tables

#### `achievements`
Defines available achievements with their rules and rewards.

```
achievements {
    uuid id PK
    text name "Achievement Name (NOT NULL)"
    text description "Achievement Description (nullable)"
    int start_line_y "Start Y-coordinate (NOT NULL). Achievement line start"
    int end_line_y "End Y-coordinate (NOT NULL). Achievement line end"
    text rule_type "Rule Type (NOT NULL). Examples: PERCENTAGE_FILLED, LARGE_BLOCKS_COUNT, TOTAL_PIECES, etc."
    jsonb rule_params "Rule Parameters (NOT NULL). Flexible JSON for rule-specific config"
    jsonb rewards "Rewards JSONB (NOT NULL). Array of reward definitions"
    int order "Display Order (nullable). For sorting achievements"
    boolean is_active "Is Active (NOT NULL, default true). Can disable achievements"
    timestamp created_at
    timestamp updated_at
    timestamp deleted_at "Soft delete (nullable)"
}
```

**Rewards Example:**
```json
[
  { "type": "COIN", "amount": 100 },
  { "type": "SKIN", "skin_id": "uuid" }
]
```

#### `user_achievements`
Tracks which achievements each user has earned.

```
user_achievements {
    uuid id PK
    uuid user_id FK "User ID (NOT NULL, indexed, CASCADE DELETE)"
    uuid achievement_id FK "Achievement ID (NOT NULL, indexed)"
    timestamp earned_at "When achievement was earned (NOT NULL)"
    timestamp created_at
    timestamp updated_at
    UNIQUE(user_id, achievement_id) "Prevent duplicate achievements"
}
```

### Relationships

```
achievements ||--o{ user_achievements : "earned by users"
users ||--o{ user_achievements : "has many (CASCADE DELETE)"
```

---

## Data Flow

### Step 1: Piece Placement
- User places piece → `boards.placed_pieces` updated with new piece data (including `y` position)

### Step 2: Achievement Line Detection
- On piece placement, identify which achievement sections (between `start_line_y` and `end_line_y`) are affected
- Query active achievements where the new piece's y-coordinate falls within the range

### Step 3: Progress Calculation
- For each affected achievement, compute progress based on `rule_type`:
  - **PERCENTAGE_FILLED**: Count filled cells in `boards.grid` between `start_line_y` and `end_line_y`, divide by total cells in that range
  - **PIECE_VARIETY**: Count unique piece types in `boards.placed_pieces` where:
    - `y` is between `start_line_y` and `end_line_y`
  - **SIZE_DIVERSITY**: Count pieces of all three sizes in `boards.placed_pieces` where:
    - Piece size is either SMALL, MEDIUM, or LARGE
    - `y` is between `start_line_y` and `end_line_y`
  - Other rule types can be added similarly

### Step 4: Achievement Validation
- Check if calculated progress meets the rule threshold
- Verify user hasn't already earned it (check `user_achievements`)
- If satisfied:
  1. Insert record into `user_achievements`
  2. Create reward records in `user_rewards` (one per reward in `achievements.rewards`)
  3. Create transaction record in `user_transactions` with `transaction_type = 'ACHIEVEMENT_EARNED'` and `amount = sum of coin rewards`

### Step 5: Reward Distribution
- Use existing `user_rewards` table:
  - For COIN rewards: create `user_rewards` with `reward_type = 'COIN'` and `coin_amount`
  - For SKIN rewards: create `user_rewards` with `reward_type = 'SKIN'` and `skin_id`
- Use existing `user_transactions` table:
  - Create transaction with `transaction_type = 'ACHIEVEMENT_EARNED'` and positive `amount` (sum of all coin rewards)

---

## Design Decisions

### Why Separate `achievements` and `user_achievements`?
- **`achievements`**: Template definitions (reusable across users)
- **`user_achievements`**: User-specific completion tracking
- Enables adding new achievements without schema changes

### Why JSONB for `rule_params` and `rewards`?
- **Flexibility**: Different rule types need different parameters
- **Extensibility**: Easy to add new rule types without schema changes
- **Simplicity**: Can store multiple rewards per achievement

### Why Reuse `user_rewards` and `user_transactions`?
- **Consistency**: Same reward flow as other game mechanics
- **Simplicity**: No duplicate reward logic
- **Unified history**: All rewards in one place

### Achievement Lines as Y-Coordinates
- **Simple**: Just two integers (`start_line_y`, `end_line_y`)
- **Infinite board**: Works with infinite board concept
- **Easy queries**: `WHERE y BETWEEN start_line_y AND end_line_y`

---

## Example Scenarios

### Scenario 1: Percentage Filled Achievement
```
Achievement: "Fill 75% of lines 0-10"
- start_line_y: 0
- end_line_y: 10
- rule_type: "PERCENTAGE_FILLED"
- rule_params: { "threshold": 0.75 }
- rewards: [{ "type": "COIN", "amount": 50 }]
```

**When user places piece at y=5:**
1. Check if piece is in range [0, 10] → Yes
2. Calculate: filled cells in grid[0:10] / total cells in grid[0:10]
3. If ≥ 0.75 → Grant achievement and reward

### Scenario 2: Piece Variety Achievement
```
Achievement: "Place 5 different piece types in lines 20-30"
- start_line_y: 20
- end_line_y: 30
- rule_type: "PIECE_VARIETY"
- rule_params: { "min_unique_pieces": 5, "piece_names": ["I", "O", "T", "S", "Z", "J", "L"] }
- rewards: [{ "type": "SKIN", "skin_id": "uuid" }]
```

**When user places large piece at y=25:**
1. Check if piece is in range [20, 30] → Yes
2. Count large pieces in placed_pieces where y ∈ [20, 30]
3. If count ≥ 5 → Grant achievement and reward

---

## Implementation Notes

### Performance Considerations
- **Indexing**: 
  - `user_achievements(user_id, achievement_id)` for duplicate checks
  - `achievements(start_line_y, end_line_y, is_active)` for range queries
- **Caching**: Consider caching active achievements to avoid repeated queries

### Validation Logic
- Implement rule evaluation in **application code** (not database)
- Can be a service/function that takes:
  - Achievement definition
  - Current board state (`boards.grid` and `boards.placed_pieces`)
  - Returns: progress percentage and whether threshold is met

### Extensibility
- **New rule types**: Just add new `rule_type` values and corresponding evaluation logic
- **New reward types**: Extend `user_rewards.reward_type` enum if needed
- **Multiple achievements per section**: Supported (multiple rows with overlapping y-ranges)

---

## Rule Types Reference

### Percentage-Based Rules
#### 1. **PERCENTAGE_FILLED**
Fill a section by a certain percentage.
```json
{
  "threshold": 0.75  // Must fill 75% of the section
}
```
**Example**: "Fill 75% of lines 0-10"

### Piece-Based Rules

#### 2. **PIECE_VARIETY**
Place different piece types in a section.
```json
{
  "min_unique_pieces": 5,  // Must use at least 5 different piece types
  "piece_names": ["I", "O", "T", "S", "Z", "J", "L"]  // Which pieces count
}
```
**Example**: "Use 5 different piece types between lines 0-10"

#### 3. **SIZE_DIVERSITY**
Place pieces of all three sizes in a section.
```json
{
  "require_all_sizes": true,  // Must have SMALL, MEDIUM, and LARGE
  "min_each_size": 1
}
```
**Example**: "Place 1 small, 1 medium, and 1 large piece between lines 0-10"

## Rule Implementation Notes

### Evaluation Complexity
- **Simple rules** (PERCENTAGE_FILLED, PIECE_VARIETY, SIZE_DIVERSITY): Can be evaluated in O(n) time

### Performance Optimization
- Cache achievement progress calculations
- Only re-evaluate achievements when pieces are placed in relevant y-ranges

### User Experience
- Start with simpler rules (PERCENTAGE_FILLED, PIECE_VARIETY, SIZE_DIVERSITY) for MVP
- Gradually introduce more complex rules as features
- Provide visual feedback when users are close to earning achievements
- Show progress indicators for multi-step achievements

### Validation
- Add validation in application code to ensure `rule_params` match the `rule_type`
- Validate that `start_line_y < end_line_y`
- Ensure rewards array contains valid reward types
- Check that referenced skin_ids exist in the `skins` table

---

## Summary

This achievement system provides:
- ✅ **Flexible rule system** with 30+ rule types
- ✅ **Simple database schema** (2 new tables)
- ✅ **Integration with existing rewards** (reuses `user_rewards` and `user_transactions`)
- ✅ **Extensible design** (easy to add new rule types)
- ✅ **Performance considerations** (indexing, caching strategies)
- ✅ **Creative engagement** (variety of challenges for players)

The system is designed to be simple to implement initially while allowing for rich, complex achievements as the game evolves.

