# Kos-Kosan Survival — Vercel + Supabase

Aplikasi tetap menggunakan React + Vite + TypeScript. Vercel melayani frontend statis, sedangkan Supabase menyimpan sesi permainan.

## Fitur cloud
- **Simpan Online**: menyimpan snapshot permainan (pemain, saldo, posisi, giliran, kartu aktif, log, dan koordinat papan) ke Supabase.
- **Muat Game**: memulihkan permainan menggunakan kode room.
- Tidak memerlukan server Express khusus; Vercel menjalankan hasil build Vite.

## 1. Siapkan Supabase
1. Buat project di https://supabase.com.
2. Buka **SQL Editor**.
3. Jalankan isi file `supabase-schema.sql`.
4. Buka **Project Settings → API**.
5. Salin Project URL dan anon/publishable key.

### Catatan keamanan
Versi ini memakai room code tanpa login agar mudah dipakai untuk demo/ujian. Siapa pun yang mengetahui kode dapat membaca dan menimpa sesi tersebut. Jangan gunakan untuk data pribadi atau permainan yang membutuhkan privasi. Untuk produksi, tambahkan Supabase Auth dan kebijakan RLS per pemilik room.

## 2. Jalankan lokal
```bash
npm install
cp .env.example .env.local
```
Isi `.env.local`:
```env
VITE_SUPABASE_URL=https://YOUR_PROJECT_ID.supabase.co
VITE_SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_OR_PUBLISHABLE_KEY
```
Lalu:
```bash
npm run dev
```

## 3. Deploy ke Vercel
1. Push folder project ini ke repository GitHub.
2. Di Vercel pilih **Add New → Project**, lalu import repository.
3. Framework akan terdeteksi sebagai Vite. Build command: `npm run build`; output directory: `dist`.
4. Di **Project → Settings → Environment Variables**, tambahkan:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
5. Deploy atau lakukan Redeploy setelah menambahkan environment variables.

File `vercel.json` sudah mengatur fallback route untuk aplikasi single-page.

## Catatan
- Tombol Simpan Online menyimpan kondisi saat tombol ditekan; penyimpanan tidak otomatis.
- Kode room dibuat saat penyimpanan pertama dan dapat digunakan kembali untuk memperbarui sesi yang sama.
- Jika memakai fitur Gemini, konfigurasi backend/API key perlu ditangani terpisah. Jangan menaruh secret key Gemini di variabel `VITE_*` karena variabel tersebut terekspos ke browser.
