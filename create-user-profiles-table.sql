create table public.user_profiles (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  uuid uuid not null default auth.uid(),
  email text not null unique,
  username text not null unique,
  imagename text not null
);


alter table public.user_profiles enable row level security;

-- Users can view their own profile
create policy "Users can view own profile"
  on public.user_profiles for select
  using (auth.uid() = uuid);

-- Users can insert their own profile
create policy "Users can insert own profile"
  on public.user_profiles for insert
  with check (auth.uid() = uuid);

-- Users can update their own profile
create policy "Users can update own profile"
  on public.user_profiles for update
  using (auth.uid() = uuid);

-- Users can delete their own profile (optional)
create policy "Users can delete own profile"
  on public.user_profiles for delete
  using (auth.uid() = uuid);