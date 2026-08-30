-- Corrige recursão infinita nas policies: "campaigns" consultava campaign_members (com RLS),
-- que por sua vez consultava campaigns (com RLS) de novo. Funções security definer quebram
-- o ciclo, já que ignoram RLS na consulta interna.

create function public.is_campaign_owner(p_campaign_id uuid)
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (select 1 from campaigns c where c.id = p_campaign_id and c.owner_id = auth.uid());
$$;

create function public.is_campaign_member(p_campaign_id uuid)
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (select 1 from campaign_members m where m.campaign_id = p_campaign_id and m.user_id = auth.uid());
$$;

drop policy "campaign_members: membros leem" on campaign_members;
create policy "campaign_members: membros leem" on campaign_members for select using (
  auth.uid() = user_id or is_campaign_owner(campaign_id)
);

drop policy "campaigns: membros e dono leem" on campaigns;
create policy "campaigns: membros e dono leem" on campaigns for select using (
  auth.uid() = owner_id or is_campaign_member(id)
);

drop policy "characters: dono ou membros da campanha leem" on characters;
create policy "characters: dono ou membros da campanha leem" on characters for select using (
  auth.uid() = user_id or (campaign_id is not null and is_campaign_member(campaign_id))
);
