# elebihan.com Buildroot External Customisation

This is an external customisation for Buildroot which contains packages that may
or may not be upstreamed one day.

## Installation

To use this external customisation, start by cloning Buildroot 2016.11 or above:

```
git clone http://git.buildroot.net/buildroot
```

Then, clone the external customisation:

```
git clone https://github.com/elebihan/br2-ext-elebihan
```

Then, change to the buildroot directory and execute:

```
make BR2_EXTERNAL=../br2-ext-elebihan menuconfig
```
