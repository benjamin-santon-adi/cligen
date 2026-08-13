# CLIgen Zephyr Module

This is a port of [CLIgen](https://github.com/clicon/cligen) for Zephyr RTOS.

## Overview

CLIgen is a Command-Line Interface generator library originally designed for Unix systems. This module adapts it for use in Zephyr RTOS embedded applications, primarily for use with the Clixon NETCONF library.

## Features

- ✅ Core CLIgen API (cg_var, cvec, cbuf)
- ✅ Variable and vector management
- ✅ Buffer management with dynamic allocation
- ✅ Type system for CLI variables
- ❌ Terminal/TTY features (disabled for embedded)
- ❌ File descriptor registration (disabled for embedded)
- ⚠️  Parser generation (pre-generated files required)

## Directory Structure

```
cligen/
├── zephyr/
│   ├── module.yml          # Zephyr module definition
│   ├── Kconfig             # Configuration options
│   ├── CMakeLists.txt      # Build configuration
│   └── cligen_config.h     # Zephyr-specific config
├── cligen/
│   ├── cligen_buf.h        # Buffer API
│   ├── cligen_cv.h         # Variable API
│   ├── cligen_cvec.h       # Vector API
│   └── cligen.h            # Main header
├── cligen_buf.c            # Buffer implementation
├── cligen_cv.c             # Variable implementation
├── cligen_cvec.c           # Vector implementation
└── README.md               # This file
```

## Integration with West Workspace

### Add to west.yml manifest

```yaml
manifest:
  projects:
    - name: cligen
      url: https://github.com/benjamin-santon-adi/cligen
      revision: zephyr-module
      path: modules/lib/cligen
```

### Enable in prj.conf

```ini
CONFIG_CLIGEN=y
CONFIG_CLIGEN_BUF_SIZE=8192
CONFIG_CLIGEN_CBUF_ALLOC_UNIT=1024
```

### Use in application

```c
#include <cligen/cligen.h>

void example(void) {
    cvec *cv = cvec_new(0);
    cg_var *cgv = cvec_add(cv, CGV_STRING);
    cv_string_set(cgv, "hello");
    cvec_free(cv);
}
```

## Building from Source

This module expects CLIgen source files to be present in the root directory. To set up:

1. Clone the upstream CLIgen repository
2. Copy source files to this module
3. Pre-generate parser files if needed (using bison/flex on host)

## Configuration Options

See `zephyr/Kconfig` for available configuration options:

- `CONFIG_CLIGEN` - Enable CLIgen module
- `CONFIG_CLIGEN_BUF_SIZE` - Default buffer size (default: 8192)
- `CONFIG_CLIGEN_CBUF_ALLOC_UNIT` - Cbuf allocation unit (default: 1024)
- `CONFIG_CLIGEN_CVEC_ALLOC_UNIT` - Cvec allocation unit (default: 16)

## Limitations

Due to embedded platform constraints:

- No terminal control (termios, ioctl)
- No file descriptor event registration
- Parser files must be pre-generated on host
- Limited UTF-8 support (experimental)

## License

CLIgen is licensed under Apache-2.0. See upstream repository for details.

## Upstream

Original CLIgen: https://github.com/clicon/cligen
