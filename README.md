# Questie Panza (Forever)

A lightweight World of Warcraft addon adapted for **WoW: Forever** that silences annoying quest announcement spam sent by party members using Questie.

This is a fork and adaptation of the original [Questie ShutUp](https://www.curseforge.com/wow/addons/questie-shutup) addon for modern client compatibility.

## Features
* Filters out party and party leader quest announcement spam from Questie.
* Safely scoped local functions to prevent global namespace pollution.
* Uses native `GetLocale()` handling for raid marker detection without requiring Questie as a dependency.
* Optimized plain-text pattern matching for performance.

## Installation
1. Download the latest release or clone this repository.
2. Place the `QuestiePanza` folder into your WoW Forever directory:
   `World of Warcraft/_forever_/Interface/AddOns/`
3. Launch the game and ensure the addon is enabled on your character selection screen.

---
*Original concept by Reginald Leonczuk.*
