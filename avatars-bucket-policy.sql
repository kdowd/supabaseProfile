-- Normalise the bucket: image-only types and a public read flag.
update storage.buckets
   set public = true,
       allowed_mime_types = array['image/jpeg', 'image/png', 'image/gif']
 where id = 'avatars';

-- Signed-in users may add, overwrite and delete files inside their own folder.
drop policy if exists "users manage their own avatar files" on storage.objects;
create policy "users manage their own avatar files"
  on storage.objects for all
  to authenticated
  using      (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text)
  with check (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);




  USED SUPABASE GUI FOR THIS - added 2 policies

  but needed this:
  update storage.buckets set public = true where id = 'avatars';