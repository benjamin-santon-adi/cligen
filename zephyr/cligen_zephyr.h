/*
  CLIgen main header for Zephyr RTOS
  Modified from upstream to work with Zephyr flat include structure
  
  Copyright (C) 2001-2022 Olof Hagsand
  Copyright (C) 2024 Benjamin Santon (Zephyr modifications)
  
  SPDX-License-Identifier: Apache-2.0
*/

#ifndef _CLIGEN_ZEPHYR_H_
#define _CLIGEN_ZEPHYR_H_

#include <stdio.h>
#include <zephyr/net/net_ip.h>

/* CLIgen handle - opaque pointer for external API */
#ifndef _CLIGEN_H_
#define _CLIGEN_H_
typedef struct {int a;} *cligen_handle;
#endif  /* _CLIGEN_H_ */

#ifdef __cplusplus
extern "C" {
#endif

/* Include CLIgen headers - using flat structure for Zephyr */
#include "cligen_buf.h"
#include "cligen_cv.h"
#include "cligen_cvec.h"
#include "cligen_parsetree.h"
#include "cligen_pt_head.h"
#include "cligen_callback.h"
#include "cligen_object.h"
#include "cligen_handle.h"
#include "cligen_print.h"
#include "cligen_result.h"
#include "cligen_read.h"
#include "cligen_io.h"
#include "cligen_expand.h"
#include "cligen_syntax.h"
#include "cligen_util.h"
#include "cligen_regex.h"

/* History disabled for embedded - requires file I/O */
/* #include "cligen_history.h" */

#ifdef __cplusplus
} /* extern "C" */
#endif

/* Version strings */
extern const char CLIGEN_VERSION[];

#endif /* _CLIGEN_ZEPHYR_H_ */
