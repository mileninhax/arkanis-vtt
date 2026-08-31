-- Passo 5.5 da criação de ficha (Autenticação): permite escolher uma foto pro
-- personagem. Cria a coluna + bucket de Storage seguindo o mesmo padrão de avatars/banners.

alter table characters add column photo_url text;

insert into storage.buckets (id, name, public)
values ('character_photos', 'character_photos', true)
on conflict (id) do nothing;

create policy "character_photos: leitura pública" on storage.objects for select using (bucket_id = 'character_photos');
create policy "character_photos: dono escreve" on storage.objects for insert with check (bucket_id = 'character_photos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "character_photos: dono atualiza" on storage.objects for update using (bucket_id = 'character_photos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "character_photos: dono remove" on storage.objects for delete using (bucket_id = 'character_photos' and (storage.foldername(name))[1] = auth.uid()::text);
