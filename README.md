# Neural Signatures of Architectural Livingness in Human Perceptual Systems

This repository contains the code and data accompanying the manuscript
*"Neural Signatures of Architectural Livingness in Human Perceptual Systems"*,
currently under peer review.

> **Note:** Author identities are withheld during the peer-review process.
> Citation and author details will be added upon acceptance.

## Overview

This study investigates how *architectural livingness* — defined as
organized multiscale coherence based on Christopher Alexander's theory
of living structure — is encoded in human perceptual and valuation
systems. Using behavioral ratings, psychological measures, and
functional magnetic resonance imaging in 63 participants, we examine
neural and behavioral responses to images varying in livingness across
three categories: geometric patterns, architectural details, and
building facades.

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
| `Code/searchlight_decoding.m` | Multivariate searchlight decoding (SVR) of continuous livingness ratings from fMRI activity. Implemented with The Decoding Toolbox (TDT). Reported in Results and Supplementary Material S6. |
| `Code/generate_figures.ipynb` | Generates Figures 2–5 (see table below). |

## Reproducing the figures

| Figure | Description | Script |
|--------|-------------|--------|
| Figure 2 | Subjective ratings of likability, livingness, and complexity | `Code/generate_figures.ipynb` |
| Figure 3 | Forced-choice preferences for high-livingness images | `Code/generate_figures.ipynb` |
| Figure 4 | Aesthetic emotions in response to high vs. low livingness | `Code/generate_figures.ipynb` |
| Figure 5 | Connectedness to Nature and subjective ratings | `Code/generate_figures.ipynb` |

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
