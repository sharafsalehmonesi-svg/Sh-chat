# SH-CHAT starter rebuild

## Files
- `index.html`: Arabic RTL social web app, persistent Supabase auth, feed, profile editing, friend requests and 1-to-1 text chat.
- `setup.sql`: initial schema, RLS policies, image bucket and Realtime setup.

## Setup
1. Back up the current project and database.
2. Open Supabase Dashboard → SQL Editor and inspect the existing schema.
3. Run `setup.sql`. It uses `create table if not exists`, but review existing table definitions/policies first.
4. Replace the repository's `index.html` with this `index.html`.
5. Ensure Supabase Auth email confirmation and redirect URLs include the actual deployed website URL.
6. Test using two separate user accounts and two separate browser sessions.

## Notes
- The HTML uses the existing Supabase URL and publishable key supplied in the previous file. Publishable/anon keys are intended for browser use only with correct RLS. Never put a service-role secret in frontend code.
- The `post-images` bucket is public so image URLs can render publicly; do not store private images there.
- This is a starter implementation, not a production-audited Facebook-scale service. Chat is 1-to-1 text only; group chat, image messages, read receipts, push notifications, rate limiting, blocking/reporting, pagination and abuse prevention need additional implementation.
- Test schema compatibility carefully before applying to a live database.
