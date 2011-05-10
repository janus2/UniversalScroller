/*
 * UniversalScroller -- Enhancing input methods for BeOS and Haiku 
 *
 * -------------------------------------------------------------------------
 *
 * log.h - Wrapper for logging information
 *
 * -------------------------------------------------------------------------
 * 
 * Copyright (C) 2011  Christian Aistleitner <christian@quelltextlich.at>
 *
 * -------------------------------------------------------------------------
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * -------------------------------------------------------------------------
 */

#ifndef _H_LOG
#define _H_LOG

#include <syslog.h>

#define log( A ) syslog( LOG_DEBUG, A );
#define log2( A, B ) syslog( LOG_DEBUG, A, B );

#endif
