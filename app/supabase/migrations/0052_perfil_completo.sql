-- Aba Perfil (5.6 do doc de especificação): completa o schema de profiles com os
-- campos que faltavam (descrição, cor de fundo, posição do banner) e cria os buckets
-- de Storage pra upload de foto de perfil e banner.

alter table profiles add column description text;
alter table profiles add column background_color text;
alter table profiles add column banner_position_y numeric not null default 50; -- % do topo, pra reposicionamento arrastável

insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', true), ('banners', 'banners', true)
on conflict (id) do nothing;

-- Cada usuário só pode escrever dentro de uma pasta com o próprio id (ex.: avatars/<uid>/foto.png).
create policy "avatars: leitura pública" on storage.objects for select using (bucket_id = 'avatars');
create policy "avatars: dono escreve" on storage.objects for insert with check (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "avatars: dono atualiza" on storage.objects for update using (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "avatars: dono remove" on storage.objects for delete using (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "banners: leitura pública" on storage.objects for select using (bucket_id = 'banners');
create policy "banners: dono escreve" on storage.objects for insert with check (bucket_id = 'banners' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "banners: dono atualiza" on storage.objects for update using (bucket_id = 'banners' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "banners: dono remove" on storage.objects for delete using (bucket_id = 'banners' and (storage.foldername(name))[1] = auth.uid()::text);
