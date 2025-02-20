This is BLuau version 1.0.0
============================

**BLuau** is a Roblox package library manager

```lua
-- Library Universal Hotspot (BLuau)
local BLuau = require(game:GetService("ReplicatedStorage"):WaitForChild("BLuau_Rojo").BLibraries)
print(BLuau)

-- Example of importing a module
local logging = BLuau.logging
```

BLuau output result:

```console
▼  {
        ["__index"] = "*** cycle table reference detected ***",
        ["authz"] =  ▶ {...},
        ["logging"] =  ▶ {...},
        ["profiler"] =  ▶ {...},
        ["rbxdss"] =  ▶ {...},
        ["unittest"] =  ▶ {...}
    }
```

**BLuau** is a library manager for Luau, designed to be used in the **Roblox** environment, while maintaining a certain security.
It is designed to be compatible in any type of project, including several varied modules such as logging, profiling, unit testing and much more.  

[![Contributors](https://img.shields.io/github/contributors/blockguard-sf/BLuau.svg)](https://github.com/blockguard-sf/BLuau/graphs/contributors)
[![Issues](https://img.shields.io/github/issues/blockguard-sf/BLuau.svg)](https://github.com/blockguard-sf/BLuau/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/blockguard-sf/BLuau.svg)](https://github.com/blockguard-sf/BLuau/pulls)
[![Forks](https://img.shields.io/github/forks/blockguard-sf/BLuau.svg)](https://github.com/blockguard-sf/BLuau/network/members)

## Table of contents

- [General Information](#general-information)
- [Contributing to BLuau](#contributing-to-bluau)
- [Installing PyPIxz and Supported Versions](#installing-pypixz-and-supported-versions)
    - [Official Roblox Model (Recommended for beginner)](#official-roblox-model-recommended-for-beginner)
    - [GitHub Releases](#github-releases)
    - [Install with Rojo](#install-with-rojo)
- [What's New](#whats-new)
- [Documentation](#documentation)
- [Copyright and License Information](#copyright-and-license-information)

## General Information

- Source Code : https://github.com/blockguard-sf/bluau
- Issue Tracker : https://github.com/blockguard-sf/bluau/issues
- Documentation : https://github.com/blockguard-sf/BLuau/wiki
- Roblox Group: https://www.roblox.com/fr/communities/35439925/blockguard-software-foundation
- Discord Server : https://discord.gg/WNKh6avffr

## Contributing to BLuau

The purpose of this repository is to allow others to contribute and make improvements to BLuau.
Even if you've never contributed to GitHub before, we would appreciate any contributions that you can provide.

For more complete instructions on contributing to Bluau development, see the [Developer Guide]().

## Installing PyPIxz and Supported Versions

### Official Roblox Model (Recommended for beginner)

1. Add the [BLuau Model]() to your Toolbox from the **Roblox Creator Hub**.
2. Import **BLuau** into your Experience from the Toolbox in the "**My Models**" category

### GitHub Releases

1. Download the `.rbxm` file from the latest version of BLuau in the GitHub.
2. Import the model file into Roblox Studio.

### Install with Rojo

```bash
$ git clone https://github.com/blockguard-sf/bluau
```

```bash
$ cp /path/to/bluau/BLuau /path/to/replicatedstorage/of/your/project/
```

## What's New

We have a full overview of the changes in the [What's New in BLuau 1.0](https://github.com/blockguard-sf/BLuau/blob/master/CHANGELOG/preview.md) document.

## Documentation

[Documentation for BLuau 1.0](https://github.com/blockguard-sf/BLuau/wiki/Documentation) is online, updated daily.

For information about building Python's documentation, refer to [Docs/README.md](https://github.com/blockguard-sf/BLuau/tree/release/v1.0/Docs/README.md).

## Copyright and License Information

Copyright © 2025 BlockGuard SF. All Rights Reserved.

See the [LICENSE](https://github.com/blockguard-sf/BLuau/blob/master/LICENSE) for information on the history of this software, terms & conditions for usage, and a DISCLAIMER OF ALL WARRANTIES
