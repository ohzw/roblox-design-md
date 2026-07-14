# Motion presets per taste family

Stills can't prove motion, so every extraction ships one of these preset
blocks (copy into front matter `motion:`), and prose adapted from its notes.
A video input may override values — see the bucket procedure below. Never
claim observed motion without video.

## cartoon-chunky / playful / juicy (simulators, pet collectors, clickers)

```yaml
motion:
  durations: { instant: 0.08s, fast: 0.15s, normal: 0.25s, slow: 0.4s }
  easings:
    pop:    { style: Back, direction: Out }
    settle: { style: Quad, direction: Out }
    exit:   { style: Quad, direction: In }
    bounce: { style: Elastic, direction: Out }
```
Prose notes: overshoot entrances (scale 0.8→1.0), squash-on-press, count-up
numbers, exits faster than entrances, Elastic reserved for rewards.

## cozy-pastel / calm (cafe, farm, hangout)

```yaml
motion:
  durations: { instant: 0.1s, fast: 0.2s, normal: 0.3s, slow: 0.5s }
  easings:
    pop:    { style: Quad, direction: Out }
    settle: { style: Sine, direction: InOut }
    exit:   { style: Quad, direction: In }
```
Prose notes: no overshoot; fades allowed and combined with small slides
(8–16px); nothing snaps.

## sci-fi-hud / competitive (shooters, racing, esports-flavored)

```yaml
motion:
  durations: { instant: 0.06s, fast: 0.12s, normal: 0.18s, slow: 0.3s }
  easings:
    pop:    { style: Quart, direction: Out }
    settle: { style: Linear, direction: Out }
    exit:   { style: Quart, direction: In }
```
Prose notes: speed over charm; slides/wipes over scales; zero bounce —
overshoot reads as sluggish here.

## horror / tension

```yaml
motion:
  durations: { instant: 0.1s, fast: 0.25s, normal: 0.45s, slow: 0.8s }
  easings:
    pop:    { style: Sine, direction: Out }
    settle: { style: Sine, direction: InOut }
    exit:   { style: Sine, direction: In }
```
Prose notes: slow fades, minimal movement; abruptness is reserved for scares,
so UI never startles.

## Video override procedure (bucket classification only)

1. Sample frames at the video's native rate (30–60fps) around each
   transition; a 0.1–0.5s UI tween spans only 3–30 frames — 1fps sampling is
   useless.
2. **Duration**: find first/last frames where the element visibly moves;
   duration = frame span / fps. Bucket into instant (≤0.1s), fast (~0.15s),
   normal (~0.25s), slow (≥0.4s). Precision beyond ±1–2 frames is noise —
   never record raw millisecond values.
3. **Easing family**: plot normalized position/scale across the frames and
   classify into: linear / ease-out (fast→slow) / ease-in-out / overshoot
   (passes target, returns) / elastic (multiple oscillations). Map to
   Enum.EasingStyle: Linear / Quad-Quart Out / Sine InOut / Back Out /
   Elastic Out. Do NOT attempt to fit exact curves — 5–15 noisy frames
   cannot support it.
4. Record what was overridden vs kept as preset in `extraction.notes`, and
   set Motion confidence to `medium` (video) — `high` needs multiple clips
   covering entrance, exit, and press feedback.
