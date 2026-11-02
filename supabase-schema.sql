-- Jalankan sekali di Supabase Dashboard > SQL Editor.
create table if not exists public.game_sessions (
  room_code text primary key,
  game_state jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.game_sessions enable row level security;

-- MVP tanpa login: siapa pun yang mengetahui kode room dapat membaca,
-- menyimpan, atau menimpa sesi tersebut. Gunakan kode acak dan jangan simpan data pribadi.
create policy "Anyone can read game sessions"
on public.game_sessions for select
to anon, authenticated
using (true);

create policy "Anyone can create game sessions"
on public.game_sessions for insert
to anon, authenticated
with check (true);

create policy "Anyone can update game sessions"
on public.game_sessions for update
to anon, authenticated
using (true)
with check (true);

grant select, insert, update on public.game_sessions to anon, authenticated;
