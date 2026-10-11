-- schemaVersion 1
---
CREATE TABLE "accounts" ("archived_at" INTEGER NULL, "id" TEXT NOT NULL, "name" TEXT NOT NULL, "kind" INTEGER NOT NULL, "owner_person_id" TEXT NULL REFERENCES persons (id), "is_main" INTEGER NOT NULL DEFAULT 0 CHECK ("is_main" IN (0, 1)), "interest_rate" REAL NULL, "balance_cents" INTEGER NULL, "notes" TEXT NULL, "created_at" INTEGER NOT NULL, "updated_at" INTEGER NOT NULL, PRIMARY KEY ("id"));
---
CREATE TABLE "app_settings" ("id" INTEGER NOT NULL DEFAULT 1, "onboarding_completed" INTEGER NOT NULL DEFAULT 0 CHECK ("onboarding_completed" IN (0, 1)), "app_lock_enabled" INTEGER NOT NULL DEFAULT 0 CHECK ("app_lock_enabled" IN (0, 1)), "rule_needs" INTEGER NOT NULL DEFAULT 50, "rule_wants" INTEGER NOT NULL DEFAULT 30, "rule_savings" INTEGER NOT NULL DEFAULT 20, "split_mode" INTEGER NOT NULL DEFAULT 0, PRIMARY KEY ("id"));
---
CREATE TABLE "budget_items" ("archived_at" INTEGER NULL, "id" TEXT NOT NULL, "category_id" TEXT NOT NULL REFERENCES categories (id), "label" TEXT NOT NULL, "amount_cents" INTEGER NOT NULL, "interval" INTEGER NOT NULL DEFAULT 0, "payer_person_id" TEXT NULL REFERENCES persons (id), "beneficiary_person_id" TEXT NULL REFERENCES persons (id), "account_id" TEXT NULL REFERENCES accounts (id), "bucket_override" INTEGER NULL, "tag" TEXT NULL, "provider" TEXT NULL, "contract_number" TEXT NULL, "phone" TEXT NULL, "due_month" INTEGER NULL, "savings_potential_cents" INTEGER NULL, "target_cents" INTEGER NULL, "notes" TEXT NULL, "created_at" INTEGER NOT NULL, "updated_at" INTEGER NOT NULL, PRIMARY KEY ("id"));
---
CREATE TABLE "categories" ("archived_at" INTEGER NULL, "id" TEXT NOT NULL, "name" TEXT NOT NULL, "system_key" TEXT NULL, "icon" TEXT NOT NULL DEFAULT 'category', "bucket" INTEGER NOT NULL, "sort_order" INTEGER NOT NULL DEFAULT 0, "created_at" INTEGER NOT NULL, "updated_at" INTEGER NOT NULL, PRIMARY KEY ("id"));
---
CREATE TABLE "incomes" ("archived_at" INTEGER NULL, "id" TEXT NOT NULL, "person_id" TEXT NOT NULL REFERENCES persons (id), "label" TEXT NOT NULL, "net_cents" INTEGER NOT NULL, "gross_cents" INTEGER NULL, "interval" INTEGER NOT NULL DEFAULT 0, "notes" TEXT NULL, "created_at" INTEGER NOT NULL, "updated_at" INTEGER NOT NULL, PRIMARY KEY ("id"));
---
CREATE TABLE "persons" ("archived_at" INTEGER NULL, "id" TEXT NOT NULL, "name" TEXT NOT NULL, "color_index" INTEGER NOT NULL DEFAULT 0, "sort_order" INTEGER NOT NULL DEFAULT 0, "created_at" INTEGER NOT NULL, "updated_at" INTEGER NOT NULL, PRIMARY KEY ("id"));
