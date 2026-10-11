# Pavan Speaks — Media Report

**Checked:** 2026-10-11 · **Status:** ⛔ Source not available locally. Properties below come from Google Drive metadata only. Nothing has been probed.

## Source recording

| Property | Value | Source |
|---|---|---|
| File name | `Pavan raw video.mp4` | Drive |
| Drive file ID | `1hnIjcG3AJ_fVfJCA3Wgy7M4-msRGWqVi` | Drive |
| Size | 668,740,305 bytes (~669 MB) | Drive |
| Container | MP4 (`video/mp4`) | Drive |
| Uploaded | 2026-10-11 11:35 UTC (finished 11:37) | Drive |
| Local copy | ❌ none (`input/raw.mp4` missing) | — |
| Duration, resolution, frame rate, codecs | ⏸ **Unknown.** Needs ffprobe on a local copy | — |
| Audio: sample rate, channels, loudness (EBU R128), noise floor, clipping | ⏸ **Unknown.** Needs `scripts/probe.sh` | — |

## Other media

| Item | Location | Status |
|---|---|---|
| `PavanSpeaks_preview_v1_540p.mp4` | Drive, 40,594,364 bytes, 2026-10-06 | Not reachable. Probably a duplicate of the `(1)` copy, which has the same size |
| `PavanSpeaks_preview_v1_540p (1).mp4` | Drive, 40,594,364 bytes | Not reachable |
| Telugu meme library | Unknown Drive folder | Not reachable. Please share the folder name once access is fixed |
| Scripts, notes, transcripts | None found in the repo or the container | — |
| Images, logos, documents | None found | — |

## Next step

Once `input/raw.mp4` exists, run:
```bash
chmod a-w input/raw.mp4
scripts/probe.sh input/raw.mp4 | tee reports/probe.txt
```
I'll then fill in this report and start Phase 2 (full transcript and media analysis).
