# frozen_string_literal: true

class GithubUserInfosView < ActiveRecord::Migration[6.0]
  def up
    execute <<~SQL
      CREATE VIEW github_user_infos (id, user_id, screen_name, github_user_id, created_at, updated_at)
      AS SELECT id, user_id, info->>'nickname', provider_uid::integer, created_at, updated_at
      FROM user_associated_accounts WHERE provider_name = 'github' AND user_id IS NOT NULL;
    SQL
  end

  def down
    execute <<~SQL
      DROP VIEW github_user_infos;
    SQL
  end
end
