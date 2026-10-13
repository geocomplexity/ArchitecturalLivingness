# Data

This folder contains de-identified behavioral and questionnaire data
supporting the analyses in the manuscript. Neuroimaging data are not
publicly deposited (see the main README for details).

## Files

| File | Description |
|------|-------------|
| `full_anonymized.csv` | Per-participant master dataset (one row per participant; 63 participants). Contains demographics, all questionnaire responses (HEXACO, AEQ, EIBES, CNS, SPANE, Flourishing), per-image trial ratings (likability, perceived livingness, complexity), forced-choice responses, and aesthetic emotion ratings (Aesthemos). |
| `likability.csv` | Aggregated likability ratings per participant, derived from `full_anonymized.csv`. Used for Figure 5. |
| `livingness.csv` | Aggregated perceived-livingness ratings per participant, derived from `full_anonymized.csv` with the seven-image exclusion applied (see Data exclusions). Used for Figure 5. |
| `human_ratings_image_means.csv` | Image-level means (across the 63 participants) of perceived livingness, perceived complexity, and likability for all 60 images. `Livingness_excluded` flags the seven images whose livingness ratings are missing; `Livingness_n` gives the number of valid livingness ratings. Used for Supplementary Material S5. |
| `residual_livingness_index.csv` | Supplementary Table S19: for the 53 images with valid livingness ratings, image-level means and SDs, and the residual livingness index (residual from regressing image-mean perceived livingness on image-mean perceived complexity; fit: livingness = 3.13 + 0.38 × complexity). Positive values indicate images rated more alive than their complexity predicts. |
| `livingness_final_image_scores.csv` | AI-derived composite livingness score per image (mean of the 15 Beautimeter property scores, averaged over 10 runs). These are the labels used by `Code/searchlight_decoding.m`. |
| `livingness_scores_repeated_runs.csv` | AI-derived architectural livingness scores from the Beautimeter tool, scored across 10 independent runs per image. Used for the reliability analysis (`Code/livingness_score_reliability.ipynb`); reported in Methods and Supplementary Material S5. |

## Structure of `full_anonymized.csv`

Columns are organized into the following sections:

### Demographics and participant info
- `SubjectIndex` — anonymous participant ID (P001–P063)
- `Age`, `Gender` (1 = male, 2 = female), `University`, `Degree`, `Stratum`

### Personality and well-being measures (collected but not analyzed in this paper)

The following measures were administered as part of a larger questionnaire
battery but are not used in the analyses reported in the manuscript. They
are retained in the dataset for transparency and to support potential
secondary analyses.

- `HEX6AVE`, `HEX61AVE`–`HEX64AVE` — HEXACO-60 personality subscale averages
- `DepressionAve` — depression score
- `SPANE_P_AVE`, `SPANE_N_AVE` — Scale of Positive and Negative Experience
- `FSAVE` — Flourishing Scale

### Aesthetic Experience Questionnaire (AEQ; Wanzer et al. 2020)
Trait-level aesthetic engagement, administered pre-scan.
- `AEQEmotionalAve`, `AEQCulturalAve`, `AEQPerceptualAve`, `AEQUnderstandingAve`,
  `AEQFlowProximalConditionsAve`, `AEQFlowExperienceAve` — six subscale averages
- `AEQAve` — overall AEQ score

### Environmental connectedness measures
- `Q21`–`Q24` — Extended Inclusion of Built Environment in Self (EIBES) items
- `Q2Ave` — EIBES composite
- `Q3Ave` — Connectedness to Nature Scale (CNS) composite

### Per-image trial ratings (30 pairs × 6 ratings)
For each of 30 image pairs, six rating columns following the convention
`[Group][Pair][a|b][1|2|3]`:
- **Group**: A = geometric patterns, B = architectural details, C = building facades
- **Pair**: 1–10 within each group
- **a/b**: a = high-livingness image, b = low-livingness image
- **1/2/3**: 1 = likability, 2 = perceived livingness, 3 = perceived structural complexity
- All ratings on a 1–9 scale.
- Example: `A3a2` = Group A, pair 3, high-livingness image, livingness rating
- **Data exclusions:** the perceived-livingness columns `A6b2`, `A10b2`, `B3a2`,
  `B8b2`, `C2a2`, `C5a2`, `C9a2` are blank for all participants. In the original
  export these seven columns held a single constant value across all (or all but
  one) participants, indicating a response-recording fault confined to the
  livingness item for those images; the likability and complexity columns for
  the same images, and the forced-choice responses for the same pairs, show
  normal variability and are retained. The livingness aggregates below
  (`Group*LivingnessAve`, `GroupALivingDiffAve` etc., `All*Livingness*`) are
  recomputed from the remaining images.

Group-level aggregates:
- `Group[A|B|C][High|Low][Like|Livingness|Complex]Ave`
- `Group[A|B|C][Like|Living|Structure]DiffAve` (high − low difference)
- `All*` columns aggregate across groups

### Forced-choice responses
For each pair, two binary forced-choice responses:
- `[Group][Pair][1|2]` where 1 = likability choice, 2 = livingness choice
  (1 = chose high-livingness image, 0 = chose low-livingness image)
- Derived: `Group[A|B|C][Like|Livingness]Percentage` (proportion preferring high-livingness)

### Aesthetic emotion ratings (Aesthemos; Schindler et al. 2017)
Two stimulus presentations (S1, S2) of 42 emotion items each (state-level measure).
- `S1[1–142]` and `S2[1–142]` — individual item ratings
- `S[1|2]Factor[1–7]Ave` — seven aesthetic emotion category scores (per Table S12)
- `S[1|2]Subscale[1–21]Ave` — 21 Aesthemos subscale scores

### Behavioral accuracy
- `Group[A|B|C]_[Target|Alt|Not]_Acc` — attention check accuracy metrics

## Notes

- All Likert ratings use the scale specified in the corresponding questionnaire
  (Aesthemos: 1–5; subjective ratings: 1–9; AEQ: 1–7).
- Image IDs follow the convention `[Group][PairNum][a/b]` where 'a' indicates the
  high-livingness image and 'b' the low-livingness image of each pair.
- Participant IDs are anonymous codes; no personally identifying information is
  included.
- Missing values are coded as blank cells.
