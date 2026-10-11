# Pavan Speaks — Environment Report

**Project:** Telugu-English documentary on the CEC Gyanesh Kumar resignation controversy
**Checked:** 2026-10-11 · **Status:** blocked on footage, Telugu font and transcription. No editing has started.

> **Important:** this check ran in a **Linux cloud container (Claude Code on the web)**, not on your Windows PC. Your Windows tools, fonts and GPU were not checked. Where the Windows steps differ, they are listed separately below.

## 1. Source footage

| Check | Result |
|---|---|
| `input/raw.mp4` present | ❌ **Not found.** The repo has only `README.md` |
| Google Drive link reachable | ❌ The environment's network policy **blocks `drive.google.com`** (proxy returned 403) |
| Duration / resolution / fps / codec / audio | ⏸ Pending. Run `scripts/probe.sh` once the file is in place |

## 2. Tools

| Tool | Status | Notes |
|---|---|---|
| FFmpeg / ffprobe 6.1.1 | ✅ | libx264, libx265, SVT-AV1, AAC, libass (`subtitles`/`ass`), `drawtext`, `loudnorm`, `afftdn`, `arnndn`, `silencedetect` |
| Python 3.13.16 + pip 24.0 | ✅ | |
| numpy 2.5, Pillow 12.3 | ✅ | |
| opencv, moviepy, pysubs2, srt, soundfile, librosa, pydub | ❌ | Not installed (optional; FFmpeg covers most of the work) |
| faster-whisper / openai-whisper / torch | ❌ | Not installed |
| GPU (NVENC / CUDA) | ❌ | Not present. CPU only, 4 cores, 15 GB RAM |

## 3. Fonts

| Script | Status |
|---|---|
| English | ✅ Inter (all weights), DejaVu, Liberation, Noto Color Emoji |
| **Telugu** | ❌ **No proper Telugu font.** Only Unifont, a bitmap fallback that is not usable for titles or subtitles |

Recommended: **Noto Sans Telugu** for subtitles and **Noto Serif Telugu** or **Ramabhadra** for titles. All are free under the OFL licence.

## 4. Local transcription

**Not possible yet.** The software is not installed, and `huggingface.co`, where the Whisper models are hosted, is **blocked** here. PyPI is reachable.
Telugu-English code-mixed speech needs a large model (`large-v3`, ~3 GB). On 4 CPU cores, plan for about **1–1.5× the video's length** with int8. A human pass over the Telugu text is still required.

## 5. Disk and render estimate

- Free: **31 GB** · RAM 15 GB · 4 CPU cores
- Rough need per hour of 1080p footage: source (~2–6 GB) + 720p proxy (~1 GB) + WAV audio (~0.7 GB) + final export (~3–5 GB) + Whisper model (3 GB) ≈ **12–18 GB**. ✅ That fits.
- Final x264 `-preset slow -crf 18` render at 1080p on 4 cores: about **0.5–1× real time**, so roughly 1–2 hours per hour of footage. It takes longer if subtitles and overlays are burned in.

## 6. Folders created (`pavan-speaks/`)

```
input/        ← raw.mp4 goes here (read-only, never overwritten)
work/         audio/ proxies/ cuts/   (intermediates, git-ignored)
graphics/     lower thirds, title cards, maps
assets/       images/ clips/ music/ sfx/  (sourced material + licences)
subtitles/    .srt / .ass (Telugu + English)
reports/      this report, probe output, edit decision lists
exports/      final YouTube MP4 (git-ignored)
scripts/      probe.sh (read-only inspection)
```

`.gitignore` keeps all video and audio files out of git, so your footage never goes to GitHub.

**Original-file safety rules:** `input/raw.mp4` is only ever read. Every FFmpeg output is written to `work/` or `exports/`, and I'll never use `-y` on any path under `input/`.

## 7. Next commands

### Option A (recommended): run Claude Code locally on your Windows PC
Your footage is already there. Nothing needs uploading, and rendering is faster. In PowerShell:

```powershell
winget install --id Gyan.FFmpeg -e
winget install --id Python.Python.3.12 -e
# Telugu fonts: download Noto Sans Telugu + Noto Serif Telugu from fonts.google.com,
# right-click the .ttf files → "Install for all users"
py -m pip install faster-whisper pysubs2 soundfile
# The Whisper model (~3 GB) downloads on first use. Please confirm before I run it.
```

### Option B: continue in this cloud session
1. **Allow the hosts:** open the environment menu in the session title bar → **Edit** → **Network access**, and add `drive.google.com`, `drive.usercontent.google.com`, `huggingface.co` and `*.hf.co` under *Allowed domains*. Keep *Allow package managers* ticked. Docs: https://code.claude.com/docs/en/cloud-environments#network-access
2. **Make the Drive file viewable to "Anyone with the link".** Note that this copies your footage onto this cloud container.
3. Then, with your OK, I'll run:
```bash
pip install gdown faster-whisper pysubs2 soundfile
gdown 1WJ8YJVaBQTJ84JP3cznaPnTgmHeOS59F -O pavan-speaks/input/raw.mp4
chmod a-w pavan-speaks/input/raw.mp4          # write-protect the original
pavan-speaks/scripts/probe.sh pavan-speaks/input/raw.mp4 | tee pavan-speaks/reports/probe.txt
sudo apt-get install -y fonts-noto-core       # includes Noto Sans/Serif Telugu
```
