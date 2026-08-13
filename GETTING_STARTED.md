# CLIgen Zephyr Module - Getting Started

## Quick Start for benjamin-santon-adi/cligen Repository

This directory contains the template structure for the CLIgen Zephyr module.

### Step 1: Push to GitHub Repository

```bash
# Navigate to your cligen repository
cd /path/to/your/cligen-repo

# Checkout or create zephyr-module branch
git checkout -b zephyr-module

# Copy these files to the repository root:
# - zephyr/module.yml
# - zephyr/Kconfig
# - zephyr/CMakeLists.txt
# - zephyr/cligen_config.h
# - README.md
# - setup.sh

# Commit the Zephyr module structure
git add zephyr/ README.md setup.sh
git commit -m "Add Zephyr RTOS module structure"
git push -u origin zephyr-module
```

### Step 2: Clone Upstream CLIgen Source

```bash
# On your development machine (with bison/flex installed)
git clone https://github.com/clicon/cligen.git cligen-upstream
cd cligen-upstream

# Build to generate parser files
./configure
make

# Copy generated and source files to your zephyr-module branch
cd ../your-cligen-repo
cp ../cligen-upstream/cligen_*.c .
cp ../cligen-upstream/cligen_*.h cligen/
cp ../cligen-upstream/cligen_parse.c .  # Generated file
cp ../cligen-upstream/cligen_parsetree.c .  # Generated file

git add *.c cligen/*.h
git commit -m "Add CLIgen source files from upstream"
git push
```

### Step 3: Update Clixon West Manifest

In your main project's `west.yml`:

```yaml
manifest:
  remotes:
    - name: benjamin-santon-adi
      url-base: https://github.com/benjamin-santon-adi

  projects:
    # Add CLIgen module
    - name: cligen
      remote: benjamin-santon-adi
      revision: zephyr-module
      path: modules/lib/cligen
    
    # Existing Clixon module
    - name: clixon
      remote: benjamin-santon-adi
      revision: zephyr-module
      path: modules/lib/clixon
```

### Step 4: Update Clixon to Use CLIgen Module

In `modules/lib/clixon/zephyr/CMakeLists.txt`:

```cmake
if(CONFIG_CLIXON)

# Remove local cligen stub, use external module
# Remove: cligen/cligen.c

# Add dependency on CLIgen module
zephyr_library_sources_ifdef(CONFIG_CLIGEN
  # Clixon sources will link against CLIgen automatically
)
```

In `modules/lib/clixon/zephyr/prj.conf`:

```ini
# Enable CLIgen module
CONFIG_CLIGEN=y
CONFIG_CLIGEN_BUF_SIZE=8192

# Enable Clixon (which now depends on CLIgen)
CONFIG_CLIXON=y
```

### Step 5: West Update and Build

```bash
cd /path/to/your/west/workspace
west update
west build -b your_board modules/lib/clixon/zephyr/sample
```

## Files in This Template

- `zephyr/module.yml` - Zephyr module definition
- `zephyr/Kconfig` - Configuration options for CLIgen
- `zephyr/CMakeLists.txt` - Build system integration
- `zephyr/cligen_config.h` - Zephyr-specific configuration header
- `README.md` - Main documentation
- `setup.sh` - Helper script to fetch upstream sources
- `GETTING_STARTED.md` - This file

## Next Steps

1. Copy files to benjamin-santon-adi/cligen:zephyr-module branch
2. Run `setup.sh` to fetch CLIgen sources
3. Commit and push everything
4. Update your Clixon project's west.yml
5. Remove the stub cligen/ directory from Clixon module
6. Build and test
