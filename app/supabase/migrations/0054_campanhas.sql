-- Minhas Campanhas: função pra entrar numa campanha por código de convite. Precisa
-- ser security definer porque, antes de entrar, o usuário ainda não é membro e a
-- policy de select de campaigns não deixaria ele nem achar a campanha pelo código.

create function public.join_campaign_by_code(p_invite_code text)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_campaign_id uuid;
begin
  select id into v_campaign_id from campaigns where invite_code = p_invite_code;
  if v_campaign_id is null then
    raise exception 'Código de convite inválido';
  end if;

  insert into campaign_members (campaign_id, user_id)
  values (v_campaign_id, auth.uid())
  on conflict (campaign_id, user_id) do nothing;

  return v_campaign_id;
end;
$$;
