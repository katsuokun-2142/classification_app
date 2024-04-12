# README

## ER図
```mermaid
erDiagram
  category      ||--o{ web_site_info   : "1つのカテゴリは0以上のサイト情報を持つ"
  web_site_info }o--|{ sub_category    : "1つのサイト情報は1以上のサブカテゴリを持つ"
  web_site_info ||--|{ sinfo_scategory : "1つのサイト情報は1以上の中間テーブルを持つ"
  sub_category  ||--o{ sinfo_scategory : "1つのサブカテゴリは0以上の中間を持つ"

  category {
    bigint    id            PK
    string    category_name     "カテゴリ名"
    timestamp created_at
    timestamp updated_at
  }

  web_site_info {
    bigint     id            PK
    references category      FK  "カテゴリ"
    text       site_title        "サイトタイトル"
    text       summary_text      "要約文"
    text       site_URL          "サイトURL"
    timestamp  created_at
    timestamp  updated_at
  }

  sinfo_scategory {
    bigint     id             PK
    references web_site_info  FK  "サイト情報"
    references sub_category   FK  "サブカテゴリ"
    timestamp  created_at
    timestamp  updated_at
  }

  sub_category {
    bigint    id              PK
    text      scategory_name      "サブカテゴリ名"
    timestamp created_at
    timestamp updated_at
  }
```

## テーブル設計

### category（カテゴリ） テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| category_name      | string  | null: false |

#### Association

- has_many :web_site_info

### web_site_info（サイト情報） テーブル

| Column                   | Type       | Options     |
| ------------------------ | ---------- | ----------- |
| category                 | references | null: false, foreign_key: true |
| site_title               | text       | null: false |
| summary_text             | text       | null: false |
| site_URL                 | text       | null: false |

#### Association

- belongs_to :category
- has_many :sub_category, through: :sinfo_scategory
- has_many :sinfo_scategory

### sinfo_scategory（サイト情報とサブカテゴリの中間） テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| web_site_info | references | null: false, foreign_key: true |
| sub_category  | references | null: false, foreign_key: true |

#### Association

- belongs_to :web_site_info
- belongs_to :sub_category

### sub_category（サブカテゴリ） テーブル

| Column         | Type | Options     |
| -------------- | ---- | ----------- |
| scategory_name | text | null: false |

#### Association

- has_many :web_site_info, through: :sinfo_scategory
- has_many :sinfo_scategory
