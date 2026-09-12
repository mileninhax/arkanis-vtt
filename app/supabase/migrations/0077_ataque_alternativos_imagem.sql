-- Modal de "Adicionar Ataque": guarda ataques alternativos (aba Ataques Alternativos)
-- e permite subir uma imagem representativa pro ataque (aba Imagem).

alter table character_attacks add column if not exists alternative_attacks jsonb not null default '[]';

insert into storage.buckets (id, name, public)
values ('attack_images', 'attack_images', true)
on conflict (id) do nothing;

create policy "attack_images: leitura pública" on storage.objects for select using (bucket_id = 'attack_images');
create policy "attack_images: dono escreve" on storage.objects for insert with check (bucket_id = 'attack_images' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "attack_images: dono atualiza" on storage.objects for update using (bucket_id = 'attack_images' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "attack_images: dono remove" on storage.objects for delete using (bucket_id = 'attack_images' and (storage.foldername(name))[1] = auth.uid()::text);
