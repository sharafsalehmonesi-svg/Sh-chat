-- Sh-chat: إعداد تخزين صور المنشورات في Supabase
-- شغّل هذا الملف مرة واحدة من Supabase > SQL Editor > New query > Run.
-- يسمح بعرض الصور علنًا، لكن لا يسمح بالرفع إلا للمستخدم المسجّل داخل مجلده الخاص.

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'post-images',
  'post-images',
  true,
  5242880,
  array['image/jpeg','image/png','image/webp','image/gif']
)
on conflict (id) do update
set public = true,
    file_size_limit = 5242880,
    allowed_mime_types = array['image/jpeg','image/png','image/webp','image/gif'];

drop policy if exists "Public can view Sh-chat post images" on storage.objects;
create policy "Public can view Sh-chat post images"
on storage.objects for select
to anon, authenticated
using (bucket_id = 'post-images');

drop policy if exists "Users upload their own Sh-chat post images" on storage.objects;
create policy "Users upload their own Sh-chat post images"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'post-images'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

drop policy if exists "Users delete their own Sh-chat images" on storage.objects;
create policy "Users delete their own Sh-chat images"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'post-images'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);
