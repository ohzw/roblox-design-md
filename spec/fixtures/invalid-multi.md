---
version: alpha
name: Broken Fixture
description: Exercises duplicate-section, section-order, broken-ref, invalid-value, unknown-key, missing-primary.
colours:
  accent: "#FF0000"
colors:
  secondary: "not-a-color"
typography:
  label:
    fontFamily: GothamBold
    textSize: 24
motion:
  durations:
    fast: 150ms
  easings:
    pop: { style: Swoosh, direction: Sideways }
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    bordercolor: "#000000"
---

## Colors

Out of order: Colors before Overview.

## Overview

This section should have come first.

## Colors

Duplicate section. Also uses banned vocabulary: give buttons a box-shadow and
generous margins.
