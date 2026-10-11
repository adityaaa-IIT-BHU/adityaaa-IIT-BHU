# Pavan Speaks — Environment Report

**Project:** Telugu-English political explainer: CEC Gyanesh Kumar, the Special Intensive Revision (SIR) of electoral rolls, and the related controversy
**Checked:** 2026-10-11 (second check) · **Status:** ⛔ **Blocked at Phase 1.** The source recording cannot be reached from this machine. No editing has started.

> **Where this ran:** a **Linux cloud container (Claude Code on the web)**, not your Windows PC. Your Windows files, tools, fonts and GPU were not checked.

## 1. Source footage

| Check | Result |
|---|---|
| Search of the project folder and the whole container for `*.mp4 / *.mov / *.mkv / *.webm / *.wav / *.m4a`, transcripts, `.srt` and meme files | ❌ **No user footage or project media found.** Only unrelated test files inside system packages |
| `Pavan raw video.mp4` in Google Drive | ✅ Found through the Drive connector: ID `1hnIjcG3AJ_fVfJCA3Wgy7M4-msRGWqVi`, 668,740,305 bytes (~669 MB), uploaded 2026-10-11 11:35 UTC |
| Download through the Drive connector | ❌ Not practical. The connector returns file content as base64 text inside the conversation. That works for documents, not a 669 MB video |
| Direct download from Drive | ❌ **Blocked by the network policy.** The proxy answered `403` to `CONNECT drive.google.com:443` |
| Telugu meme library | ❌ Not found locally. Not reachable on Drive for the same reason |
| Existing previews | `PavanSpeaks_preview_v1_540p.mp4` (and a `(1)` copy, same size) are in Drive only, so they are unreachable too |

## 2. Network access (tested 2026-10-11)

| Host | Needed for | Result |
|---|---|---|
| `drive.google.com`, `drive.usercontent.google.com` | Footage, previews, meme library | ❌ blocked |
| `huggingface.co` | Whisper speech-recognition models (transcript and subtitles) | ❌ blocked |
| `commons.wikimedia.org` | Licensed photographs of public figures | ❌ blocked |
| `eci.gov.in` | Primary Election Commission documents (fact check) | ❌ blocked |
| `pypi.org` | Python packages | ✅ allowed |

## 3. Tools

| Tool | Status | Notes |
|---|---|---|
| FFmpeg / ffprobe 6.1.1 | ✅ | libx264, AAC, `subtitles`/`ass`, `drawtext`, `loudnorm`, `afftdn`, `arnndn`, `zoompan`, `xfade` |
| Python 3.13.16 | ✅ | numpy 2.5.3, Pillow 12.3.0 |
| opencv, moviepy, pysubs2, librosa | ❌ | Not installed. They can be installed from PyPI; FFmpeg covers most of the work |
| faster-whisper / torch | ❌ | Not installed here. A parallel session installed faster-whisper 1.2.1 from PyPI without problems, but the **model download needs `huggingface.co`**, which is blocked |
| GPU | ❌ | CPU only: 4 cores, 15 GB RAM |

## 4. Fonts

| Script | Status |
|---|---|
| English (on-screen graphics) | ✅ Inter (all weights, including Inter Display), DejaVu |
| **Telugu (subtitles)** | ⚠️ **Tested and working, but not present in this container.** A parallel session installed `fonts-noto-core` (Noto Sans/Serif Telugu) and confirmed that FFmpeg/libass renders conjuncts correctly: see `reports/telugu-render-test.png`. Cloud containers are temporary, so repeat `sudo apt-get install -y fonts-noto-core` in each new session |

Bilingual subtitle styles (Telugu above, English below, 1920×1080) are ready in `subtitles/bilingual-template.ass`.

## 5. Disk and render estimate

- Free: **31 GB**. Need for ~45–60 min of 1080p source: source (0.7 GB) + proxy + WAV + intermediates + Whisper model (3 GB) + final export ≈ **8–15 GB**. ✅ That fits.
- Final x264 `-preset slow -crf 18` render on 4 cores: about **0.5–1× real time** for a 10-minute edit with overlays, so ~10–25 minutes per full render.

## 6. Project structure (`pavan-speaks/`)

```
input/            raw.mp4 goes here (read-only, write-protected after copy)
work/             audio/ proxies/ cuts/ graphics/ renders/  (intermediates, git-ignored)
graphics/         lower thirds, title cards, maps, evidence cards
assets/           images/ clips/ music/ sfx/ memes/ documents/  (+ source_log.md)
subtitles/        final_subtitles.srt
reports/          environment, media, transcript, EDL, storyboard, fact check, QC
exports/          rough_cut.mp4, preview.mp4, final MP4 (git-ignored)
scripts/          probe.sh and the edit/render scripts
```

`.gitignore` keeps every video and audio file out of git, so your footage never goes to GitHub.

## 7. What I need from you to continue (pick one)

### Option A (recommended): run Claude Code locally on your Windows PC
Your brief describes a Windows workflow, and the footage is already there. Nothing needs uploading, and there are no network blocks. Put the video at `pavan-speaks\input\raw.mp4`, then in PowerShell:

```powershell
winget install --id Gyan.FFmpeg -e
winget install --id Python.Python.3.12 -e
py -m pip install faster-whisper pysubs2 soundfile
# Install Noto Sans Telugu from fonts.google.com ("Install for all users")
```
Then start Claude Code in the repo folder and send the same brief.

### Option B: continue in this cloud session
1. Session title bar → cloud environment menu → **Edit** → **Network access** → **Allowed domains**. Add:
   `drive.google.com`, `drive.usercontent.google.com`, `huggingface.co`, `*.hf.co`, `commons.wikimedia.org`, `upload.wikimedia.org`, `eci.gov.in`, `www.eci.gov.in`, `sci.gov.in`, `pib.gov.in`. Keep **Allow package managers** ticked. Docs: https://code.claude.com/docs/en/cloud-environments#network-access
2. In Drive, set `Pavan raw video.mp4` (and the meme folder, if you want memes) to **"Anyone with the link: Viewer"**, or tell me to use a different method. This copies your footage onto the cloud container. It is never pushed to GitHub.
3. Reply "done". I'll then copy the file to `input/raw.mp4`, write-protect it, run `scripts/probe.sh`, and continue with Phase 2.
