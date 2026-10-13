# Livingness Beyond Complexity: A Multi-Method Study of Perceptual, Emotional, and Neural Responses to Built Form

This repository contains the code and data accompanying the manuscript
*"Livingness Beyond Complexity: A Multi-Method Study of Perceptual, Emotional, and Neural Responses to Built Form"*,
currently under peer review.

> **Note:** Author identities are withheld during the peer-review process.
> Citation and author details will be added upon acceptance.

## Overview

This study tests the claim at the center of Christopher Alexander's
theory of living structure, that *architectural livingness* is organized
complexity rather than the amount of visual complexity as such. Using
behavioral ratings, psychological measures, an AI scoring instrument
(Beautimeter), and functional magnetic resonance imaging (fMRI) in 63
participants, we examine responses to images varying in livingness across
three categories: geometric patterns, architectural details, and
building facades. The behavioral data show a reliable component of
perceived livingness beyond perceived complexity; the AI instrument
tracks complexity but not that component; the neural analyses, built on
the AI scores, reflect visual-cortex sensitivity to complexity.

## Repository structure

- `Code/` — analysis scripts and notebooks
- `Data/` — behavioral and questionnaire data (de-identified)

## Requirements

- Python 3.10.11 (packaged by conda-forge)
- scikit-learn 1.2.2
- MATLAB with SPM12 (for fMRI preprocessing and GLM analyses)

## Code

| Notebook / Script | Description |
|-------------------|-------------|
| `Code/livingness_score_reliability.ipynb` | Reliability analysis of the AI-generated livingness scores (ICC, Cronbach's α). Reported in Methods and Supplementary Material S5. |
| `Code/RSA_analysis.m` | Representational similarity analysis on fMRI data. Reported in Results and Supplementary Material S6. |
| `Code/searchlight_decoding.m` | Multivariate searchlight decoding (SVR) of the image-level AI composite livingness score (not participants' ratings) from fMRI activity. Implemented with The Decoding Toolbox (TDT). Reported in Results and Supplementary Material S6. |
| `Code/generate_figures.ipynb` | Generates Figures 2–5 (see table below). |

## Reproducing the figures

| Figure | Description | Script |
|--------|-------------|--------|
| Figure 2 | Subjective ratings of likability, perceived livingness, and perceived complexity | `Code/generate_figures.ipynb` |
| Figure 3 | Forced-choice preferences for high-livingness images | `Code/generate_figures.ipynb` |
| Figure 4 | Aesthetic emotions in response to high vs. low livingness | `Code/generate_figures.ipynb` |
| Figure 5 | Connectedness to Nature and subjective ratings | `Code/generate_figures.ipynb` |

## Data exclusions

Perceived-livingness ratings for seven images (A6b, A10b, B3a, B8b, C2a,
C5a, C9a) were recorded as a single constant value across all (or all but
one) participants, indicating a response-recording fault confined to that
item. These values are set to missing in `Data/full_anonymized.csv`, and
all analyses based on perceived-livingness ratings use the remaining 53
images. Likability, complexity, forced-choice, emotion, and neuroimaging
analyses retain all 60 images. See `Data/README.md` for details.

## Data availability

This repository contains de-identified behavioral and questionnaire data.

Unthresholded group-level fMRI statistical maps will be deposited on NeuroVault
(DOI to be added upon acceptance).

Raw and preprocessed neuroimaging data are not publicly available due to
ethics and institutional review board constraints, but are available from
the corresponding author upon reasonable request, subject to a data sharing
agreement.

## License

Released under the MIT License (code) and CC-BY 4.0 (data).
See `LICENSE` for details.

## Citation

Citation information will be added upon acceptance.

## Contact

Author contact information will be made available upon acceptance.
