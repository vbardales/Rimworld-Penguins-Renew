# Runs

One line per run. Evidence folders are gitignored (`Tests/Pickle/Evidence/`).

- 2026-10-16, Pickle, revision 5f90ff4, initial pass (diagnostic): pass 1 EN `20261016-175139-326-89c1`, 14 passed, 0 failed, 5 skipped (the 5 ADS 2 scenarios, not staged on this map); pass 1 FR `20261016-175140-365-75d5`, 13 passed, 0 failed, 5 skipped; pass 2 ADS 2 `20261016-175141-424-d849`, 4 of 4 passed; pass 3 original `20261016-175142-453-8de9`, 1 of 1 passed. `exitReason` passed on all four. The Player.log of every run shows `Config error in king_penguin / emperor_penguin: eggUnfertilizedDef is null` (the scenario `no errors were logged` passed anyway: it does not see load-time errors). Defect fixed in the next commit.
- 2026-10-17, Pickle, revision d7d4ef6, small ticket `20261016-223812-814-9417`: 01-defs EN, 6 of 6 passed, Player.log has no `eggUnfertilizedDef` line and no error of this mod. Closes the 2026-10-16 defect. Code review of Mod/ (6 XML files) done at HEAD, no other defect: `code_review_sha` set.
