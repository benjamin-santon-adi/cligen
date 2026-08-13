# Copyright (c) 2024 Benjamin Santon
# SPDX-License-Identifier: Apache-2.0

if(CONFIG_CLIGEN)

zephyr_library()

# Include directories
zephyr_include_directories(${ZEPHYR_CURRENT_MODULE_DIR})
zephyr_include_directories(${ZEPHYR_CURRENT_MODULE_DIR}/zephyr)

# Core CLIgen source files
zephyr_library_sources(
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_buf.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_callback.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_cv.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_cvec.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_expand.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_handle.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_io.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_match.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_object.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_parsetree.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_print.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_pt_head.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_read.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_regex.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_result.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_syntax.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_util.c
)

# Exclude files not suitable for embedded:
# - cligen_file.c (terminal/file I/O, termios)
# - cligen_getline.c (terminal line editing, termios)
# - cligen_history.c (command history with file I/O)
# - cligen_hello.c, cligen_tutorial.c (example/test code)

# Compiler flags
zephyr_library_compile_definitions(
  HAVE_CONFIG_H
  _GNU_SOURCE
)

# Disable warnings for upstream code
zephyr_library_compile_options(
  -Wno-error
  -Wno-unused-parameter
  -Wno-unused-variable
  -Wno-unused-function
)

endif() # CONFIG_CLIGEN
