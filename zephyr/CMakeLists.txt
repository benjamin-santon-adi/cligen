# Copyright (c) 2024 Benjamin Santon
# SPDX-License-Identifier: Apache-2.0

if(CONFIG_CLIGEN)

zephyr_library()

# Include directories
zephyr_include_directories(${ZEPHYR_CURRENT_MODULE_DIR})
zephyr_include_directories(${ZEPHYR_CURRENT_MODULE_DIR}/cligen)

# Core CLIgen source files
zephyr_library_sources(
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_buf.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_cv.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_cvec.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_handle.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_io.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_match.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_object.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_print.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_read.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_result.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_syntax.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_tab.c
  ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_util.c
)

# Optionally add parser sources if bison/flex are available
# These would need to be pre-generated for embedded use
if(EXISTS ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_parse.c)
  zephyr_library_sources(
    ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_parse.c
    ${ZEPHYR_CURRENT_MODULE_DIR}/cligen_parsetree.c
  )
endif()

# Compiler flags
zephyr_library_compile_definitions(
  HAVE_CONFIG_H
  _GNU_SOURCE
)

endif() # CONFIG_CLIGEN
