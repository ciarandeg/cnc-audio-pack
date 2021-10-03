# C&C Audio Pack

This repo contains the assets and scripts required to build the C&C
Audio Pack from scratch. It relies heavily on
[Git LFS](https://git-lfs.github.com/) and weighs in at around 11gb
(as of v1.5.1), so consider making a shallow clone with `git clone`'s
`--depth` option if you're going to clone it.

Auto-normalization with SoX (see `build.sh`) is deprecated, as it will
not adjust evenly across two-part loop tracks and relies on peak
normalization which hasn't been consistent enough for our purposes.
Instead, our `.wav` files have been manually adjusted using a
combination of Izotope RX (thanks to Kestryl from the C&C team) and
Audacity. Maybe I'll get around to implementing something fancy that can
do LUFS adjustments across multiple files, but it's low priority.
