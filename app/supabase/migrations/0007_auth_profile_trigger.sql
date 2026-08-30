-- Cria automaticamente uma linha em profiles sempre que alguém se cadastra (auth.users).
-- security definer: roda com privilégios do dono da função, ignorando RLS de profiles
-- (necessário porque no momento do cadastro ainda não há uma sessão autenticada agindo).

create function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, display_name)
  values (new.id, new.raw_user_meta_data ->> 'display_name');
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
