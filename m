From: David Sommerseth <davids@...515...>
Date: Thu,  1 Oct 2020 17:46:58 +0200
Message-Id: <20201001154658.9798-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] compat/lz4: Update to v1.9.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

It's a long while since the bundled lz4 library has received an update.
It pulls in a lot of various fixes and enhancements, some of the changes
fixes compiler warnings and hardens the code a bit too.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/compat/compat-lz4.c | 2191 ++++++++++++++++++++++++++++-----------
 src/compat/compat-lz4.h |  729 +++++++++----
 2 files changed, 2078 insertions(+), 842 deletions(-)

diff --git a/src/compat/compat-lz4.c b/src/compat/compat-lz4.c
index 723157d2..26a3980b 100644
--- a/src/compat/compat-lz4.c
+++ b/src/compat/compat-lz4.c
@@ -1,5 +1,5 @@
 /* This file has been backported by dev-tools/lz4-rebaser.sh
- * from upstream lz4 commit 7bb64ff2b69a9f8367de (v1.7.5)
+ * from upstream lz4 commit fdf2ef5809ca875c4545 (v1.9.2)
  */
 #ifdef HAVE_CONFIG_H
 #include "config.h"
@@ -10,7 +10,7 @@
 #ifdef NEED_COMPAT_LZ4
 /*
    LZ4 - Fast LZ compression algorithm
-   Copyright (C) 2011-2016, Yann Collet.
+   Copyright (C) 2011-present, Yann Collet.
 
    BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
 
@@ -42,17 +42,16 @@
     - LZ4 source repository : https://github.com/lz4/lz4
 */
 
-
 /*-************************************
 *  Tuning parameters
 **************************************/
 /*
- * HEAPMODE :
+ * LZ4_HEAPMODE :
  * Select how default compression functions will allocate memory for their hash table,
  * in memory stack (0:default, fastest), or in memory heap (1:requires malloc()).
  */
-#ifndef HEAPMODE
-#  define HEAPMODE 0
+#ifndef LZ4_HEAPMODE
+#  define LZ4_HEAPMODE 0
 #endif
 
 /*
@@ -73,16 +72,17 @@
  * Method 1 : `__packed` statement. It depends on compiler extension (ie, not portable).
  *            This method is safe if your compiler supports it, and *generally* as fast or faster than `memcpy`.
  * Method 2 : direct access. This method is portable but violate C standard.
- *            It can generate buggy code on targets which generate assembly depending on alignment.
+ *            It can generate buggy code on targets which assembly generation depends on alignment.
  *            But in some circumstances, it's the only known way to get the most performance (ie GCC + ARMv6)
  * See https://fastcompression.blogspot.fr/2015/08/accessing-unaligned-memory.html for details.
  * Prefer these methods in priority order (0 > 1 > 2)
  */
-#ifndef LZ4_FORCE_MEMORY_ACCESS   /* can be defined externally, on command line for example */
-#  if defined(__GNUC__) && ( defined(__ARM_ARCH_6__) || defined(__ARM_ARCH_6J__) || defined(__ARM_ARCH_6K__) || defined(__ARM_ARCH_6Z__) || defined(__ARM_ARCH_6ZK__) || defined(__ARM_ARCH_6T2__) )
+#ifndef LZ4_FORCE_MEMORY_ACCESS   /* can be defined externally */
+#  if defined(__GNUC__) && \
+  ( defined(__ARM_ARCH_6__) || defined(__ARM_ARCH_6J__) || defined(__ARM_ARCH_6K__) \
+  || defined(__ARM_ARCH_6Z__) || defined(__ARM_ARCH_6ZK__) || defined(__ARM_ARCH_6T2__) )
 #    define LZ4_FORCE_MEMORY_ACCESS 2
-#  elif defined(__INTEL_COMPILER) || \
-  (defined(__GNUC__) && ( defined(__ARM_ARCH_7__) || defined(__ARM_ARCH_7A__) || defined(__ARM_ARCH_7R__) || defined(__ARM_ARCH_7M__) || defined(__ARM_ARCH_7S__) ))
+#  elif (defined(__INTEL_COMPILER) && !defined(_WIN32)) || defined(__GNUC__)
 #    define LZ4_FORCE_MEMORY_ACCESS 1
 #  endif
 #endif
@@ -91,14 +91,32 @@
  * LZ4_FORCE_SW_BITCOUNT
  * Define this parameter if your target system or compiler does not support hardware bit count
  */
-#if defined(_MSC_VER) && defined(_WIN32_WCE)   /* Visual Studio for Windows CE does not support Hardware bit count */
+#if defined(_MSC_VER) && defined(_WIN32_WCE)   /* Visual Studio for WinCE doesn't support Hardware bit count */
 #  define LZ4_FORCE_SW_BITCOUNT
 #endif
 
 
+
 /*-************************************
 *  Dependency
 **************************************/
+/*
+ * LZ4_SRC_INCLUDED:
+ * Amalgamation flag, whether lz4.c is included
+ */
+#ifndef LZ4_SRC_INCLUDED
+#  define LZ4_SRC_INCLUDED 1
+#endif
+
+#ifndef LZ4_STATIC_LINKING_ONLY
+#define LZ4_STATIC_LINKING_ONLY
+#endif
+
+#ifndef LZ4_DISABLE_DEPRECATE_WARNINGS
+#define LZ4_DISABLE_DEPRECATE_WARNINGS /* due to LZ4_decompress_safe_withPrefix64k */
+#endif
+
+#define LZ4_STATIC_LINKING_ONLY  /* LZ4_DISTANCE_MAX */
 #include "compat-lz4.h"
 /* see also "memory routines" below */
 
@@ -107,42 +125,130 @@
 *  Compiler Options
 **************************************/
 #ifdef _MSC_VER    /* Visual Studio */
-#  define FORCE_INLINE static __forceinline
 #  include <intrin.h>
 #  pragma warning(disable : 4127)        /* disable: C4127: conditional expression is constant */
 #  pragma warning(disable : 4293)        /* disable: C4293: too large shift (32-bits) */
-#else
-#  if defined(__GNUC__) || defined(__clang__)
-#    define FORCE_INLINE static inline __attribute__((always_inline))
-#  elif defined(__cplusplus) || (defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) /* C99 */)
-#    define FORCE_INLINE static inline
-#  else
-#    define FORCE_INLINE static
-#  endif
 #endif  /* _MSC_VER */
 
+#ifndef LZ4_FORCE_INLINE
+#  ifdef _MSC_VER    /* Visual Studio */
+#    define LZ4_FORCE_INLINE static __forceinline
+#  else
+#    if defined (__cplusplus) || defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L   /* C99 */
+#      ifdef __GNUC__
+#        define LZ4_FORCE_INLINE static inline __attribute__((always_inline))
+#      else
+#        define LZ4_FORCE_INLINE static inline
+#      endif
+#    else
+#      define LZ4_FORCE_INLINE static
+#    endif /* __STDC_VERSION__ */
+#  endif  /* _MSC_VER */
+#endif /* LZ4_FORCE_INLINE */
+
+/* LZ4_FORCE_O2_GCC_PPC64LE and LZ4_FORCE_O2_INLINE_GCC_PPC64LE
+ * gcc on ppc64le generates an unrolled SIMDized loop for LZ4_wildCopy8,
+ * together with a simple 8-byte copy loop as a fall-back path.
+ * However, this optimization hurts the decompression speed by >30%,
+ * because the execution does not go to the optimized loop
+ * for typical compressible data, and all of the preamble checks
+ * before going to the fall-back path become useless overhead.
+ * This optimization happens only with the -O3 flag, and -O2 generates
+ * a simple 8-byte copy loop.
+ * With gcc on ppc64le, all of the LZ4_decompress_* and LZ4_wildCopy8
+ * functions are annotated with __attribute__((optimize("O2"))),
+ * and also LZ4_wildCopy8 is forcibly inlined, so that the O2 attribute
+ * of LZ4_wildCopy8 does not affect the compression speed.
+ */
+#if defined(__PPC64__) && defined(__LITTLE_ENDIAN__) && defined(__GNUC__) && !defined(__clang__)
+#  define LZ4_FORCE_O2_GCC_PPC64LE __attribute__((optimize("O2")))
+#  define LZ4_FORCE_O2_INLINE_GCC_PPC64LE __attribute__((optimize("O2"))) LZ4_FORCE_INLINE
+#else
+#  define LZ4_FORCE_O2_GCC_PPC64LE
+#  define LZ4_FORCE_O2_INLINE_GCC_PPC64LE static
+#endif
+
 #if (defined(__GNUC__) && (__GNUC__ >= 3)) || (defined(__INTEL_COMPILER) && (__INTEL_COMPILER >= 800)) || defined(__clang__)
 #  define expect(expr,value)    (__builtin_expect ((expr),(value)) )
 #else
 #  define expect(expr,value)    (expr)
 #endif
 
+#ifndef likely
 #define likely(expr)     expect((expr) != 0, 1)
+#endif
+#ifndef unlikely
 #define unlikely(expr)   expect((expr) != 0, 0)
+#endif
 
 
 /*-************************************
 *  Memory routines
 **************************************/
 #include <stdlib.h>   /* malloc, calloc, free */
-#define ALLOCATOR(n,s) calloc(n,s)
-#define FREEMEM        free
+#define ALLOC(s)          malloc(s)
+#define ALLOC_AND_ZERO(s) calloc(1,s)
+#define FREEMEM(p)        free(p)
 #include <string.h>   /* memset, memcpy */
-#define MEM_INIT       memset
+#define MEM_INIT(p,v,s)   memset((p),(v),(s))
 
 
 /*-************************************
-*  Basic Types
+*  Common Constants
+**************************************/
+#define MINMATCH 4
+
+#define WILDCOPYLENGTH 8
+#define LASTLITERALS   5   /* see ../doc/lz4_Block_format.md#parsing-restrictions */
+#define MFLIMIT       12   /* see ../doc/lz4_Block_format.md#parsing-restrictions */
+#define MATCH_SAFEGUARD_DISTANCE  ((2*WILDCOPYLENGTH) - MINMATCH)   /* ensure it's possible to write 2 x wildcopyLength without overflowing output buffer */
+#define FASTLOOP_SAFE_DISTANCE 64
+static const int LZ4_minLength = (MFLIMIT+1);
+
+#define KB *(1 <<10)
+#define MB *(1 <<20)
+#define GB *(1U<<30)
+
+#define LZ4_DISTANCE_ABSOLUTE_MAX 65535
+#if (LZ4_DISTANCE_MAX > LZ4_DISTANCE_ABSOLUTE_MAX)   /* max supported by LZ4 format */
+#  error "LZ4_DISTANCE_MAX is too big : must be <= 65535"
+#endif
+
+#define ML_BITS  4
+#define ML_MASK  ((1U<<ML_BITS)-1)
+#define RUN_BITS (8-ML_BITS)
+#define RUN_MASK ((1U<<RUN_BITS)-1)
+
+
+/*-************************************
+*  Error detection
+**************************************/
+#if defined(LZ4_DEBUG) && (LZ4_DEBUG>=1)
+#  include <assert.h>
+#else
+#  ifndef assert
+#    define assert(condition) ((void)0)
+#  endif
+#endif
+
+#define LZ4_STATIC_ASSERT(c)   { enum { LZ4_static_assert = 1/(int)(!!(c)) }; }   /* use after variable declarations */
+
+#if defined(LZ4_DEBUG) && (LZ4_DEBUG>=2)
+#  include <stdio.h>
+static int g_debuglog_enable = 1;
+#  define DEBUGLOG(l, ...) {                                  \
+                if ((g_debuglog_enable) && (l<=LZ4_DEBUG)) {  \
+                    fprintf(stderr, __FILE__ ": ");           \
+                    fprintf(stderr, __VA_ARGS__);             \
+                    fprintf(stderr, " \n");                   \
+            }   }
+#else
+#  define DEBUGLOG(l, ...)      {}    /* disabled */
+#endif
+
+
+/*-************************************
+*  Types
 **************************************/
 #if defined(__cplusplus) || (defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) /* C99 */)
 # include <stdint.h>
@@ -167,6 +273,13 @@
   typedef size_t reg_t;   /* 32-bits in x32 mode */
 #endif
 
+typedef enum {
+    notLimited = 0,
+    limitedOutput = 1,
+    fillOutput = 2
+} limitedOutput_directive;
+
+
 /*-************************************
 *  Reading and writing into memory
 **************************************/
@@ -200,7 +313,7 @@ static reg_t LZ4_read_ARCH(const void* ptr) { return ((const unalign*)ptr)->uArc
 static void LZ4_write16(void* memPtr, U16 value) { ((unalign*)memPtr)->u16 = value; }
 static void LZ4_write32(void* memPtr, U32 value) { ((unalign*)memPtr)->u32 = value; }
 
-#else  /* safe and portable access through memcpy() */
+#else  /* safe and portable access using memcpy() */
 
 static U16 LZ4_read16(const void* memPtr)
 {
@@ -251,55 +364,113 @@ static void LZ4_writeLE16(void* memPtr, U16 value)
     }
 }
 
-static void LZ4_copy8(void* dst, const void* src)
-{
-    memcpy(dst,src,8);
-}
-
 /* customized variant of memcpy, which can overwrite up to 8 bytes beyond dstEnd */
-static void LZ4_wildCopy(void* dstPtr, const void* srcPtr, void* dstEnd)
+LZ4_FORCE_O2_INLINE_GCC_PPC64LE
+void LZ4_wildCopy8(void* dstPtr, const void* srcPtr, void* dstEnd)
 {
     BYTE* d = (BYTE*)dstPtr;
     const BYTE* s = (const BYTE*)srcPtr;
     BYTE* const e = (BYTE*)dstEnd;
 
-    do { LZ4_copy8(d,s); d+=8; s+=8; } while (d<e);
+    do { memcpy(d,s,8); d+=8; s+=8; } while (d<e);
 }
 
+static const unsigned inc32table[8] = {0, 1, 2,  1,  0,  4, 4, 4};
+static const int      dec64table[8] = {0, 0, 0, -1, -4,  1, 2, 3};
 
-/*-************************************
-*  Common Constants
-**************************************/
-#define MINMATCH 4
 
-#define WILDCOPYLENGTH 8
-#define LASTLITERALS 5
-#define MFLIMIT (WILDCOPYLENGTH+MINMATCH)
-static const int LZ4_minLength = (MFLIMIT+1);
+#ifndef LZ4_FAST_DEC_LOOP
+#  if defined(__i386__) || defined(__x86_64__)
+#    define LZ4_FAST_DEC_LOOP 1
+#  elif defined(__aarch64__) && !defined(__clang__)
+     /* On aarch64, we disable this optimization for clang because on certain
+      * mobile chipsets and clang, it reduces performance. For more information
+      * refer to https://github.com/lz4/lz4/pull/707. */
+#    define LZ4_FAST_DEC_LOOP 1
+#  else
+#    define LZ4_FAST_DEC_LOOP 0
+#  endif
+#endif
 
-#define KB *(1 <<10)
-#define MB *(1 <<20)
-#define GB *(1U<<30)
+#if LZ4_FAST_DEC_LOOP
 
-#define MAXD_LOG 16
-#define MAX_DISTANCE ((1 << MAXD_LOG) - 1)
+LZ4_FORCE_O2_INLINE_GCC_PPC64LE void
+LZ4_memcpy_using_offset_base(BYTE* dstPtr, const BYTE* srcPtr, BYTE* dstEnd, const size_t offset)
+{
+    if (offset < 8) {
+        dstPtr[0] = srcPtr[0];
+        dstPtr[1] = srcPtr[1];
+        dstPtr[2] = srcPtr[2];
+        dstPtr[3] = srcPtr[3];
+        srcPtr += inc32table[offset];
+        memcpy(dstPtr+4, srcPtr, 4);
+        srcPtr -= dec64table[offset];
+        dstPtr += 8;
+    } else {
+        memcpy(dstPtr, srcPtr, 8);
+        dstPtr += 8;
+        srcPtr += 8;
+    }
 
-#define ML_BITS  4
-#define ML_MASK  ((1U<<ML_BITS)-1)
-#define RUN_BITS (8-ML_BITS)
-#define RUN_MASK ((1U<<RUN_BITS)-1)
+    LZ4_wildCopy8(dstPtr, srcPtr, dstEnd);
+}
 
+/* customized variant of memcpy, which can overwrite up to 32 bytes beyond dstEnd
+ * this version copies two times 16 bytes (instead of one time 32 bytes)
+ * because it must be compatible with offsets >= 16. */
+LZ4_FORCE_O2_INLINE_GCC_PPC64LE void
+LZ4_wildCopy32(void* dstPtr, const void* srcPtr, void* dstEnd)
+{
+    BYTE* d = (BYTE*)dstPtr;
+    const BYTE* s = (const BYTE*)srcPtr;
+    BYTE* const e = (BYTE*)dstEnd;
 
-/*-************************************
-*  Common Utils
-**************************************/
-#define LZ4_STATIC_ASSERT(c)    { enum { LZ4_static_assert = 1/(int)(!!(c)) }; }   /* use only *after* variable declarations */
+    do { memcpy(d,s,16); memcpy(d+16,s+16,16); d+=32; s+=32; } while (d<e);
+}
+
+/* LZ4_memcpy_using_offset()  presumes :
+ * - dstEnd >= dstPtr + MINMATCH
+ * - there is at least 8 bytes available to write after dstEnd */
+LZ4_FORCE_O2_INLINE_GCC_PPC64LE void
+LZ4_memcpy_using_offset(BYTE* dstPtr, const BYTE* srcPtr, BYTE* dstEnd, const size_t offset)
+{
+    BYTE v[8];
+
+    assert(dstEnd >= dstPtr + MINMATCH);
+    LZ4_write32(dstPtr, 0);   /* silence an msan warning when offset==0 */
+
+    switch(offset) {
+    case 1:
+        memset(v, *srcPtr, 8);
+        break;
+    case 2:
+        memcpy(v, srcPtr, 2);
+        memcpy(&v[2], srcPtr, 2);
+        memcpy(&v[4], &v[0], 4);
+        break;
+    case 4:
+        memcpy(v, srcPtr, 4);
+        memcpy(&v[4], srcPtr, 4);
+        break;
+    default:
+        LZ4_memcpy_using_offset_base(dstPtr, srcPtr, dstEnd, offset);
+        return;
+    }
+
+    memcpy(dstPtr, v, 8);
+    dstPtr += 8;
+    while (dstPtr < dstEnd) {
+        memcpy(dstPtr, v, 8);
+        dstPtr += 8;
+    }
+}
+#endif
 
 
 /*-************************************
 *  Common functions
 **************************************/
-static unsigned LZ4_NbCommonBytes (register reg_t val)
+static unsigned LZ4_NbCommonBytes (reg_t val)
 {
     if (LZ4_isLittleEndian()) {
         if (sizeof(val)==8) {
@@ -308,9 +479,16 @@ static unsigned LZ4_NbCommonBytes (register reg_t val)
             _BitScanForward64( &r, (U64)val );
             return (int)(r>>3);
 #       elif (defined(__clang__) || (defined(__GNUC__) && (__GNUC__>=3))) && !defined(LZ4_FORCE_SW_BITCOUNT)
-            return (__builtin_ctzll((U64)val) >> 3);
+            return (unsigned)__builtin_ctzll((U64)val) >> 3;
 #       else
-            static const int DeBruijnBytePos[64] = { 0, 0, 0, 0, 0, 1, 1, 2, 0, 3, 1, 3, 1, 4, 2, 7, 0, 2, 3, 6, 1, 5, 3, 5, 1, 3, 4, 4, 2, 5, 6, 7, 7, 0, 1, 2, 3, 3, 4, 6, 2, 6, 5, 5, 3, 4, 5, 6, 7, 1, 2, 4, 6, 4, 4, 5, 7, 2, 6, 5, 7, 6, 7, 7 };
+            static const int DeBruijnBytePos[64] = { 0, 0, 0, 0, 0, 1, 1, 2,
+                                                     0, 3, 1, 3, 1, 4, 2, 7,
+                                                     0, 2, 3, 6, 1, 5, 3, 5,
+                                                     1, 3, 4, 4, 2, 5, 6, 7,
+                                                     7, 0, 1, 2, 3, 3, 4, 6,
+                                                     2, 6, 5, 5, 3, 4, 5, 6,
+                                                     7, 1, 2, 4, 6, 4, 4, 5,
+                                                     7, 2, 6, 5, 7, 6, 7, 7 };
             return DeBruijnBytePos[((U64)((val & -(long long)val) * 0x0218A392CDABBD3FULL)) >> 58];
 #       endif
         } else /* 32 bits */ {
@@ -319,23 +497,29 @@ static unsigned LZ4_NbCommonBytes (register reg_t val)
             _BitScanForward( &r, (U32)val );
             return (int)(r>>3);
 #       elif (defined(__clang__) || (defined(__GNUC__) && (__GNUC__>=3))) && !defined(LZ4_FORCE_SW_BITCOUNT)
-            return (__builtin_ctz((U32)val) >> 3);
+            return (unsigned)__builtin_ctz((U32)val) >> 3;
 #       else
-            static const int DeBruijnBytePos[32] = { 0, 0, 3, 0, 3, 1, 3, 0, 3, 2, 2, 1, 3, 2, 0, 1, 3, 3, 1, 2, 2, 2, 2, 0, 3, 1, 2, 0, 1, 0, 1, 1 };
+            static const int DeBruijnBytePos[32] = { 0, 0, 3, 0, 3, 1, 3, 0,
+                                                     3, 2, 2, 1, 3, 2, 0, 1,
+                                                     3, 3, 1, 2, 2, 2, 2, 0,
+                                                     3, 1, 2, 0, 1, 0, 1, 1 };
             return DeBruijnBytePos[((U32)((val & -(S32)val) * 0x077CB531U)) >> 27];
 #       endif
         }
     } else   /* Big Endian CPU */ {
-        if (sizeof(val)==8) {
+        if (sizeof(val)==8) {   /* 64-bits */
 #       if defined(_MSC_VER) && defined(_WIN64) && !defined(LZ4_FORCE_SW_BITCOUNT)
             unsigned long r = 0;
             _BitScanReverse64( &r, val );
             return (unsigned)(r>>3);
 #       elif (defined(__clang__) || (defined(__GNUC__) && (__GNUC__>=3))) && !defined(LZ4_FORCE_SW_BITCOUNT)
-            return (__builtin_clzll((U64)val) >> 3);
+            return (unsigned)__builtin_clzll((U64)val) >> 3;
 #       else
+            static const U32 by32 = sizeof(val)*4;  /* 32 on 64 bits (goal), 16 on 32 bits.
+                Just to avoid some static analyzer complaining about shift by 32 on 32-bits target.
+                Note that this code path is never triggered in 32-bits mode. */
             unsigned r;
-            if (!(val>>32)) { r=4; } else { r=0; val>>=32; }
+            if (!(val>>by32)) { r=4; } else { r=0; val>>=by32; }
             if (!(val>>16)) { r+=2; val>>=8; } else { val>>=24; }
             r += (!val);
             return r;
@@ -346,7 +530,7 @@ static unsigned LZ4_NbCommonBytes (register reg_t val)
             _BitScanReverse( &r, (unsigned long)val );
             return (unsigned)(r>>3);
 #       elif (defined(__clang__) || (defined(__GNUC__) && (__GNUC__>=3))) && !defined(LZ4_FORCE_SW_BITCOUNT)
-            return (__builtin_clz((U32)val) >> 3);
+            return (unsigned)__builtin_clz((U32)val) >> 3;
 #       else
             unsigned r;
             if (!(val>>16)) { r=2; val>>=8; } else { r=0; val>>=24; }
@@ -358,11 +542,20 @@ static unsigned LZ4_NbCommonBytes (register reg_t val)
 }
 
 #define STEPSIZE sizeof(reg_t)
-static unsigned LZ4_count(const BYTE* pIn, const BYTE* pMatch, const BYTE* pInLimit)
+LZ4_FORCE_INLINE
+unsigned LZ4_count(const BYTE* pIn, const BYTE* pMatch, const BYTE* pInLimit)
 {
     const BYTE* const pStart = pIn;
 
-    while (likely(pIn<pInLimit-(STEPSIZE-1))) {
+    if (likely(pIn < pInLimit-(STEPSIZE-1))) {
+        reg_t const diff = LZ4_read_ARCH(pMatch) ^ LZ4_read_ARCH(pIn);
+        if (!diff) {
+            pIn+=STEPSIZE; pMatch+=STEPSIZE;
+        } else {
+            return LZ4_NbCommonBytes(diff);
+    }   }
+
+    while (likely(pIn < pInLimit-(STEPSIZE-1))) {
         reg_t const diff = LZ4_read_ARCH(pMatch) ^ LZ4_read_ARCH(pIn);
         if (!diff) { pIn+=STEPSIZE; pMatch+=STEPSIZE; continue; }
         pIn += LZ4_NbCommonBytes(diff);
@@ -387,15 +580,34 @@ static const U32 LZ4_skipTrigger = 6;  /* Increase this value ==> compression ru
 /*-************************************
 *  Local Structures and types
 **************************************/
-typedef enum { notLimited = 0, limitedOutput = 1 } limitedOutput_directive;
-typedef enum { byPtr, byU32, byU16 } tableType_t;
+typedef enum { clearedTable = 0, byPtr, byU32, byU16 } tableType_t;
 
-typedef enum { noDict = 0, withPrefix64k, usingExtDict } dict_directive;
+/**
+ * This enum distinguishes several different modes of accessing previous
+ * content in the stream.
+ *
+ * - noDict        : There is no preceding content.
+ * - withPrefix64k : Table entries up to ctx->dictSize before the current blob
+ *                   blob being compressed are valid and refer to the preceding
+ *                   content (of length ctx->dictSize), which is available
+ *                   contiguously preceding in memory the content currently
+ *                   being compressed.
+ * - usingExtDict  : Like withPrefix64k, but the preceding content is somewhere
+ *                   else in memory, starting at ctx->dictionary with length
+ *                   ctx->dictSize.
+ * - usingDictCtx  : Like usingExtDict, but everything concerning the preceding
+ *                   content is in a separate context, pointed to by
+ *                   ctx->dictCtx. ctx->dictionary, ctx->dictSize, and table
+ *                   entries in the current context that refer to positions
+ *                   preceding the beginning of the current compression are
+ *                   ignored. Instead, ctx->dictCtx->dictionary and ctx->dictCtx
+ *                   ->dictSize describe the location and size of the preceding
+ *                   content, and matches are found by looking in the ctx
+ *                   ->dictCtx->hashTable.
+ */
+typedef enum { noDict = 0, withPrefix64k, usingExtDict, usingDictCtx } dict_directive;
 typedef enum { noDictIssue = 0, dictSmall } dictIssue_directive;
 
-typedef enum { endOnOutputSize = 0, endOnInputSize = 1 } endCondition_directive;
-typedef enum { full = 0, partial = 1 } earlyEnd_directive;
-
 
 /*-************************************
 *  Local Utils
@@ -406,6 +618,23 @@ int LZ4_compressBound(int isize)  { return LZ4_COMPRESSBOUND(isize); }
 int LZ4_sizeofState() { return LZ4_STREAMSIZE; }
 
 
+/*-************************************
+*  Internal Definitions used in Tests
+**************************************/
+#if defined (__cplusplus)
+extern "C" {
+#endif
+
+int LZ4_compress_forceExtDict (LZ4_stream_t* LZ4_dict, const char* source, char* dest, int srcSize);
+
+int LZ4_decompress_safe_forceExtDict(const char* source, char* dest,
+                                     int compressedSize, int maxOutputSize,
+                                     const void* dictStart, size_t dictSize);
+
+#if defined (__cplusplus)
+}
+#endif
+
 /*-******************************
 *  Compression functions
 ********************************/
@@ -419,102 +648,225 @@ static U32 LZ4_hash4(U32 sequence, tableType_t const tableType)
 
 static U32 LZ4_hash5(U64 sequence, tableType_t const tableType)
 {
-    static const U64 prime5bytes = 889523592379ULL;
-    static const U64 prime8bytes = 11400714785074694791ULL;
     const U32 hashLog = (tableType == byU16) ? LZ4_HASHLOG+1 : LZ4_HASHLOG;
-    if (LZ4_isLittleEndian())
+    if (LZ4_isLittleEndian()) {
+        const U64 prime5bytes = 889523592379ULL;
         return (U32)(((sequence << 24) * prime5bytes) >> (64 - hashLog));
-    else
+    } else {
+        const U64 prime8bytes = 11400714785074694791ULL;
         return (U32)(((sequence >> 24) * prime8bytes) >> (64 - hashLog));
+    }
 }
 
-FORCE_INLINE U32 LZ4_hashPosition(const void* const p, tableType_t const tableType)
+LZ4_FORCE_INLINE U32 LZ4_hashPosition(const void* const p, tableType_t const tableType)
 {
     if ((sizeof(reg_t)==8) && (tableType != byU16)) return LZ4_hash5(LZ4_read_ARCH(p), tableType);
     return LZ4_hash4(LZ4_read32(p), tableType);
 }
 
-static void LZ4_putPositionOnHash(const BYTE* p, U32 h, void* tableBase, tableType_t const tableType, const BYTE* srcBase)
+static void LZ4_clearHash(U32 h, void* tableBase, tableType_t const tableType)
 {
     switch (tableType)
     {
+    default: /* fallthrough */
+    case clearedTable: { /* illegal! */ assert(0); return; }
+    case byPtr: { const BYTE** hashTable = (const BYTE**)tableBase; hashTable[h] = NULL; return; }
+    case byU32: { U32* hashTable = (U32*) tableBase; hashTable[h] = 0; return; }
+    case byU16: { U16* hashTable = (U16*) tableBase; hashTable[h] = 0; return; }
+    }
+}
+
+static void LZ4_putIndexOnHash(U32 idx, U32 h, void* tableBase, tableType_t const tableType)
+{
+    switch (tableType)
+    {
+    default: /* fallthrough */
+    case clearedTable: /* fallthrough */
+    case byPtr: { /* illegal! */ assert(0); return; }
+    case byU32: { U32* hashTable = (U32*) tableBase; hashTable[h] = idx; return; }
+    case byU16: { U16* hashTable = (U16*) tableBase; assert(idx < 65536); hashTable[h] = (U16)idx; return; }
+    }
+}
+
+static void LZ4_putPositionOnHash(const BYTE* p, U32 h,
+                                  void* tableBase, tableType_t const tableType,
+                            const BYTE* srcBase)
+{
+    switch (tableType)
+    {
+    case clearedTable: { /* illegal! */ assert(0); return; }
     case byPtr: { const BYTE** hashTable = (const BYTE**)tableBase; hashTable[h] = p; return; }
     case byU32: { U32* hashTable = (U32*) tableBase; hashTable[h] = (U32)(p-srcBase); return; }
     case byU16: { U16* hashTable = (U16*) tableBase; hashTable[h] = (U16)(p-srcBase); return; }
     }
 }
 
-FORCE_INLINE void LZ4_putPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
+LZ4_FORCE_INLINE void LZ4_putPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
 {
     U32 const h = LZ4_hashPosition(p, tableType);
     LZ4_putPositionOnHash(p, h, tableBase, tableType, srcBase);
 }
 
-static const BYTE* LZ4_getPositionOnHash(U32 h, void* tableBase, tableType_t tableType, const BYTE* srcBase)
+/* LZ4_getIndexOnHash() :
+ * Index of match position registered in hash table.
+ * hash position must be calculated by using base+index, or dictBase+index.
+ * Assumption 1 : only valid if tableType == byU32 or byU16.
+ * Assumption 2 : h is presumed valid (within limits of hash table)
+ */
+static U32 LZ4_getIndexOnHash(U32 h, const void* tableBase, tableType_t tableType)
 {
-    if (tableType == byPtr) { const BYTE** hashTable = (const BYTE**) tableBase; return hashTable[h]; }
-    if (tableType == byU32) { const U32* const hashTable = (U32*) tableBase; return hashTable[h] + srcBase; }
-    { const U16* const hashTable = (U16*) tableBase; return hashTable[h] + srcBase; }   /* default, to ensure a return */
+    LZ4_STATIC_ASSERT(LZ4_MEMORY_USAGE > 2);
+    if (tableType == byU32) {
+        const U32* const hashTable = (const U32*) tableBase;
+        assert(h < (1U << (LZ4_MEMORY_USAGE-2)));
+        return hashTable[h];
+    }
+    if (tableType == byU16) {
+        const U16* const hashTable = (const U16*) tableBase;
+        assert(h < (1U << (LZ4_MEMORY_USAGE-1)));
+        return hashTable[h];
+    }
+    assert(0); return 0;  /* forbidden case */
 }
 
-FORCE_INLINE const BYTE* LZ4_getPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
+static const BYTE* LZ4_getPositionOnHash(U32 h, const void* tableBase, tableType_t tableType, const BYTE* srcBase)
+{
+    if (tableType == byPtr) { const BYTE* const* hashTable = (const BYTE* const*) tableBase; return hashTable[h]; }
+    if (tableType == byU32) { const U32* const hashTable = (const U32*) tableBase; return hashTable[h] + srcBase; }
+    { const U16* const hashTable = (const U16*) tableBase; return hashTable[h] + srcBase; }   /* default, to ensure a return */
+}
+
+LZ4_FORCE_INLINE const BYTE*
+LZ4_getPosition(const BYTE* p,
+                const void* tableBase, tableType_t tableType,
+                const BYTE* srcBase)
 {
     U32 const h = LZ4_hashPosition(p, tableType);
     return LZ4_getPositionOnHash(h, tableBase, tableType, srcBase);
 }
 
+LZ4_FORCE_INLINE void
+LZ4_prepareTable(LZ4_stream_t_internal* const cctx,
+           const int inputSize,
+           const tableType_t tableType) {
+    /* If compression failed during the previous step, then the context
+     * is marked as dirty, therefore, it has to be fully reset.
+     */
+    if (cctx->dirty) {
+        DEBUGLOG(5, "LZ4_prepareTable: Full reset for %p", cctx);
+        MEM_INIT(cctx, 0, sizeof(LZ4_stream_t_internal));
+        return;
+    }
+
+    /* If the table hasn't been used, it's guaranteed to be zeroed out, and is
+     * therefore safe to use no matter what mode we're in. Otherwise, we figure
+     * out if it's safe to leave as is or whether it needs to be reset.
+     */
+    if (cctx->tableType != clearedTable) {
+        assert(inputSize >= 0);
+        if (cctx->tableType != tableType
+          || ((tableType == byU16) && cctx->currentOffset + (unsigned)inputSize >= 0xFFFFU)
+          || ((tableType == byU32) && cctx->currentOffset > 1 GB)
+          || tableType == byPtr
+          || inputSize >= 4 KB)
+        {
+            DEBUGLOG(4, "LZ4_prepareTable: Resetting table in %p", cctx);
+            MEM_INIT(cctx->hashTable, 0, LZ4_HASHTABLESIZE);
+            cctx->currentOffset = 0;
+            cctx->tableType = clearedTable;
+        } else {
+            DEBUGLOG(4, "LZ4_prepareTable: Re-use hash table (no reset)");
+        }
+    }
+
+    /* Adding a gap, so all previous entries are > LZ4_DISTANCE_MAX back, is faster
+     * than compressing without a gap. However, compressing with
+     * currentOffset == 0 is faster still, so we preserve that case.
+     */
+    if (cctx->currentOffset != 0 && tableType == byU32) {
+        DEBUGLOG(5, "LZ4_prepareTable: adding 64KB to currentOffset");
+        cctx->currentOffset += 64 KB;
+    }
+
+    /* Finally, clear history */
+    cctx->dictCtx = NULL;
+    cctx->dictionary = NULL;
+    cctx->dictSize = 0;
+}
 
 /** LZ4_compress_generic() :
     inlined, to ensure branches are decided at compilation time */
-FORCE_INLINE int LZ4_compress_generic(
+LZ4_FORCE_INLINE int LZ4_compress_generic(
                  LZ4_stream_t_internal* const cctx,
                  const char* const source,
                  char* const dest,
                  const int inputSize,
+                 int *inputConsumed, /* only written when outputDirective == fillOutput */
                  const int maxOutputSize,
-                 const limitedOutput_directive outputLimited,
+                 const limitedOutput_directive outputDirective,
                  const tableType_t tableType,
-                 const dict_directive dict,
+                 const dict_directive dictDirective,
                  const dictIssue_directive dictIssue,
-                 const U32 acceleration)
+                 const int acceleration)
 {
+    int result;
     const BYTE* ip = (const BYTE*) source;
-    const BYTE* base;
+
+    U32 const startIndex = cctx->currentOffset;
+    const BYTE* base = (const BYTE*) source - startIndex;
     const BYTE* lowLimit;
-    const BYTE* const lowRefLimit = ip - cctx->dictSize;
-    const BYTE* const dictionary = cctx->dictionary;
-    const BYTE* const dictEnd = dictionary + cctx->dictSize;
-    const ptrdiff_t dictDelta = dictEnd - (const BYTE*)source;
+
+    const LZ4_stream_t_internal* dictCtx = (const LZ4_stream_t_internal*) cctx->dictCtx;
+    const BYTE* const dictionary =
+        dictDirective == usingDictCtx ? dictCtx->dictionary : cctx->dictionary;
+    const U32 dictSize =
+        dictDirective == usingDictCtx ? dictCtx->dictSize : cctx->dictSize;
+    const U32 dictDelta = (dictDirective == usingDictCtx) ? startIndex - dictCtx->currentOffset : 0;   /* make indexes in dictCtx comparable with index in current context */
+
+    int const maybe_extMem = (dictDirective == usingExtDict) || (dictDirective == usingDictCtx);
+    U32 const prefixIdxLimit = startIndex - dictSize;   /* used when dictDirective == dictSmall */
+    const BYTE* const dictEnd = dictionary + dictSize;
     const BYTE* anchor = (const BYTE*) source;
     const BYTE* const iend = ip + inputSize;
-    const BYTE* const mflimit = iend - MFLIMIT;
+    const BYTE* const mflimitPlusOne = iend - MFLIMIT + 1;
     const BYTE* const matchlimit = iend - LASTLITERALS;
 
+    /* the dictCtx currentOffset is indexed on the start of the dictionary,
+     * while a dictionary in the current context precedes the currentOffset */
+    const BYTE* dictBase = (dictDirective == usingDictCtx) ?
+                            dictionary + dictSize - dictCtx->currentOffset :
+                            dictionary + dictSize - startIndex;
+
     BYTE* op = (BYTE*) dest;
     BYTE* const olimit = op + maxOutputSize;
 
+    U32 offset = 0;
     U32 forwardH;
 
-    /* Init conditions */
-    if ((U32)inputSize > (U32)LZ4_MAX_INPUT_SIZE) return 0;   /* Unsupported inputSize, too large (or negative) */
-    switch(dict)
-    {
-    case noDict:
-    default:
-        base = (const BYTE*)source;
-        lowLimit = (const BYTE*)source;
-        break;
-    case withPrefix64k:
-        base = (const BYTE*)source - cctx->currentOffset;
-        lowLimit = (const BYTE*)source - cctx->dictSize;
-        break;
-    case usingExtDict:
-        base = (const BYTE*)source - cctx->currentOffset;
-        lowLimit = (const BYTE*)source;
-        break;
+    DEBUGLOG(5, "LZ4_compress_generic: srcSize=%i, tableType=%u", inputSize, tableType);
+    /* If init conditions are not met, we don't have to mark stream
+     * as having dirty context, since no action was taken yet */
+    if (outputDirective == fillOutput && maxOutputSize < 1) { return 0; } /* Impossible to store anything */
+    if ((U32)inputSize > (U32)LZ4_MAX_INPUT_SIZE) { return 0; }           /* Unsupported inputSize, too large (or negative) */
+    if ((tableType == byU16) && (inputSize>=LZ4_64Klimit)) { return 0; }  /* Size too large (not within 64K limit) */
+    if (tableType==byPtr) assert(dictDirective==noDict);      /* only supported use case with byPtr */
+    assert(acceleration >= 1);
+
+    lowLimit = (const BYTE*)source - (dictDirective == withPrefix64k ? dictSize : 0);
+
+    /* Update context state */
+    if (dictDirective == usingDictCtx) {
+        /* Subsequent linked blocks can't use the dictionary. */
+        /* Instead, they use the block we just compressed. */
+        cctx->dictCtx = NULL;
+        cctx->dictSize = (U32)inputSize;
+    } else {
+        cctx->dictSize += (U32)inputSize;
     }
-    if ((tableType == byU16) && (inputSize>=LZ4_64Klimit)) return 0;   /* Size too large (not within 64K limit) */
-    if (inputSize<LZ4_minLength) goto _last_literals;                  /* Input too small, no compression (all literals) */
+    cctx->currentOffset += (U32)inputSize;
+    cctx->tableType = (U16)tableType;
+
+    if (inputSize<LZ4_minLength) goto _last_literals;        /* Input too small, no compression (all literals) */
 
     /* First Byte */
     LZ4_putPosition(ip, cctx->hashTable, tableType, base);
@@ -522,50 +874,112 @@ FORCE_INLINE int LZ4_compress_generic(
 
     /* Main Loop */
     for ( ; ; ) {
-        ptrdiff_t refDelta = 0;
         const BYTE* match;
         BYTE* token;
+        const BYTE* filledIp;
 
         /* Find a match */
-        {   const BYTE* forwardIp = ip;
-            unsigned step = 1;
-            unsigned searchMatchNb = acceleration << LZ4_skipTrigger;
+        if (tableType == byPtr) {
+            const BYTE* forwardIp = ip;
+            int step = 1;
+            int searchMatchNb = acceleration << LZ4_skipTrigger;
             do {
                 U32 const h = forwardH;
                 ip = forwardIp;
                 forwardIp += step;
                 step = (searchMatchNb++ >> LZ4_skipTrigger);
 
-                if (unlikely(forwardIp > mflimit)) goto _last_literals;
+                if (unlikely(forwardIp > mflimitPlusOne)) goto _last_literals;
+                assert(ip < mflimitPlusOne);
 
                 match = LZ4_getPositionOnHash(h, cctx->hashTable, tableType, base);
-                if (dict==usingExtDict) {
-                    if (match < (const BYTE*)source) {
-                        refDelta = dictDelta;
-                        lowLimit = dictionary;
-                    } else {
-                        refDelta = 0;
-                        lowLimit = (const BYTE*)source;
-                }   }
                 forwardH = LZ4_hashPosition(forwardIp, tableType);
                 LZ4_putPositionOnHash(ip, h, cctx->hashTable, tableType, base);
 
-            } while ( ((dictIssue==dictSmall) ? (match < lowRefLimit) : 0)
-                || ((tableType==byU16) ? 0 : (match + MAX_DISTANCE < ip))
-                || (LZ4_read32(match+refDelta) != LZ4_read32(ip)) );
+            } while ( (match+LZ4_DISTANCE_MAX < ip)
+                   || (LZ4_read32(match) != LZ4_read32(ip)) );
+
+        } else {   /* byU32, byU16 */
+
+            const BYTE* forwardIp = ip;
+            int step = 1;
+            int searchMatchNb = acceleration << LZ4_skipTrigger;
+            do {
+                U32 const h = forwardH;
+                U32 const current = (U32)(forwardIp - base);
+                U32 matchIndex = LZ4_getIndexOnHash(h, cctx->hashTable, tableType);
+                assert(matchIndex <= current);
+                assert(forwardIp - base < (ptrdiff_t)(2 GB - 1));
+                ip = forwardIp;
+                forwardIp += step;
+                step = (searchMatchNb++ >> LZ4_skipTrigger);
+
+                if (unlikely(forwardIp > mflimitPlusOne)) goto _last_literals;
+                assert(ip < mflimitPlusOne);
+
+                if (dictDirective == usingDictCtx) {
+                    if (matchIndex < startIndex) {
+                        /* there was no match, try the dictionary */
+                        assert(tableType == byU32);
+                        matchIndex = LZ4_getIndexOnHash(h, dictCtx->hashTable, byU32);
+                        match = dictBase + matchIndex;
+                        matchIndex += dictDelta;   /* make dictCtx index comparable with current context */
+                        lowLimit = dictionary;
+                    } else {
+                        match = base + matchIndex;
+                        lowLimit = (const BYTE*)source;
+                    }
+                } else if (dictDirective==usingExtDict) {
+                    if (matchIndex < startIndex) {
+                        DEBUGLOG(7, "extDict candidate: matchIndex=%5u  <  startIndex=%5u", matchIndex, startIndex);
+                        assert(startIndex - matchIndex >= MINMATCH);
+                        match = dictBase + matchIndex;
+                        lowLimit = dictionary;
+                    } else {
+                        match = base + matchIndex;
+                        lowLimit = (const BYTE*)source;
+                    }
+                } else {   /* single continuous memory segment */
+                    match = base + matchIndex;
+                }
+                forwardH = LZ4_hashPosition(forwardIp, tableType);
+                LZ4_putIndexOnHash(current, h, cctx->hashTable, tableType);
+
+                DEBUGLOG(7, "candidate at pos=%u  (offset=%u \n", matchIndex, current - matchIndex);
+                if ((dictIssue == dictSmall) && (matchIndex < prefixIdxLimit)) { continue; }    /* match outside of valid area */
+                assert(matchIndex < current);
+                if ( ((tableType != byU16) || (LZ4_DISTANCE_MAX < LZ4_DISTANCE_ABSOLUTE_MAX))
+                  && (matchIndex+LZ4_DISTANCE_MAX < current)) {
+                    continue;
+                } /* too far */
+                assert((current - matchIndex) <= LZ4_DISTANCE_MAX);  /* match now expected within distance */
+
+                if (LZ4_read32(match) == LZ4_read32(ip)) {
+                    if (maybe_extMem) offset = current - matchIndex;
+                    break;   /* match found */
+                }
+
+            } while(1);
         }
 
         /* Catch up */
-        while (((ip>anchor) & (match+refDelta > lowLimit)) && (unlikely(ip[-1]==match[refDelta-1]))) { ip--; match--; }
+        filledIp = ip;
+        while (((ip>anchor) & (match > lowLimit)) && (unlikely(ip[-1]==match[-1]))) { ip--; match--; }
 
         /* Encode Literals */
         {   unsigned const litLength = (unsigned)(ip - anchor);
             token = op++;
-            if ((outputLimited) &&  /* Check output buffer overflow */
-                (unlikely(op + litLength + (2 + 1 + LASTLITERALS) + (litLength/255) > olimit)))
-                return 0;
+            if ((outputDirective == limitedOutput) &&  /* Check output buffer overflow */
+                (unlikely(op + litLength + (2 + 1 + LASTLITERALS) + (litLength/255) > olimit)) ) {
+                return 0;   /* cannot compress within `dst` budget. Stored indexes in hash table are nonetheless fine */
+            }
+            if ((outputDirective == fillOutput) &&
+                (unlikely(op + (litLength+240)/255 /* litlen */ + litLength /* literals */ + 2 /* offset */ + 1 /* token */ + MFLIMIT - MINMATCH /* min last literals so last match is <= end - MFLIMIT */ > olimit))) {
+                op--;
+                goto _last_literals;
+            }
             if (litLength >= RUN_MASK) {
-                int len = (int)litLength-RUN_MASK;
+                int len = (int)(litLength - RUN_MASK);
                 *token = (RUN_MASK<<ML_BITS);
                 for(; len >= 255 ; len-=255) *op++ = 255;
                 *op++ = (BYTE)len;
@@ -573,82 +987,183 @@ FORCE_INLINE int LZ4_compress_generic(
             else *token = (BYTE)(litLength<<ML_BITS);
 
             /* Copy Literals */
-            LZ4_wildCopy(op, anchor, op+litLength);
+            LZ4_wildCopy8(op, anchor, op+litLength);
             op+=litLength;
+            DEBUGLOG(6, "seq.start:%i, literals=%u, match.start:%i",
+                        (int)(anchor-(const BYTE*)source), litLength, (int)(ip-(const BYTE*)source));
         }
 
 _next_match:
+        /* at this stage, the following variables must be correctly set :
+         * - ip : at start of LZ operation
+         * - match : at start of previous pattern occurence; can be within current prefix, or within extDict
+         * - offset : if maybe_ext_memSegment==1 (constant)
+         * - lowLimit : must be == dictionary to mean "match is within extDict"; must be == source otherwise
+         * - token and *token : position to write 4-bits for match length; higher 4-bits for literal length supposed already written
+         */
+
+        if ((outputDirective == fillOutput) &&
+            (op + 2 /* offset */ + 1 /* token */ + MFLIMIT - MINMATCH /* min last literals so last match is <= end - MFLIMIT */ > olimit)) {
+            /* the match was too close to the end, rewind and go to last literals */
+            op = token;
+            goto _last_literals;
+        }
+
         /* Encode Offset */
-        LZ4_writeLE16(op, (U16)(ip-match)); op+=2;
+        if (maybe_extMem) {   /* static test */
+            DEBUGLOG(6, "             with offset=%u  (ext if > %i)", offset, (int)(ip - (const BYTE*)source));
+            assert(offset <= LZ4_DISTANCE_MAX && offset > 0);
+            LZ4_writeLE16(op, (U16)offset); op+=2;
+        } else  {
+            DEBUGLOG(6, "             with offset=%u  (same segment)", (U32)(ip - match));
+            assert(ip-match <= LZ4_DISTANCE_MAX);
+            LZ4_writeLE16(op, (U16)(ip - match)); op+=2;
+        }
 
         /* Encode MatchLength */
         {   unsigned matchCode;
 
-            if ((dict==usingExtDict) && (lowLimit==dictionary)) {
-                const BYTE* limit;
-                match += refDelta;
-                limit = ip + (dictEnd-match);
+            if ( (dictDirective==usingExtDict || dictDirective==usingDictCtx)
+              && (lowLimit==dictionary) /* match within extDict */ ) {
+                const BYTE* limit = ip + (dictEnd-match);
+                assert(dictEnd > match);
                 if (limit > matchlimit) limit = matchlimit;
                 matchCode = LZ4_count(ip+MINMATCH, match+MINMATCH, limit);
-                ip += MINMATCH + matchCode;
+                ip += (size_t)matchCode + MINMATCH;
                 if (ip==limit) {
-                    unsigned const more = LZ4_count(ip, (const BYTE*)source, matchlimit);
+                    unsigned const more = LZ4_count(limit, (const BYTE*)source, matchlimit);
                     matchCode += more;
                     ip += more;
                 }
+                DEBUGLOG(6, "             with matchLength=%u starting in extDict", matchCode+MINMATCH);
             } else {
                 matchCode = LZ4_count(ip+MINMATCH, match+MINMATCH, matchlimit);
-                ip += MINMATCH + matchCode;
+                ip += (size_t)matchCode + MINMATCH;
+                DEBUGLOG(6, "             with matchLength=%u", matchCode+MINMATCH);
             }
 
-            if ( outputLimited &&    /* Check output buffer overflow */
-                (unlikely(op + (1 + LASTLITERALS) + (matchCode>>8) > olimit)) )
-                return 0;
+            if ((outputDirective) &&    /* Check output buffer overflow */
+                (unlikely(op + (1 + LASTLITERALS) + (matchCode+240)/255 > olimit)) ) {
+                if (outputDirective == fillOutput) {
+                    /* Match description too long : reduce it */
+                    U32 newMatchCode = 15 /* in token */ - 1 /* to avoid needing a zero byte */ + ((U32)(olimit - op) - 1 - LASTLITERALS) * 255;
+                    ip -= matchCode - newMatchCode;
+                    assert(newMatchCode < matchCode);
+                    matchCode = newMatchCode;
+                    if (unlikely(ip <= filledIp)) {
+                        /* We have already filled up to filledIp so if ip ends up less than filledIp
+                         * we have positions in the hash table beyond the current position. This is
+                         * a problem if we reuse the hash table. So we have to remove these positions
+                         * from the hash table.
+                         */
+                        const BYTE* ptr;
+                        DEBUGLOG(5, "Clearing %u positions", (U32)(filledIp - ip));
+                        for (ptr = ip; ptr <= filledIp; ++ptr) {
+                            U32 const h = LZ4_hashPosition(ptr, tableType);
+                            LZ4_clearHash(h, cctx->hashTable, tableType);
+                        }
+                    }
+                } else {
+                    assert(outputDirective == limitedOutput);
+                    return 0;   /* cannot compress within `dst` budget. Stored indexes in hash table are nonetheless fine */
+                }
+            }
             if (matchCode >= ML_MASK) {
                 *token += ML_MASK;
                 matchCode -= ML_MASK;
                 LZ4_write32(op, 0xFFFFFFFF);
-                while (matchCode >= 4*255) op+=4, LZ4_write32(op, 0xFFFFFFFF), matchCode -= 4*255;
+                while (matchCode >= 4*255) {
+                    op+=4;
+                    LZ4_write32(op, 0xFFFFFFFF);
+                    matchCode -= 4*255;
+                }
                 op += matchCode / 255;
                 *op++ = (BYTE)(matchCode % 255);
             } else
                 *token += (BYTE)(matchCode);
         }
+        /* Ensure we have enough space for the last literals. */
+        assert(!(outputDirective == fillOutput && op + 1 + LASTLITERALS > olimit));
 
         anchor = ip;
 
         /* Test end of chunk */
-        if (ip > mflimit) break;
+        if (ip >= mflimitPlusOne) break;
 
         /* Fill table */
         LZ4_putPosition(ip-2, cctx->hashTable, tableType, base);
 
         /* Test next position */
-        match = LZ4_getPosition(ip, cctx->hashTable, tableType, base);
-        if (dict==usingExtDict) {
-            if (match < (const BYTE*)source) {
-                refDelta = dictDelta;
-                lowLimit = dictionary;
-            } else {
-                refDelta = 0;
-                lowLimit = (const BYTE*)source;
-        }   }
-        LZ4_putPosition(ip, cctx->hashTable, tableType, base);
-        if ( ((dictIssue==dictSmall) ? (match>=lowRefLimit) : 1)
-            && (match+MAX_DISTANCE>=ip)
-            && (LZ4_read32(match+refDelta)==LZ4_read32(ip)) )
-        { token=op++; *token=0; goto _next_match; }
+        if (tableType == byPtr) {
+
+            match = LZ4_getPosition(ip, cctx->hashTable, tableType, base);
+            LZ4_putPosition(ip, cctx->hashTable, tableType, base);
+            if ( (match+LZ4_DISTANCE_MAX >= ip)
+              && (LZ4_read32(match) == LZ4_read32(ip)) )
+            { token=op++; *token=0; goto _next_match; }
+
+        } else {   /* byU32, byU16 */
+
+            U32 const h = LZ4_hashPosition(ip, tableType);
+            U32 const current = (U32)(ip-base);
+            U32 matchIndex = LZ4_getIndexOnHash(h, cctx->hashTable, tableType);
+            assert(matchIndex < current);
+            if (dictDirective == usingDictCtx) {
+                if (matchIndex < startIndex) {
+                    /* there was no match, try the dictionary */
+                    matchIndex = LZ4_getIndexOnHash(h, dictCtx->hashTable, byU32);
+                    match = dictBase + matchIndex;
+                    lowLimit = dictionary;   /* required for match length counter */
+                    matchIndex += dictDelta;
+                } else {
+                    match = base + matchIndex;
+                    lowLimit = (const BYTE*)source;  /* required for match length counter */
+                }
+            } else if (dictDirective==usingExtDict) {
+                if (matchIndex < startIndex) {
+                    match = dictBase + matchIndex;
+                    lowLimit = dictionary;   /* required for match length counter */
+                } else {
+                    match = base + matchIndex;
+                    lowLimit = (const BYTE*)source;   /* required for match length counter */
+                }
+            } else {   /* single memory segment */
+                match = base + matchIndex;
+            }
+            LZ4_putIndexOnHash(current, h, cctx->hashTable, tableType);
+            assert(matchIndex < current);
+            if ( ((dictIssue==dictSmall) ? (matchIndex >= prefixIdxLimit) : 1)
+              && (((tableType==byU16) && (LZ4_DISTANCE_MAX == LZ4_DISTANCE_ABSOLUTE_MAX)) ? 1 : (matchIndex+LZ4_DISTANCE_MAX >= current))
+              && (LZ4_read32(match) == LZ4_read32(ip)) ) {
+                token=op++;
+                *token=0;
+                if (maybe_extMem) offset = current - matchIndex;
+                DEBUGLOG(6, "seq.start:%i, literals=%u, match.start:%i",
+                            (int)(anchor-(const BYTE*)source), 0, (int)(ip-(const BYTE*)source));
+                goto _next_match;
+            }
+        }
 
         /* Prepare next loop */
         forwardH = LZ4_hashPosition(++ip, tableType);
+
     }
 
 _last_literals:
     /* Encode Last Literals */
-    {   size_t const lastRun = (size_t)(iend - anchor);
-        if ( (outputLimited) &&  /* Check output buffer overflow */
-            ((op - (BYTE*)dest) + lastRun + 1 + ((lastRun+255-RUN_MASK)/255) > (U32)maxOutputSize) )
-            return 0;
+    {   size_t lastRun = (size_t)(iend - anchor);
+        if ( (outputDirective) &&  /* Check output buffer overflow */
+            (op + lastRun + 1 + ((lastRun+255-RUN_MASK)/255) > olimit)) {
+            if (outputDirective == fillOutput) {
+                /* adapt lastRun to fill 'dst' */
+                assert(olimit >= op);
+                lastRun  = (size_t)(olimit-op) - 1;
+                lastRun -= (lastRun+240)/255;
+            } else {
+                assert(outputDirective == limitedOutput);
+                return 0;   /* cannot compress within `dst` budget. Stored indexes in hash table are nonetheless fine */
+            }
+        }
         if (lastRun >= RUN_MASK) {
             size_t accumulator = lastRun - RUN_MASK;
             *op++ = RUN_MASK << ML_BITS;
@@ -658,251 +1173,154 @@ _last_literals:
             *op++ = (BYTE)(lastRun<<ML_BITS);
         }
         memcpy(op, anchor, lastRun);
+        ip = anchor + lastRun;
         op += lastRun;
     }
 
-    /* End */
-    return (int) (((char*)op)-dest);
+    if (outputDirective == fillOutput) {
+        *inputConsumed = (int) (((const char*)ip)-source);
+    }
+    DEBUGLOG(5, "LZ4_compress_generic: compressed %i bytes into %i bytes", inputSize, (int)(((char*)op) - dest));
+    result = (int)(((char*)op) - dest);
+    assert(result > 0);
+    return result;
 }
 
 
 int LZ4_compress_fast_extState(void* state, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
 {
-    LZ4_stream_t_internal* ctx = &((LZ4_stream_t*)state)->internal_donotuse;
-    LZ4_resetStream((LZ4_stream_t*)state);
+    LZ4_stream_t_internal* const ctx = & LZ4_initStream(state, sizeof(LZ4_stream_t)) -> internal_donotuse;
+    assert(ctx != NULL);
     if (acceleration < 1) acceleration = ACCELERATION_DEFAULT;
-
     if (maxOutputSize >= LZ4_compressBound(inputSize)) {
-        if (inputSize < LZ4_64Klimit)
-            return LZ4_compress_generic(ctx, source, dest, inputSize,             0,    notLimited,                        byU16, noDict, noDictIssue, acceleration);
-        else
-            return LZ4_compress_generic(ctx, source, dest, inputSize,             0,    notLimited, (sizeof(void*)==8) ? byU32 : byPtr, noDict, noDictIssue, acceleration);
+        if (inputSize < LZ4_64Klimit) {
+            return LZ4_compress_generic(ctx, source, dest, inputSize, NULL, 0, notLimited, byU16, noDict, noDictIssue, acceleration);
+        } else {
+            const tableType_t tableType = ((sizeof(void*)==4) && ((uptrval)source > LZ4_DISTANCE_MAX)) ? byPtr : byU32;
+            return LZ4_compress_generic(ctx, source, dest, inputSize, NULL, 0, notLimited, tableType, noDict, noDictIssue, acceleration);
+        }
     } else {
-        if (inputSize < LZ4_64Klimit)
-            return LZ4_compress_generic(ctx, source, dest, inputSize, maxOutputSize, limitedOutput,                        byU16, noDict, noDictIssue, acceleration);
-        else
-            return LZ4_compress_generic(ctx, source, dest, inputSize, maxOutputSize, limitedOutput, (sizeof(void*)==8) ? byU32 : byPtr, noDict, noDictIssue, acceleration);
+        if (inputSize < LZ4_64Klimit) {
+            return LZ4_compress_generic(ctx, source, dest, inputSize, NULL, maxOutputSize, limitedOutput, byU16, noDict, noDictIssue, acceleration);
+        } else {
+            const tableType_t tableType = ((sizeof(void*)==4) && ((uptrval)source > LZ4_DISTANCE_MAX)) ? byPtr : byU32;
+            return LZ4_compress_generic(ctx, source, dest, inputSize, NULL, maxOutputSize, limitedOutput, tableType, noDict, noDictIssue, acceleration);
+        }
+    }
+}
+
+/**
+ * LZ4_compress_fast_extState_fastReset() :
+ * A variant of LZ4_compress_fast_extState().
+ *
+ * Using this variant avoids an expensive initialization step. It is only safe
+ * to call if the state buffer is known to be correctly initialized already
+ * (see comment in lz4.h on LZ4_resetStream_fast() for a definition of
+ * "correctly initialized").
+ */
+int LZ4_compress_fast_extState_fastReset(void* state, const char* src, char* dst, int srcSize, int dstCapacity, int acceleration)
+{
+    LZ4_stream_t_internal* ctx = &((LZ4_stream_t*)state)->internal_donotuse;
+    if (acceleration < 1) acceleration = ACCELERATION_DEFAULT;
+
+    if (dstCapacity >= LZ4_compressBound(srcSize)) {
+        if (srcSize < LZ4_64Klimit) {
+            const tableType_t tableType = byU16;
+            LZ4_prepareTable(ctx, srcSize, tableType);
+            if (ctx->currentOffset) {
+                return LZ4_compress_generic(ctx, src, dst, srcSize, NULL, 0, notLimited, tableType, noDict, dictSmall, acceleration);
+            } else {
+                return LZ4_compress_generic(ctx, src, dst, srcSize, NULL, 0, notLimited, tableType, noDict, noDictIssue, acceleration);
+            }
+        } else {
+            const tableType_t tableType = ((sizeof(void*)==4) && ((uptrval)src > LZ4_DISTANCE_MAX)) ? byPtr : byU32;
+            LZ4_prepareTable(ctx, srcSize, tableType);
+            return LZ4_compress_generic(ctx, src, dst, srcSize, NULL, 0, notLimited, tableType, noDict, noDictIssue, acceleration);
+        }
+    } else {
+        if (srcSize < LZ4_64Klimit) {
+            const tableType_t tableType = byU16;
+            LZ4_prepareTable(ctx, srcSize, tableType);
+            if (ctx->currentOffset) {
+                return LZ4_compress_generic(ctx, src, dst, srcSize, NULL, dstCapacity, limitedOutput, tableType, noDict, dictSmall, acceleration);
+            } else {
+                return LZ4_compress_generic(ctx, src, dst, srcSize, NULL, dstCapacity, limitedOutput, tableType, noDict, noDictIssue, acceleration);
+            }
+        } else {
+            const tableType_t tableType = ((sizeof(void*)==4) && ((uptrval)src > LZ4_DISTANCE_MAX)) ? byPtr : byU32;
+            LZ4_prepareTable(ctx, srcSize, tableType);
+            return LZ4_compress_generic(ctx, src, dst, srcSize, NULL, dstCapacity, limitedOutput, tableType, noDict, noDictIssue, acceleration);
+        }
     }
 }
 
 
 int LZ4_compress_fast(const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
 {
-#if (HEAPMODE)
-    void* ctxPtr = ALLOCATOR(1, sizeof(LZ4_stream_t));   /* malloc-calloc always properly aligned */
+    int result;
+#if (LZ4_HEAPMODE)
+    LZ4_stream_t* ctxPtr = ALLOC(sizeof(LZ4_stream_t));   /* malloc-calloc always properly aligned */
+    if (ctxPtr == NULL) return 0;
 #else
     LZ4_stream_t ctx;
-    void* const ctxPtr = &ctx;
+    LZ4_stream_t* const ctxPtr = &ctx;
 #endif
+    result = LZ4_compress_fast_extState(ctxPtr, source, dest, inputSize, maxOutputSize, acceleration);
 
-    int const result = LZ4_compress_fast_extState(ctxPtr, source, dest, inputSize, maxOutputSize, acceleration);
-
-#if (HEAPMODE)
+#if (LZ4_HEAPMODE)
     FREEMEM(ctxPtr);
 #endif
     return result;
 }
 
 
-int LZ4_compress_default(const char* source, char* dest, int inputSize, int maxOutputSize)
+int LZ4_compress_default(const char* src, char* dst, int srcSize, int maxOutputSize)
 {
-    return LZ4_compress_fast(source, dest, inputSize, maxOutputSize, 1);
+    return LZ4_compress_fast(src, dst, srcSize, maxOutputSize, 1);
 }
 
 
 /* hidden debug function */
 /* strangely enough, gcc generates faster code when this function is uncommented, even if unused */
-int LZ4_compress_fast_force(const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
+int LZ4_compress_fast_force(const char* src, char* dst, int srcSize, int dstCapacity, int acceleration)
 {
     LZ4_stream_t ctx;
-    LZ4_resetStream(&ctx);
+    LZ4_initStream(&ctx, sizeof(ctx));
 
-    if (inputSize < LZ4_64Klimit)
-        return LZ4_compress_generic(&ctx.internal_donotuse, source, dest, inputSize, maxOutputSize, limitedOutput, byU16,                        noDict, noDictIssue, acceleration);
-    else
-        return LZ4_compress_generic(&ctx.internal_donotuse, source, dest, inputSize, maxOutputSize, limitedOutput, sizeof(void*)==8 ? byU32 : byPtr, noDict, noDictIssue, acceleration);
-}
-
-
-/*-******************************
-*  *_destSize() variant
-********************************/
-
-static int LZ4_compress_destSize_generic(
-                       LZ4_stream_t_internal* const ctx,
-                 const char* const src,
-                       char* const dst,
-                       int*  const srcSizePtr,
-                 const int targetDstSize,
-                 const tableType_t tableType)
-{
-    const BYTE* ip = (const BYTE*) src;
-    const BYTE* base = (const BYTE*) src;
-    const BYTE* lowLimit = (const BYTE*) src;
-    const BYTE* anchor = ip;
-    const BYTE* const iend = ip + *srcSizePtr;
-    const BYTE* const mflimit = iend - MFLIMIT;
-    const BYTE* const matchlimit = iend - LASTLITERALS;
-
-    BYTE* op = (BYTE*) dst;
-    BYTE* const oend = op + targetDstSize;
-    BYTE* const oMaxLit = op + targetDstSize - 2 /* offset */ - 8 /* because 8+MINMATCH==MFLIMIT */ - 1 /* token */;
-    BYTE* const oMaxMatch = op + targetDstSize - (LASTLITERALS + 1 /* token */);
-    BYTE* const oMaxSeq = oMaxLit - 1 /* token */;
-
-    U32 forwardH;
-
-
-    /* Init conditions */
-    if (targetDstSize < 1) return 0;                                     /* Impossible to store anything */
-    if ((U32)*srcSizePtr > (U32)LZ4_MAX_INPUT_SIZE) return 0;            /* Unsupported input size, too large (or negative) */
-    if ((tableType == byU16) && (*srcSizePtr>=LZ4_64Klimit)) return 0;   /* Size too large (not within 64K limit) */
-    if (*srcSizePtr<LZ4_minLength) goto _last_literals;                  /* Input too small, no compression (all literals) */
-
-    /* First Byte */
-    *srcSizePtr = 0;
-    LZ4_putPosition(ip, ctx->hashTable, tableType, base);
-    ip++; forwardH = LZ4_hashPosition(ip, tableType);
-
-    /* Main Loop */
-    for ( ; ; ) {
-        const BYTE* match;
-        BYTE* token;
-
-        /* Find a match */
-        {   const BYTE* forwardIp = ip;
-            unsigned step = 1;
-            unsigned searchMatchNb = 1 << LZ4_skipTrigger;
-
-            do {
-                U32 h = forwardH;
-                ip = forwardIp;
-                forwardIp += step;
-                step = (searchMatchNb++ >> LZ4_skipTrigger);
-
-                if (unlikely(forwardIp > mflimit)) goto _last_literals;
-
-                match = LZ4_getPositionOnHash(h, ctx->hashTable, tableType, base);
-                forwardH = LZ4_hashPosition(forwardIp, tableType);
-                LZ4_putPositionOnHash(ip, h, ctx->hashTable, tableType, base);
-
-            } while ( ((tableType==byU16) ? 0 : (match + MAX_DISTANCE < ip))
-                || (LZ4_read32(match) != LZ4_read32(ip)) );
-        }
-
-        /* Catch up */
-        while ((ip>anchor) && (match > lowLimit) && (unlikely(ip[-1]==match[-1]))) { ip--; match--; }
-
-        /* Encode Literal length */
-        {   unsigned litLength = (unsigned)(ip - anchor);
-            token = op++;
-            if (op + ((litLength+240)/255) + litLength > oMaxLit) {
-                /* Not enough space for a last match */
-                op--;
-                goto _last_literals;
-            }
-            if (litLength>=RUN_MASK) {
-                unsigned len = litLength - RUN_MASK;
-                *token=(RUN_MASK<<ML_BITS);
-                for(; len >= 255 ; len-=255) *op++ = 255;
-                *op++ = (BYTE)len;
-            }
-            else *token = (BYTE)(litLength<<ML_BITS);
-
-            /* Copy Literals */
-            LZ4_wildCopy(op, anchor, op+litLength);
-            op += litLength;
-        }
-
-_next_match:
-        /* Encode Offset */
-        LZ4_writeLE16(op, (U16)(ip-match)); op+=2;
-
-        /* Encode MatchLength */
-        {   size_t matchLength = LZ4_count(ip+MINMATCH, match+MINMATCH, matchlimit);
-
-            if (op + ((matchLength+240)/255) > oMaxMatch) {
-                /* Match description too long : reduce it */
-                matchLength = (15-1) + (oMaxMatch-op) * 255;
-            }
-            ip += MINMATCH + matchLength;
-
-            if (matchLength>=ML_MASK) {
-                *token += ML_MASK;
-                matchLength -= ML_MASK;
-                while (matchLength >= 255) { matchLength-=255; *op++ = 255; }
-                *op++ = (BYTE)matchLength;
-            }
-            else *token += (BYTE)(matchLength);
-        }
-
-        anchor = ip;
-
-        /* Test end of block */
-        if (ip > mflimit) break;
-        if (op > oMaxSeq) break;
-
-        /* Fill table */
-        LZ4_putPosition(ip-2, ctx->hashTable, tableType, base);
-
-        /* Test next position */
-        match = LZ4_getPosition(ip, ctx->hashTable, tableType, base);
-        LZ4_putPosition(ip, ctx->hashTable, tableType, base);
-        if ( (match+MAX_DISTANCE>=ip)
-            && (LZ4_read32(match)==LZ4_read32(ip)) )
-        { token=op++; *token=0; goto _next_match; }
-
-        /* Prepare next loop */
-        forwardH = LZ4_hashPosition(++ip, tableType);
+    if (srcSize < LZ4_64Klimit) {
+        return LZ4_compress_generic(&ctx.internal_donotuse, src, dst, srcSize, NULL, dstCapacity, limitedOutput, byU16,    noDict, noDictIssue, acceleration);
+    } else {
+        tableType_t const addrMode = (sizeof(void*) > 4) ? byU32 : byPtr;
+        return LZ4_compress_generic(&ctx.internal_donotuse, src, dst, srcSize, NULL, dstCapacity, limitedOutput, addrMode, noDict, noDictIssue, acceleration);
     }
-
-_last_literals:
-    /* Encode Last Literals */
-    {   size_t lastRunSize = (size_t)(iend - anchor);
-        if (op + 1 /* token */ + ((lastRunSize+240)/255) /* litLength */ + lastRunSize /* literals */ > oend) {
-            /* adapt lastRunSize to fill 'dst' */
-            lastRunSize  = (oend-op) - 1;
-            lastRunSize -= (lastRunSize+240)/255;
-        }
-        ip = anchor + lastRunSize;
-
-        if (lastRunSize >= RUN_MASK) {
-            size_t accumulator = lastRunSize - RUN_MASK;
-            *op++ = RUN_MASK << ML_BITS;
-            for(; accumulator >= 255 ; accumulator-=255) *op++ = 255;
-            *op++ = (BYTE) accumulator;
-        } else {
-            *op++ = (BYTE)(lastRunSize<<ML_BITS);
-        }
-        memcpy(op, anchor, lastRunSize);
-        op += lastRunSize;
-    }
-
-    /* End */
-    *srcSizePtr = (int) (((const char*)ip)-src);
-    return (int) (((char*)op)-dst);
 }
 
 
+/* Note!: This function leaves the stream in an unclean/broken state!
+ * It is not safe to subsequently use the same state with a _fastReset() or
+ * _continue() call without resetting it. */
 static int LZ4_compress_destSize_extState (LZ4_stream_t* state, const char* src, char* dst, int* srcSizePtr, int targetDstSize)
 {
-    LZ4_resetStream(state);
+    void* const s = LZ4_initStream(state, sizeof (*state));
+    assert(s != NULL); (void)s;
 
     if (targetDstSize >= LZ4_compressBound(*srcSizePtr)) {  /* compression success is guaranteed */
         return LZ4_compress_fast_extState(state, src, dst, *srcSizePtr, targetDstSize, 1);
     } else {
-        if (*srcSizePtr < LZ4_64Klimit)
-            return LZ4_compress_destSize_generic(&state->internal_donotuse, src, dst, srcSizePtr, targetDstSize, byU16);
-        else
-            return LZ4_compress_destSize_generic(&state->internal_donotuse, src, dst, srcSizePtr, targetDstSize, sizeof(void*)==8 ? byU32 : byPtr);
-    }
+        if (*srcSizePtr < LZ4_64Klimit) {
+            return LZ4_compress_generic(&state->internal_donotuse, src, dst, *srcSizePtr, srcSizePtr, targetDstSize, fillOutput, byU16, noDict, noDictIssue, 1);
+        } else {
+            tableType_t const addrMode = ((sizeof(void*)==4) && ((uptrval)src > LZ4_DISTANCE_MAX)) ? byPtr : byU32;
+            return LZ4_compress_generic(&state->internal_donotuse, src, dst, *srcSizePtr, srcSizePtr, targetDstSize, fillOutput, addrMode, noDict, noDictIssue, 1);
+    }   }
 }
 
 
 int LZ4_compress_destSize(const char* src, char* dst, int* srcSizePtr, int targetDstSize)
 {
-#if (HEAPMODE)
-    LZ4_stream_t* ctx = (LZ4_stream_t*)ALLOCATOR(1, sizeof(LZ4_stream_t));   /* malloc-calloc always properly aligned */
+#if (LZ4_HEAPMODE)
+    LZ4_stream_t* ctx = (LZ4_stream_t*)ALLOC(sizeof(LZ4_stream_t));   /* malloc-calloc always properly aligned */
+    if (ctx == NULL) return 0;
 #else
     LZ4_stream_t ctxBody;
     LZ4_stream_t* ctx = &ctxBody;
@@ -910,7 +1328,7 @@ int LZ4_compress_destSize(const char* src, char* dst, int* srcSizePtr, int targe
 
     int result = LZ4_compress_destSize_extState(ctx, src, dst, srcSizePtr, targetDstSize);
 
-#if (HEAPMODE)
+#if (LZ4_HEAPMODE)
     FREEMEM(ctx);
 #endif
     return result;
@@ -924,19 +1342,54 @@ int LZ4_compress_destSize(const char* src, char* dst, int* srcSizePtr, int targe
 
 LZ4_stream_t* LZ4_createStream(void)
 {
-    LZ4_stream_t* lz4s = (LZ4_stream_t*)ALLOCATOR(8, LZ4_STREAMSIZE_U64);
+    LZ4_stream_t* const lz4s = (LZ4_stream_t*)ALLOC(sizeof(LZ4_stream_t));
     LZ4_STATIC_ASSERT(LZ4_STREAMSIZE >= sizeof(LZ4_stream_t_internal));    /* A compilation error here means LZ4_STREAMSIZE is not large enough */
-    LZ4_resetStream(lz4s);
+    DEBUGLOG(4, "LZ4_createStream %p", lz4s);
+    if (lz4s == NULL) return NULL;
+    LZ4_initStream(lz4s, sizeof(*lz4s));
     return lz4s;
 }
 
+#ifndef _MSC_VER  /* for some reason, Visual fails the aligment test on 32-bit x86 :
+                     it reports an aligment of 8-bytes,
+                     while actually aligning LZ4_stream_t on 4 bytes. */
+static size_t LZ4_stream_t_alignment(void)
+{
+    struct { char c; LZ4_stream_t t; } t_a;
+    return sizeof(t_a) - sizeof(t_a.t);
+}
+#endif
+
+LZ4_stream_t* LZ4_initStream (void* buffer, size_t size)
+{
+    DEBUGLOG(5, "LZ4_initStream");
+    if (buffer == NULL) { return NULL; }
+    if (size < sizeof(LZ4_stream_t)) { return NULL; }
+#ifndef _MSC_VER  /* for some reason, Visual fails the aligment test on 32-bit x86 :
+                     it reports an aligment of 8-bytes,
+                     while actually aligning LZ4_stream_t on 4 bytes. */
+    if (((size_t)buffer) & (LZ4_stream_t_alignment() - 1)) { return NULL; } /* alignment check */
+#endif
+    MEM_INIT(buffer, 0, sizeof(LZ4_stream_t));
+    return (LZ4_stream_t*)buffer;
+}
+
+/* resetStream is now deprecated,
+ * prefer initStream() which is more general */
 void LZ4_resetStream (LZ4_stream_t* LZ4_stream)
 {
+    DEBUGLOG(5, "LZ4_resetStream (ctx:%p)", LZ4_stream);
     MEM_INIT(LZ4_stream, 0, sizeof(LZ4_stream_t));
 }
 
+void LZ4_resetStream_fast(LZ4_stream_t* ctx) {
+    LZ4_prepareTable(&(ctx->internal_donotuse), 0, byU32);
+}
+
 int LZ4_freeStream (LZ4_stream_t* LZ4_stream)
 {
+    if (!LZ4_stream) return 0;   /* support free on NULL */
+    DEBUGLOG(5, "LZ4_freeStream %p", LZ4_stream);
     FREEMEM(LZ4_stream);
     return (0);
 }
@@ -946,43 +1399,88 @@ int LZ4_freeStream (LZ4_stream_t* LZ4_stream)
 int LZ4_loadDict (LZ4_stream_t* LZ4_dict, const char* dictionary, int dictSize)
 {
     LZ4_stream_t_internal* dict = &LZ4_dict->internal_donotuse;
+    const tableType_t tableType = byU32;
     const BYTE* p = (const BYTE*)dictionary;
     const BYTE* const dictEnd = p + dictSize;
     const BYTE* base;
 
-    if ((dict->initCheck) || (dict->currentOffset > 1 GB))  /* Uninitialized structure, or reuse overflow */
-        LZ4_resetStream(LZ4_dict);
+    DEBUGLOG(4, "LZ4_loadDict (%i bytes from %p into %p)", dictSize, dictionary, LZ4_dict);
+
+    /* It's necessary to reset the context,
+     * and not just continue it with prepareTable()
+     * to avoid any risk of generating overflowing matchIndex
+     * when compressing using this dictionary */
+    LZ4_resetStream(LZ4_dict);
+
+    /* We always increment the offset by 64 KB, since, if the dict is longer,
+     * we truncate it to the last 64k, and if it's shorter, we still want to
+     * advance by a whole window length so we can provide the guarantee that
+     * there are only valid offsets in the window, which allows an optimization
+     * in LZ4_compress_fast_continue() where it uses noDictIssue even when the
+     * dictionary isn't a full 64k. */
+    dict->currentOffset += 64 KB;
 
     if (dictSize < (int)HASH_UNIT) {
-        dict->dictionary = NULL;
-        dict->dictSize = 0;
         return 0;
     }
 
     if ((dictEnd - p) > 64 KB) p = dictEnd - 64 KB;
-    dict->currentOffset += 64 KB;
-    base = p - dict->currentOffset;
+    base = dictEnd - dict->currentOffset;
     dict->dictionary = p;
     dict->dictSize = (U32)(dictEnd - p);
-    dict->currentOffset += dict->dictSize;
+    dict->tableType = tableType;
 
     while (p <= dictEnd-HASH_UNIT) {
-        LZ4_putPosition(p, dict->hashTable, byU32, base);
+        LZ4_putPosition(p, dict->hashTable, tableType, base);
         p+=3;
     }
 
-    return dict->dictSize;
+    return (int)dict->dictSize;
 }
 
+void LZ4_attach_dictionary(LZ4_stream_t* workingStream, const LZ4_stream_t* dictionaryStream) {
+    const LZ4_stream_t_internal* dictCtx = dictionaryStream == NULL ? NULL :
+        &(dictionaryStream->internal_donotuse);
 
-static void LZ4_renormDictT(LZ4_stream_t_internal* LZ4_dict, const BYTE* src)
+    DEBUGLOG(4, "LZ4_attach_dictionary (%p, %p, size %u)",
+             workingStream, dictionaryStream,
+             dictCtx != NULL ? dictCtx->dictSize : 0);
+
+    /* Calling LZ4_resetStream_fast() here makes sure that changes will not be
+     * erased by subsequent calls to LZ4_resetStream_fast() in case stream was
+     * marked as having dirty context, e.g. requiring full reset.
+     */
+    LZ4_resetStream_fast(workingStream);
+
+    if (dictCtx != NULL) {
+        /* If the current offset is zero, we will never look in the
+         * external dictionary context, since there is no value a table
+         * entry can take that indicate a miss. In that case, we need
+         * to bump the offset to something non-zero.
+         */
+        if (workingStream->internal_donotuse.currentOffset == 0) {
+            workingStream->internal_donotuse.currentOffset = 64 KB;
+        }
+
+        /* Don't actually attach an empty dictionary.
+         */
+        if (dictCtx->dictSize == 0) {
+            dictCtx = NULL;
+        }
+    }
+    workingStream->internal_donotuse.dictCtx = dictCtx;
+}
+
+
+static void LZ4_renormDictT(LZ4_stream_t_internal* LZ4_dict, int nextSize)
 {
-    if ((LZ4_dict->currentOffset > 0x80000000) ||
-        ((uptrval)LZ4_dict->currentOffset > (uptrval)src)) {   /* address space overflow */
+    assert(nextSize >= 0);
+    if (LZ4_dict->currentOffset + (unsigned)nextSize > 0x80000000) {   /* potential ptrdiff_t overflow (32-bits mode) */
         /* rescale hash table */
         U32 const delta = LZ4_dict->currentOffset - 64 KB;
         const BYTE* dictEnd = LZ4_dict->dictionary + LZ4_dict->dictSize;
         int i;
+        DEBUGLOG(4, "LZ4_renormDictT");
         for (i=0; i<LZ4_HASH_SIZE_U32; i++) {
             if (LZ4_dict->hashTable[i] < delta) LZ4_dict->hashTable[i]=0;
             else LZ4_dict->hashTable[i] -= delta;
@@ -994,17 +1492,30 @@ static void LZ4_renormDictT(LZ4_stream_t_internal* LZ4_dict, const BYTE* src)
 }
 
 
-int LZ4_compress_fast_continue (LZ4_stream_t* LZ4_stream, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
+int LZ4_compress_fast_continue (LZ4_stream_t* LZ4_stream,
+                                const char* source, char* dest,
+                                int inputSize, int maxOutputSize,
+                                int acceleration)
 {
+    const tableType_t tableType = byU32;
     LZ4_stream_t_internal* streamPtr = &LZ4_stream->internal_donotuse;
-    const BYTE* const dictEnd = streamPtr->dictionary + streamPtr->dictSize;
+    const BYTE* dictEnd = streamPtr->dictionary + streamPtr->dictSize;
 
-    const BYTE* smallest = (const BYTE*) source;
-    if (streamPtr->initCheck) return 0;   /* Uninitialized structure detected */
-    if ((streamPtr->dictSize>0) && (smallest>dictEnd)) smallest = dictEnd;
-    LZ4_renormDictT(streamPtr, smallest);
+    DEBUGLOG(5, "LZ4_compress_fast_continue (inputSize=%i)", inputSize);
+
+    if (streamPtr->dirty) { return 0; } /* Uninitialized structure detected */
+    LZ4_renormDictT(streamPtr, inputSize);   /* avoid index overflow */
     if (acceleration < 1) acceleration = ACCELERATION_DEFAULT;
 
+    /* invalidate tiny dictionaries */
+    if ( (streamPtr->dictSize-1 < 4-1)   /* intentional underflow */
+      && (dictEnd != (const BYTE*)source) ) {
+        DEBUGLOG(5, "LZ4_compress_fast_continue: dictSize(%u) at addr:%p is too small", streamPtr->dictSize, streamPtr->dictionary);
+        streamPtr->dictSize = 0;
+        streamPtr->dictionary = (const BYTE*)source;
+        dictEnd = (const BYTE*)source;
+    }
+
     /* Check overlapping input/dictionary space */
     {   const BYTE* sourceEnd = (const BYTE*) source + inputSize;
         if ((sourceEnd > streamPtr->dictionary) && (sourceEnd < dictEnd)) {
@@ -1017,46 +1528,61 @@ int LZ4_compress_fast_continue (LZ4_stream_t* LZ4_stream, const char* source, ch
 
     /* prefix mode : source data follows dictionary */
     if (dictEnd == (const BYTE*)source) {
-        int result;
         if ((streamPtr->dictSize < 64 KB) && (streamPtr->dictSize < streamPtr->currentOffset))
-            result = LZ4_compress_generic(streamPtr, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, withPrefix64k, dictSmall, acceleration);
+            return LZ4_compress_generic(streamPtr, source, dest, inputSize, NULL, maxOutputSize, limitedOutput, tableType, withPrefix64k, dictSmall, acceleration);
         else
-            result = LZ4_compress_generic(streamPtr, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, withPrefix64k, noDictIssue, acceleration);
-        streamPtr->dictSize += (U32)inputSize;
-        streamPtr->currentOffset += (U32)inputSize;
-        return result;
+            return LZ4_compress_generic(streamPtr, source, dest, inputSize, NULL, maxOutputSize, limitedOutput, tableType, withPrefix64k, noDictIssue, acceleration);
     }
 
     /* external dictionary mode */
     {   int result;
-        if ((streamPtr->dictSize < 64 KB) && (streamPtr->dictSize < streamPtr->currentOffset))
-            result = LZ4_compress_generic(streamPtr, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, usingExtDict, dictSmall, acceleration);
-        else
-            result = LZ4_compress_generic(streamPtr, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, usingExtDict, noDictIssue, acceleration);
+        if (streamPtr->dictCtx) {
+            /* We depend here on the fact that dictCtx'es (produced by
+             * LZ4_loadDict) guarantee that their tables contain no references
+             * to offsets between dictCtx->currentOffset - 64 KB and
+             * dictCtx->currentOffset - dictCtx->dictSize. This makes it safe
+             * to use noDictIssue even when the dict isn't a full 64 KB.
+             */
+            if (inputSize > 4 KB) {
+                /* For compressing large blobs, it is faster to pay the setup
+                 * cost to copy the dictionary's tables into the active context,
+                 * so that the compression loop is only looking into one table.
+                 */
+                memcpy(streamPtr, streamPtr->dictCtx, sizeof(LZ4_stream_t));
+                result = LZ4_compress_generic(streamPtr, source, dest, inputSize, NULL, maxOutputSize, limitedOutput, tableType, usingExtDict, noDictIssue, acceleration);
+            } else {
+                result = LZ4_compress_generic(streamPtr, source, dest, inputSize, NULL, maxOutputSize, limitedOutput, tableType, usingDictCtx, noDictIssue, acceleration);
+            }
+        } else {
+            if ((streamPtr->dictSize < 64 KB) && (streamPtr->dictSize < streamPtr->currentOffset)) {
+                result = LZ4_compress_generic(streamPtr, source, dest, inputSize, NULL, maxOutputSize, limitedOutput, tableType, usingExtDict, dictSmall, acceleration);
+            } else {
+                result = LZ4_compress_generic(streamPtr, source, dest, inputSize, NULL, maxOutputSize, limitedOutput, tableType, usingExtDict, noDictIssue, acceleration);
+            }
+        }
         streamPtr->dictionary = (const BYTE*)source;
         streamPtr->dictSize = (U32)inputSize;
-        streamPtr->currentOffset += (U32)inputSize;
         return result;
     }
 }
 
 
-/* Hidden debug function, to force external dictionary mode */
-int LZ4_compress_forceExtDict (LZ4_stream_t* LZ4_dict, const char* source, char* dest, int inputSize)
+/* Hidden debug function, to force-test external dictionary mode */
+int LZ4_compress_forceExtDict (LZ4_stream_t* LZ4_dict, const char* source, char* dest, int srcSize)
 {
     LZ4_stream_t_internal* streamPtr = &LZ4_dict->internal_donotuse;
     int result;
-    const BYTE* const dictEnd = streamPtr->dictionary + streamPtr->dictSize;
 
-    const BYTE* smallest = dictEnd;
-    if (smallest > (const BYTE*) source) smallest = (const BYTE*) source;
-    LZ4_renormDictT(streamPtr, smallest);
+    LZ4_renormDictT(streamPtr, srcSize);
 
-    result = LZ4_compress_generic(streamPtr, source, dest, inputSize, 0, notLimited, byU32, usingExtDict, noDictIssue, 1);
+    if ((streamPtr->dictSize < 64 KB) && (streamPtr->dictSize < streamPtr->currentOffset)) {
+        result = LZ4_compress_generic(streamPtr, source, dest, srcSize, NULL, 0, notLimited, byU32, usingExtDict, dictSmall, 1);
+    } else {
+        result = LZ4_compress_generic(streamPtr, source, dest, srcSize, NULL, 0, notLimited, byU32, usingExtDict, noDictIssue, 1);
+    }
 
     streamPtr->dictionary = (const BYTE*)source;
-    streamPtr->dictSize = (U32)inputSize;
-    streamPtr->currentOffset += (U32)inputSize;
+    streamPtr->dictSize = (U32)srcSize;
 
     return result;
 }
@@ -1074,8 +1600,8 @@ int LZ4_saveDict (LZ4_stream_t* LZ4_dict, char* safeBuffer, int dictSize)
     LZ4_stream_t_internal* const dict = &LZ4_dict->internal_donotuse;
     const BYTE* const previousDictEnd = dict->dictionary + dict->dictSize;
 
-    if ((U32)dictSize > 64 KB) dictSize = 64 KB;   /* useless to define a dictionary > 64 KB */
-    if ((U32)dictSize > dict->dictSize) dictSize = dict->dictSize;
+    if ((U32)dictSize > 64 KB) { dictSize = 64 KB; } /* useless to define a dictionary > 64 KB */
+    if ((U32)dictSize > dict->dictSize) { dictSize = (int)dict->dictSize; }
 
     memmove(safeBuffer, previousDictEnd - dictSize, dictSize);
 
@@ -1087,218 +1613,587 @@ int LZ4_saveDict (LZ4_stream_t* LZ4_dict, char* safeBuffer, int dictSize)
 
 
 
-/*-*****************************
-*  Decompression functions
-*******************************/
+/*-*******************************
+ *  Decompression functions
+ ********************************/
+
+typedef enum { endOnOutputSize = 0, endOnInputSize = 1 } endCondition_directive;
+typedef enum { decode_full_block = 0, partial_decode = 1 } earlyEnd_directive;
+
+#undef MIN
+#define MIN(a,b)    ( (a) < (b) ? (a) : (b) )
+
+/* Read the variable-length literal or match length.
+ *
+ * ip - pointer to use as input.
+ * lencheck - end ip.  Return an error if ip advances >= lencheck.
+ * loop_check - check ip >= lencheck in body of loop.  Returns loop_error if so.
+ * initial_check - check ip >= lencheck before start of loop.  Returns initial_error if so.
+ * error (output) - error code.  Should be set to 0 before call.
+ */
+typedef enum { loop_error = -2, initial_error = -1, ok = 0 } variable_length_error;
+LZ4_FORCE_INLINE unsigned
+read_variable_length(const BYTE**ip, const BYTE* lencheck, int loop_check, int initial_check, variable_length_error* error)
+{
+  unsigned length = 0;
+  unsigned s;
+  if (initial_check && unlikely((*ip) >= lencheck)) {    /* overflow detection */
+    *error = initial_error;
+    return length;
+  }
+  do {
+    s = **ip;
+    (*ip)++;
+    length += s;
+    if (loop_check && unlikely((*ip) >= lencheck)) {    /* overflow detection */
+      *error = loop_error;
+      return length;
+    }
+  } while (s==255);
+
+  return length;
+}
+
 /*! LZ4_decompress_generic() :
- *  This generic decompression function cover all use cases.
- *  It shall be instantiated several times, using different sets of directives
- *  Note that it is important this generic function is really inlined,
+ *  This generic decompression function covers all use cases.
+ *  It shall be instantiated several times, using different sets of directives.
+ *  Note that it is important for performance that this function really get inlined,
  *  in order to remove useless branches during compilation optimization.
  */
-FORCE_INLINE int LZ4_decompress_generic(
-                 const char* const source,
-                 char* const dest,
-                 int inputSize,
-                 int outputSize,         /* If endOnInput==endOnInputSize, this value is the max size of Output Buffer. */
+LZ4_FORCE_INLINE int
+LZ4_decompress_generic(
+                 const char* const src,
+                 char* const dst,
+                 int srcSize,
+                 int outputSize,         /* If endOnInput==endOnInputSize, this value is `dstCapacity` */
 
-                 int endOnInput,         /* endOnOutputSize, endOnInputSize */
-                 int partialDecoding,    /* full, partial */
-                 int targetOutputSize,   /* only used if partialDecoding==partial */
-                 int dict,               /* noDict, withPrefix64k, usingExtDict */
-                 const BYTE* const lowPrefix,  /* == dest when no prefix */
+                 endCondition_directive endOnInput,   /* endOnOutputSize, endOnInputSize */
+                 earlyEnd_directive partialDecoding,  /* full, partial */
+                 dict_directive dict,                 /* noDict, withPrefix64k, usingExtDict */
+                 const BYTE* const lowPrefix,  /* always <= dst, == dst when no prefix */
                  const BYTE* const dictStart,  /* only if dict==usingExtDict */
                  const size_t dictSize         /* note : = 0 if noDict */
                  )
 {
-    /* Local Variables */
-    const BYTE* ip = (const BYTE*) source;
-    const BYTE* const iend = ip + inputSize;
+    if (src == NULL) { return -1; }
 
-    BYTE* op = (BYTE*) dest;
-    BYTE* const oend = op + outputSize;
-    BYTE* cpy;
-    BYTE* oexit = op + targetOutputSize;
-    const BYTE* const lowLimit = lowPrefix - dictSize;
+    {   const BYTE* ip = (const BYTE*) src;
+        const BYTE* const iend = ip + srcSize;
 
-    const BYTE* const dictEnd = (const BYTE*)dictStart + dictSize;
-    const unsigned dec32table[] = {0, 1, 2, 1, 4, 4, 4, 4};
-    const int dec64table[] = {0, 0, 0, -1, 0, 1, 2, 3};
+        BYTE* op = (BYTE*) dst;
+        BYTE* const oend = op + outputSize;
+        BYTE* cpy;
 
-    const int safeDecode = (endOnInput==endOnInputSize);
-    const int checkOffset = ((safeDecode) && (dictSize < (int)(64 KB)));
+        const BYTE* const dictEnd = (dictStart == NULL) ? NULL : dictStart + dictSize;
 
+        const int safeDecode = (endOnInput==endOnInputSize);
+        const int checkOffset = ((safeDecode) && (dictSize < (int)(64 KB)));
 
-    /* Special cases */
-    if ((partialDecoding) && (oexit > oend-MFLIMIT)) oexit = oend-MFLIMIT;                        /* targetOutputSize too high => decode everything */
-    if ((endOnInput) && (unlikely(outputSize==0))) return ((inputSize==1) && (*ip==0)) ? 0 : -1;  /* Empty output buffer */
-    if ((!endOnInput) && (unlikely(outputSize==0))) return (*ip==0?1:-1);
 
-    /* Main Loop : decode sequences */
-    while (1) {
-        size_t length;
+        /* Set up the "end" pointers for the shortcut. */
+        const BYTE* const shortiend = iend - (endOnInput ? 14 : 8) /*maxLL*/ - 2 /*offset*/;
+        const BYTE* const shortoend = oend - (endOnInput ? 14 : 8) /*maxLL*/ - 18 /*maxML*/;
+
         const BYTE* match;
         size_t offset;
+        unsigned token;
+        size_t length;
 
-        /* get literal length */
-        unsigned const token = *ip++;
-        if ((length=(token>>ML_BITS)) == RUN_MASK) {
-            unsigned s;
-            do {
-                s = *ip++;
-                length += s;
-            } while ( likely(endOnInput ? ip<iend-RUN_MASK : 1) & (s==255) );
-            if ((safeDecode) && unlikely((uptrval)(op)+length<(uptrval)(op))) goto _output_error;   /* overflow detection */
-            if ((safeDecode) && unlikely((uptrval)(ip)+length<(uptrval)(ip))) goto _output_error;   /* overflow detection */
+
+        DEBUGLOG(5, "LZ4_decompress_generic (srcSize:%i, dstSize:%i)", srcSize, outputSize);
+
+        /* Special cases */
+        assert(lowPrefix <= op);
+        if ((endOnInput) && (unlikely(outputSize==0))) {
+            /* Empty output buffer */
+            if (partialDecoding) return 0;
+            return ((srcSize==1) && (*ip==0)) ? 0 : -1;
+        }
+        if ((!endOnInput) && (unlikely(outputSize==0))) { return (*ip==0 ? 1 : -1); }
+        if ((endOnInput) && unlikely(srcSize==0)) { return -1; }
+
+	/* Currently the fast loop shows a regression on qualcomm arm chips. */
+#if LZ4_FAST_DEC_LOOP
+        if ((oend - op) < FASTLOOP_SAFE_DISTANCE) {
+            DEBUGLOG(6, "skip fast decode loop");
+            goto safe_decode;
         }
 
-        /* copy literals */
-        cpy = op+length;
-        if ( ((endOnInput) && ((cpy>(partialDecoding?oexit:oend-MFLIMIT)) || (ip+length>iend-(2+1+LASTLITERALS))) )
-            || ((!endOnInput) && (cpy>oend-WILDCOPYLENGTH)) )
-        {
-            if (partialDecoding) {
-                if (cpy > oend) goto _output_error;                           /* Error : write attempt beyond end of output buffer */
-                if ((endOnInput) && (ip+length > iend)) goto _output_error;   /* Error : read attempt beyond end of input buffer */
+        /* Fast loop : decode sequences as long as output < iend-FASTLOOP_SAFE_DISTANCE */
+        while (1) {
+            /* Main fastloop assertion: We can always wildcopy FASTLOOP_SAFE_DISTANCE */
+            assert(oend - op >= FASTLOOP_SAFE_DISTANCE);
+            if (endOnInput) { assert(ip < iend); }
+            token = *ip++;
+            length = token >> ML_BITS;  /* literal length */
+
+            assert(!endOnInput || ip <= iend); /* ip < iend before the increment */
+
+            /* decode literal length */
+            if (length == RUN_MASK) {
+                variable_length_error error = ok;
+                length += read_variable_length(&ip, iend-RUN_MASK, endOnInput, endOnInput, &error);
+                if (error == initial_error) { goto _output_error; }
+                if ((safeDecode) && unlikely((uptrval)(op)+length<(uptrval)(op))) { goto _output_error; } /* overflow detection */
+                if ((safeDecode) && unlikely((uptrval)(ip)+length<(uptrval)(ip))) { goto _output_error; } /* overflow detection */
+
+                /* copy literals */
+                cpy = op+length;
+                LZ4_STATIC_ASSERT(MFLIMIT >= WILDCOPYLENGTH);
+                if (endOnInput) {  /* LZ4_decompress_safe() */
+                    if ((cpy>oend-32) || (ip+length>iend-32)) { goto safe_literal_copy; }
+                    LZ4_wildCopy32(op, ip, cpy);
+                } else {   /* LZ4_decompress_fast() */
+                    if (cpy>oend-8) { goto safe_literal_copy; }
+                    LZ4_wildCopy8(op, ip, cpy); /* LZ4_decompress_fast() cannot copy more than 8 bytes at a time :
+                                                 * it doesn't know input length, and only relies on end-of-block properties */
+                }
+                ip += length; op = cpy;
             } else {
-                if ((!endOnInput) && (cpy != oend)) goto _output_error;       /* Error : block decoding must stop exactly there */
-                if ((endOnInput) && ((ip+length != iend) || (cpy > oend))) goto _output_error;   /* Error : input must be consumed */
+                cpy = op+length;
+                if (endOnInput) {  /* LZ4_decompress_safe() */
+                    DEBUGLOG(7, "copy %u bytes in a 16-bytes stripe", (unsigned)length);
+                    /* We don't need to check oend, since we check it once for each loop below */
+                    if (ip > iend-(16 + 1/*max lit + offset + nextToken*/)) { goto safe_literal_copy; }
+                    /* Literals can only be 14, but hope compilers optimize if we copy by a register size */
+                    memcpy(op, ip, 16);
+                } else {  /* LZ4_decompress_fast() */
+                    /* LZ4_decompress_fast() cannot copy more than 8 bytes at a time :
+                     * it doesn't know input length, and relies on end-of-block properties */
+                    memcpy(op, ip, 8);
+                    if (length > 8) { memcpy(op+8, ip+8, 8); }
+                }
+                ip += length; op = cpy;
             }
-            memcpy(op, ip, length);
-            ip += length;
-            op += length;
-            break;     /* Necessarily EOF, due to parsing restrictions */
-        }
-        LZ4_wildCopy(op, ip, cpy);
-        ip += length; op = cpy;
-
-        /* get offset */
-        offset = LZ4_readLE16(ip); ip+=2;
-        match = op - offset;
-        if ((checkOffset) && (unlikely(match < lowLimit))) goto _output_error;   /* Error : offset outside buffers */
-        LZ4_write32(op, (U32)offset);   /* costs ~1%; silence an msan warning when offset==0 */
-
-        /* get matchlength */
-        length = token & ML_MASK;
-        if (length == ML_MASK) {
-            unsigned s;
-            do {
-                s = *ip++;
-                if ((endOnInput) && (ip > iend-LASTLITERALS)) goto _output_error;
-                length += s;
-            } while (s==255);
-            if ((safeDecode) && unlikely((uptrval)(op)+length<(uptrval)op)) goto _output_error;   /* overflow detection */
+
+            /* get offset */
+            offset = LZ4_readLE16(ip); ip+=2;
+            match = op - offset;
+            assert(match <= op);
+
+            /* get matchlength */
+            length = token & ML_MASK;
+
+            if (length == ML_MASK) {
+              variable_length_error error = ok;
+              if ((checkOffset) && (unlikely(match + dictSize < lowPrefix))) { goto _output_error; } /* Error : offset outside buffers */
+              length += read_variable_length(&ip, iend - LASTLITERALS + 1, endOnInput, 0, &error);
+              if (error != ok) { goto _output_error; }
+                if ((safeDecode) && unlikely((uptrval)(op)+length<(uptrval)op)) { goto _output_error; } /* overflow detection */
+                length += MINMATCH;
+                if (op + length >= oend - FASTLOOP_SAFE_DISTANCE) {
+                    goto safe_match_copy;
+                }
+            } else {
+                length += MINMATCH;
+                if (op + length >= oend - FASTLOOP_SAFE_DISTANCE) {
+                    goto safe_match_copy;
+                }
+
+                /* Fastpath check: Avoids a branch in LZ4_wildCopy32 if true */
+                if ((dict == withPrefix64k) || (match >= lowPrefix)) {
+                    if (offset >= 8) {
+                        assert(match >= lowPrefix);
+                        assert(match <= op);
+                        assert(op + 18 <= oend);
+
+                        memcpy(op, match, 8);
+                        memcpy(op+8, match+8, 8);
+                        memcpy(op+16, match+16, 2);
+                        op += length;
+                        continue;
+            }   }   }
+
+            if ((checkOffset) && (unlikely(match + dictSize < lowPrefix))) { goto _output_error; } /* Error : offset outside buffers */
+            /* match starting within external dictionary */
+            if ((dict==usingExtDict) && (match < lowPrefix)) {
+                if (unlikely(op+length > oend-LASTLITERALS)) {
+                    if (partialDecoding) {
+                        length = MIN(length, (size_t)(oend-op));  /* reach end of buffer */
+                    } else {
+                        goto _output_error;  /* end-of-block condition violated */
+                }   }
+
+                if (length <= (size_t)(lowPrefix-match)) {
+                    /* match fits entirely within external dictionary : just copy */
+                    memmove(op, dictEnd - (lowPrefix-match), length);
+                    op += length;
+                } else {
+                    /* match stretches into both external dictionary and current block */
+                    size_t const copySize = (size_t)(lowPrefix - match);
+                    size_t const restSize = length - copySize;
+                    memcpy(op, dictEnd - copySize, copySize);
+                    op += copySize;
+                    if (restSize > (size_t)(op - lowPrefix)) {  /* overlap copy */
+                        BYTE* const endOfMatch = op + restSize;
+                        const BYTE* copyFrom = lowPrefix;
+                        while (op < endOfMatch) { *op++ = *copyFrom++; }
+                    } else {
+                        memcpy(op, lowPrefix, restSize);
+                        op += restSize;
+                }   }
+                continue;
+            }
+
+            /* copy match within block */
+            cpy = op + length;
+
+            assert((op <= oend) && (oend-op >= 32));
+            if (unlikely(offset<16)) {
+                LZ4_memcpy_using_offset(op, match, cpy, offset);
+            } else {
+                LZ4_wildCopy32(op, match, cpy);
+            }
+
+            op = cpy;   /* wildcopy correction */
         }
-        length += MINMATCH;
+    safe_decode:
+#endif
+
+        /* Main Loop : decode remaining sequences where output < FASTLOOP_SAFE_DISTANCE */
+        while (1) {
+            token = *ip++;
+            length = token >> ML_BITS;  /* literal length */
 
-        /* check external dictionary */
-        if ((dict==usingExtDict) && (match < lowPrefix)) {
-            if (unlikely(op+length > oend-LASTLITERALS)) goto _output_error;   /* doesn't respect parsing restriction */
+            assert(!endOnInput || ip <= iend); /* ip < iend before the increment */
+
+            /* A two-stage shortcut for the most common case:
+             * 1) If the literal length is 0..14, and there is enough space,
+             * enter the shortcut and copy 16 bytes on behalf of the literals
+             * (in the fast mode, only 8 bytes can be safely copied this way).
+             * 2) Further if the match length is 4..18, copy 18 bytes in a similar
+             * manner; but we ensure that there's enough space in the output for
+             * those 18 bytes earlier, upon entering the shortcut (in other words,
+             * there is a combined check for both stages).
+             */
+            if ( (endOnInput ? length != RUN_MASK : length <= 8)
+                /* strictly "less than" on input, to re-enter the loop with at least one byte */
+              && likely((endOnInput ? ip < shortiend : 1) & (op <= shortoend)) ) {
+                /* Copy the literals */
+                memcpy(op, ip, endOnInput ? 16 : 8);
+                op += length; ip += length;
+
+                /* The second stage: prepare for match copying, decode full info.
+                 * If it doesn't work out, the info won't be wasted. */
+                length = token & ML_MASK; /* match length */
+                offset = LZ4_readLE16(ip); ip += 2;
+                match = op - offset;
+                assert(match <= op); /* check overflow */
+
+                /* Do not deal with overlapping matches. */
+                if ( (length != ML_MASK)
+                  && (offset >= 8)
+                  && (dict==withPrefix64k || match >= lowPrefix) ) {
+                    /* Copy the match. */
+                    memcpy(op + 0, match + 0, 8);
+                    memcpy(op + 8, match + 8, 8);
+                    memcpy(op +16, match +16, 2);
+                    op += length + MINMATCH;
+                    /* Both stages worked, load the next token. */
+                    continue;
+                }
+
+                /* The second stage didn't work out, but the info is ready.
+                 * Propel it right to the point of match copying. */
+                goto _copy_match;
+            }
+
+            /* decode literal length */
+            if (length == RUN_MASK) {
+                variable_length_error error = ok;
+                length += read_variable_length(&ip, iend-RUN_MASK, endOnInput, endOnInput, &error);
+                if (error == initial_error) { goto _output_error; }
+                if ((safeDecode) && unlikely((uptrval)(op)+length<(uptrval)(op))) { goto _output_error; } /* overflow detection */
+                if ((safeDecode) && unlikely((uptrval)(ip)+length<(uptrval)(ip))) { goto _output_error; } /* overflow detection */
+            }
 
-            if (length <= (size_t)(lowPrefix-match)) {
-                /* match can be copied as a single segment from external dictionary */
-                memmove(op, dictEnd - (lowPrefix-match), length);
+            /* copy literals */
+            cpy = op+length;
+#if LZ4_FAST_DEC_LOOP
+        safe_literal_copy:
+#endif
+            LZ4_STATIC_ASSERT(MFLIMIT >= WILDCOPYLENGTH);
+            if ( ((endOnInput) && ((cpy>oend-MFLIMIT) || (ip+length>iend-(2+1+LASTLITERALS))) )
+              || ((!endOnInput) && (cpy>oend-WILDCOPYLENGTH)) )
+            {
+                /* We've either hit the input parsing restriction or the output parsing restriction.
+                 * If we've hit the input parsing condition then this must be the last sequence.
+                 * If we've hit the output parsing condition then we are either using partialDecoding
+                 * or we've hit the output parsing condition.
+                 */
+                if (partialDecoding) {
+                    /* Since we are partial decoding we may be in this block because of the output parsing
+                     * restriction, which is not valid since the output buffer is allowed to be undersized.
+                     */
+                    assert(endOnInput);
+                    /* If we're in this block because of the input parsing condition, then we must be on the
+                     * last sequence (or invalid), so we must check that we exactly consume the input.
+                     */
+                    if ((ip+length>iend-(2+1+LASTLITERALS)) && (ip+length != iend)) { goto _output_error; }
+                    assert(ip+length <= iend);
+                    /* We are finishing in the middle of a literals segment.
+                     * Break after the copy.
+                     */
+                    if (cpy > oend) {
+                        cpy = oend;
+                        assert(op<=oend);
+                        length = (size_t)(oend-op);
+                    }
+                    assert(ip+length <= iend);
+                } else {
+                    /* We must be on the last sequence because of the parsing limitations so check
+                     * that we exactly regenerate the original size (must be exact when !endOnInput).
+                     */
+                    if ((!endOnInput) && (cpy != oend)) { goto _output_error; }
+                     /* We must be on the last sequence (or invalid) because of the parsing limitations
+                      * so check that we exactly consume the input and don't overrun the output buffer.
+                      */
+                    if ((endOnInput) && ((ip+length != iend) || (cpy > oend))) { goto _output_error; }
+                }
+                memmove(op, ip, length);  /* supports overlapping memory regions, which only matters for in-place decompression scenarios */
+                ip += length;
                 op += length;
+                /* Necessarily EOF when !partialDecoding. When partialDecoding
+                 * it is EOF if we've either filled the output buffer or hit
+                 * the input parsing restriction.
+                 */
+                if (!partialDecoding || (cpy == oend) || (ip == iend)) {
+                    break;
+                }
             } else {
-                /* match encompass external dictionary and current block */
-                size_t const copySize = (size_t)(lowPrefix-match);
-                size_t const restSize = length - copySize;
-                memcpy(op, dictEnd - copySize, copySize);
-                op += copySize;
-                if (restSize > (size_t)(op-lowPrefix)) {  /* overlap copy */
-                    BYTE* const endOfMatch = op + restSize;
-                    const BYTE* copyFrom = lowPrefix;
-                    while (op < endOfMatch) *op++ = *copyFrom++;
+                LZ4_wildCopy8(op, ip, cpy);   /* may overwrite up to WILDCOPYLENGTH beyond cpy */
+                ip += length; op = cpy;
+            }
+
+            /* get offset */
+            offset = LZ4_readLE16(ip); ip+=2;
+            match = op - offset;
+
+            /* get matchlength */
+            length = token & ML_MASK;
+
+    _copy_match:
+            if (length == ML_MASK) {
+              variable_length_error error = ok;
+              length += read_variable_length(&ip, iend - LASTLITERALS + 1, endOnInput, 0, &error);
+              if (error != ok) goto _output_error;
+                if ((safeDecode) && unlikely((uptrval)(op)+length<(uptrval)op)) goto _output_error;   /* overflow detection */
+            }
+            length += MINMATCH;
+
+#if LZ4_FAST_DEC_LOOP
+        safe_match_copy:
+#endif
+            if ((checkOffset) && (unlikely(match + dictSize < lowPrefix))) goto _output_error;   /* Error : offset outside buffers */
+            /* match starting within external dictionary */
+            if ((dict==usingExtDict) && (match < lowPrefix)) {
+                if (unlikely(op+length > oend-LASTLITERALS)) {
+                    if (partialDecoding) length = MIN(length, (size_t)(oend-op));
+                    else goto _output_error;   /* doesn't respect parsing restriction */
+                }
+
+                if (length <= (size_t)(lowPrefix-match)) {
+                    /* match fits entirely within external dictionary : just copy */
+                    memmove(op, dictEnd - (lowPrefix-match), length);
+                    op += length;
                 } else {
-                    memcpy(op, lowPrefix, restSize);
-                    op += restSize;
-            }   }
-            continue;
-        }
+                    /* match stretches into both external dictionary and current block */
+                    size_t const copySize = (size_t)(lowPrefix - match);
+                    size_t const restSize = length - copySize;
+                    memcpy(op, dictEnd - copySize, copySize);
+                    op += copySize;
+                    if (restSize > (size_t)(op - lowPrefix)) {  /* overlap copy */
+                        BYTE* const endOfMatch = op + restSize;
+                        const BYTE* copyFrom = lowPrefix;
+                        while (op < endOfMatch) *op++ = *copyFrom++;
+                    } else {
+                        memcpy(op, lowPrefix, restSize);
+                        op += restSize;
+                }   }
+                continue;
+            }
+            assert(match >= lowPrefix);
+
+            /* copy match within block */
+            cpy = op + length;
 
-        /* copy match within block */
-        cpy = op + length;
-        if (unlikely(offset<8)) {
-            const int dec64 = dec64table[offset];
-            op[0] = match[0];
-            op[1] = match[1];
-            op[2] = match[2];
-            op[3] = match[3];
-            match += dec32table[offset];
-            memcpy(op+4, match, 4);
-            match -= dec64;
-        } else { LZ4_copy8(op, match); match+=8; }
-        op += 8;
-
-        if (unlikely(cpy>oend-12)) {
-            BYTE* const oCopyLimit = oend-(WILDCOPYLENGTH-1);
-            if (cpy > oend-LASTLITERALS) goto _output_error;    /* Error : last LASTLITERALS bytes must be literals (uncompressed) */
-            if (op < oCopyLimit) {
-                LZ4_wildCopy(op, match, oCopyLimit);
-                match += oCopyLimit - op;
-                op = oCopyLimit;
+            /* partialDecoding : may end anywhere within the block */
+            assert(op<=oend);
+            if (partialDecoding && (cpy > oend-MATCH_SAFEGUARD_DISTANCE)) {
+                size_t const mlen = MIN(length, (size_t)(oend-op));
+                const BYTE* const matchEnd = match + mlen;
+                BYTE* const copyEnd = op + mlen;
+                if (matchEnd > op) {   /* overlap copy */
+                    while (op < copyEnd) { *op++ = *match++; }
+                } else {
+                    memcpy(op, match, mlen);
+                }
+                op = copyEnd;
+                if (op == oend) { break; }
+                continue;
             }
-            while (op<cpy) *op++ = *match++;
-        } else {
-            LZ4_copy8(op, match);
-            if (length>16) LZ4_wildCopy(op+8, match+8, cpy);
+
+            if (unlikely(offset<8)) {
+                LZ4_write32(op, 0);   /* silence msan warning when offset==0 */
+                op[0] = match[0];
+                op[1] = match[1];
+                op[2] = match[2];
+                op[3] = match[3];
+                match += inc32table[offset];
+                memcpy(op+4, match, 4);
+                match -= dec64table[offset];
+            } else {
+                memcpy(op, match, 8);
+                match += 8;
+            }
+            op += 8;
+
+            if (unlikely(cpy > oend-MATCH_SAFEGUARD_DISTANCE)) {
+                BYTE* const oCopyLimit = oend - (WILDCOPYLENGTH-1);
+                if (cpy > oend-LASTLITERALS) { goto _output_error; } /* Error : last LASTLITERALS bytes must be literals (uncompressed) */
+                if (op < oCopyLimit) {
+                    LZ4_wildCopy8(op, match, oCopyLimit);
+                    match += oCopyLimit - op;
+                    op = oCopyLimit;
+                }
+                while (op < cpy) { *op++ = *match++; }
+            } else {
+                memcpy(op, match, 8);
+                if (length > 16)  { LZ4_wildCopy8(op+8, match+8, cpy); }
+            }
+            op = cpy;   /* wildcopy correction */
         }
-        op=cpy;   /* correction */
+
+        /* end of decoding */
+        if (endOnInput) {
+           return (int) (((char*)op)-dst);     /* Nb of output bytes decoded */
+       } else {
+           return (int) (((const char*)ip)-src);   /* Nb of input bytes read */
+       }
+
+        /* Overflow error detected */
+    _output_error:
+        return (int) (-(((const char*)ip)-src))-1;
     }
-
-    /* end of decoding */
-    if (endOnInput)
-       return (int) (((char*)op)-dest);     /* Nb of output bytes decoded */
-    else
-       return (int) (((const char*)ip)-source);   /* Nb of input bytes read */
-
-    /* Overflow error detected */
-_output_error:
-    return (int) (-(((const char*)ip)-source))-1;
 }
 
 
+/*===== Instantiate the API decoding functions. =====*/
+
+LZ4_FORCE_O2_GCC_PPC64LE
 int LZ4_decompress_safe(const char* source, char* dest, int compressedSize, int maxDecompressedSize)
 {
-    return LZ4_decompress_generic(source, dest, compressedSize, maxDecompressedSize, endOnInputSize, full, 0, noDict, (BYTE*)dest, NULL, 0);
+    return LZ4_decompress_generic(source, dest, compressedSize, maxDecompressedSize,
+                                  endOnInputSize, decode_full_block, noDict,
+                                  (BYTE*)dest, NULL, 0);
 }
 
-int LZ4_decompress_safe_partial(const char* source, char* dest, int compressedSize, int targetOutputSize, int maxDecompressedSize)
+LZ4_FORCE_O2_GCC_PPC64LE
+int LZ4_decompress_safe_partial(const char* src, char* dst, int compressedSize, int targetOutputSize, int dstCapacity)
 {
-    return LZ4_decompress_generic(source, dest, compressedSize, maxDecompressedSize, endOnInputSize, partial, targetOutputSize, noDict, (BYTE*)dest, NULL, 0);
+    dstCapacity = MIN(targetOutputSize, dstCapacity);
+    return LZ4_decompress_generic(src, dst, compressedSize, dstCapacity,
+                                  endOnInputSize, partial_decode,
+                                  noDict, (BYTE*)dst, NULL, 0);
 }
 
+LZ4_FORCE_O2_GCC_PPC64LE
 int LZ4_decompress_fast(const char* source, char* dest, int originalSize)
 {
-    return LZ4_decompress_generic(source, dest, 0, originalSize, endOnOutputSize, full, 0, withPrefix64k, (BYTE*)(dest - 64 KB), NULL, 64 KB);
+    return LZ4_decompress_generic(source, dest, 0, originalSize,
+                                  endOnOutputSize, decode_full_block, withPrefix64k,
+                                  (BYTE*)dest - 64 KB, NULL, 0);
 }
 
+/*===== Instantiate a few more decoding cases, used more than once. =====*/
+
+LZ4_FORCE_O2_GCC_PPC64LE /* Exported, an obsolete API function. */
+int LZ4_decompress_safe_withPrefix64k(const char* source, char* dest, int compressedSize, int maxOutputSize)
+{
+    return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize,
+                                  endOnInputSize, decode_full_block, withPrefix64k,
+                                  (BYTE*)dest - 64 KB, NULL, 0);
+}
+
+/* Another obsolete API function, paired with the previous one. */
+int LZ4_decompress_fast_withPrefix64k(const char* source, char* dest, int originalSize)
+{
+    /* LZ4_decompress_fast doesn't validate match offsets,
+     * and thus serves well with any prefixed dictionary. */
+    return LZ4_decompress_fast(source, dest, originalSize);
+}
+
+LZ4_FORCE_O2_GCC_PPC64LE
+static int LZ4_decompress_safe_withSmallPrefix(const char* source, char* dest, int compressedSize, int maxOutputSize,
+                                               size_t prefixSize)
+{
+    return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize,
+                                  endOnInputSize, decode_full_block, noDict,
+                                  (BYTE*)dest-prefixSize, NULL, 0);
+}
+
+LZ4_FORCE_O2_GCC_PPC64LE
+int LZ4_decompress_safe_forceExtDict(const char* source, char* dest,
+                                     int compressedSize, int maxOutputSize,
+                                     const void* dictStart, size_t dictSize)
+{
+    return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize,
+                                  endOnInputSize, decode_full_block, usingExtDict,
+                                  (BYTE*)dest, (const BYTE*)dictStart, dictSize);
+}
+
+LZ4_FORCE_O2_GCC_PPC64LE
+static int LZ4_decompress_fast_extDict(const char* source, char* dest, int originalSize,
+                                       const void* dictStart, size_t dictSize)
+{
+    return LZ4_decompress_generic(source, dest, 0, originalSize,
+                                  endOnOutputSize, decode_full_block, usingExtDict,
+                                  (BYTE*)dest, (const BYTE*)dictStart, dictSize);
+}
+
+/* The "double dictionary" mode, for use with e.g. ring buffers: the first part
+ * of the dictionary is passed as prefix, and the second via dictStart + dictSize.
+ * These routines are used only once, in LZ4_decompress_*_continue().
+ */
+LZ4_FORCE_INLINE
+int LZ4_decompress_safe_doubleDict(const char* source, char* dest, int compressedSize, int maxOutputSize,
+                                   size_t prefixSize, const void* dictStart, size_t dictSize)
+{
+    return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize,
+                                  endOnInputSize, decode_full_block, usingExtDict,
+                                  (BYTE*)dest-prefixSize, (const BYTE*)dictStart, dictSize);
+}
+
+LZ4_FORCE_INLINE
+int LZ4_decompress_fast_doubleDict(const char* source, char* dest, int originalSize,
+                                   size_t prefixSize, const void* dictStart, size_t dictSize)
+{
+    return LZ4_decompress_generic(source, dest, 0, originalSize,
+                                  endOnOutputSize, decode_full_block, usingExtDict,
+                                  (BYTE*)dest-prefixSize, (const BYTE*)dictStart, dictSize);
+}
 
 /*===== streaming decompression functions =====*/
 
-/*
- * If you prefer dynamic allocation methods,
- * LZ4_createStreamDecode()
- * provides a pointer (void*) towards an initialized LZ4_streamDecode_t structure.
- */
 LZ4_streamDecode_t* LZ4_createStreamDecode(void)
 {
-    LZ4_streamDecode_t* lz4s = (LZ4_streamDecode_t*) ALLOCATOR(1, sizeof(LZ4_streamDecode_t));
+    LZ4_streamDecode_t* lz4s = (LZ4_streamDecode_t*) ALLOC_AND_ZERO(sizeof(LZ4_streamDecode_t));
+    LZ4_STATIC_ASSERT(LZ4_STREAMDECODESIZE >= sizeof(LZ4_streamDecode_t_internal));    /* A compilation error here means LZ4_STREAMDECODESIZE is not large enough */
     return lz4s;
 }
 
 int LZ4_freeStreamDecode (LZ4_streamDecode_t* LZ4_stream)
 {
+    if (LZ4_stream == NULL) { return 0; }  /* support free on NULL */
     FREEMEM(LZ4_stream);
     return 0;
 }
 
-/*!
- * LZ4_setStreamDecode() :
- * Use this function to instruct where to find the dictionary.
- * This function is not necessary if previous data is still available where it was decoded.
- * Loading a size of 0 is allowed (same effect as no dictionary).
- * Return : 1 if OK, 0 if error
+/*! LZ4_setStreamDecode() :
+ *  Use this function to instruct where to find the dictionary.
+ *  This function is not necessary if previous data is still available where it was decoded.
+ *  Loading a size of 0 is allowed (same effect as no dictionary).
+ * @return : 1 if OK, 0 if error
  */
 int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dictionary, int dictSize)
 {
@@ -1310,6 +2205,25 @@ int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dicti
     return 1;
 }
 
+/*! LZ4_decoderRingBufferSize() :
+ *  when setting a ring buffer for streaming decompression (optional scenario),
+ *  provides the minimum size of this ring buffer
+ *  to be compatible with any source respecting maxBlockSize condition.
+ *  Note : in a ring buffer scenario,
+ *  blocks are presumed decompressed next to each other.
+ *  When not enough space remains for next block (remainingSize < maxBlockSize),
+ *  decoding resumes from beginning of ring buffer.
+ * @return : minimum ring buffer size,
+ *           or 0 if there is an error (invalid maxBlockSize).
+ */
+int LZ4_decoderRingBufferSize(int maxBlockSize)
+{
+    if (maxBlockSize < 0) return 0;
+    if (maxBlockSize > LZ4_MAX_INPUT_SIZE) return 0;
+    if (maxBlockSize < 16) maxBlockSize = 16;
+    return LZ4_DECODER_RING_BUFFER_SIZE(maxBlockSize);
+}
+
 /*
 *_continue() :
     These decoding functions allow decompression of multiple blocks in "streaming" mode.
@@ -1317,52 +2231,75 @@ int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dicti
     If it's not possible, save the relevant part of decoded data into a safe buffer,
     and indicate where it stands using LZ4_setStreamDecode()
 */
+LZ4_FORCE_O2_GCC_PPC64LE
 int LZ4_decompress_safe_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int compressedSize, int maxOutputSize)
 {
     LZ4_streamDecode_t_internal* lz4sd = &LZ4_streamDecode->internal_donotuse;
     int result;
 
-    if (lz4sd->prefixEnd == (BYTE*)dest) {
-        result = LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize,
-                                        endOnInputSize, full, 0,
-                                        usingExtDict, lz4sd->prefixEnd - lz4sd->prefixSize, lz4sd->externalDict, lz4sd->extDictSize);
+    if (lz4sd->prefixSize == 0) {
+        /* The first call, no dictionary yet. */
+        assert(lz4sd->extDictSize == 0);
+        result = LZ4_decompress_safe(source, dest, compressedSize, maxOutputSize);
         if (result <= 0) return result;
-        lz4sd->prefixSize += result;
+        lz4sd->prefixSize = (size_t)result;
+        lz4sd->prefixEnd = (BYTE*)dest + result;
+    } else if (lz4sd->prefixEnd == (BYTE*)dest) {
+        /* They're rolling the current segment. */
+        if (lz4sd->prefixSize >= 64 KB - 1)
+            result = LZ4_decompress_safe_withPrefix64k(source, dest, compressedSize, maxOutputSize);
+        else if (lz4sd->extDictSize == 0)
+            result = LZ4_decompress_safe_withSmallPrefix(source, dest, compressedSize, maxOutputSize,
+                                                         lz4sd->prefixSize);
+        else
+            result = LZ4_decompress_safe_doubleDict(source, dest, compressedSize, maxOutputSize,
+                                                    lz4sd->prefixSize, lz4sd->externalDict, lz4sd->extDictSize);
+        if (result <= 0) return result;
+        lz4sd->prefixSize += (size_t)result;
         lz4sd->prefixEnd  += result;
     } else {
+        /* The buffer wraps around, or they're switching to another buffer. */
         lz4sd->extDictSize = lz4sd->prefixSize;
         lz4sd->externalDict = lz4sd->prefixEnd - lz4sd->extDictSize;
-        result = LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize,
-                                        endOnInputSize, full, 0,
-                                        usingExtDict, (BYTE*)dest, lz4sd->externalDict, lz4sd->extDictSize);
+        result = LZ4_decompress_safe_forceExtDict(source, dest, compressedSize, maxOutputSize,
+                                                  lz4sd->externalDict, lz4sd->extDictSize);
         if (result <= 0) return result;
-        lz4sd->prefixSize = result;
+        lz4sd->prefixSize = (size_t)result;
         lz4sd->prefixEnd  = (BYTE*)dest + result;
     }
 
     return result;
 }
 
+LZ4_FORCE_O2_GCC_PPC64LE
 int LZ4_decompress_fast_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int originalSize)
 {
     LZ4_streamDecode_t_internal* lz4sd = &LZ4_streamDecode->internal_donotuse;
     int result;
+    assert(originalSize >= 0);
 
-    if (lz4sd->prefixEnd == (BYTE*)dest) {
-        result = LZ4_decompress_generic(source, dest, 0, originalSize,
-                                        endOnOutputSize, full, 0,
-                                        usingExtDict, lz4sd->prefixEnd - lz4sd->prefixSize, lz4sd->externalDict, lz4sd->extDictSize);
+    if (lz4sd->prefixSize == 0) {
+        assert(lz4sd->extDictSize == 0);
+        result = LZ4_decompress_fast(source, dest, originalSize);
         if (result <= 0) return result;
-        lz4sd->prefixSize += originalSize;
+        lz4sd->prefixSize = (size_t)originalSize;
+        lz4sd->prefixEnd = (BYTE*)dest + originalSize;
+    } else if (lz4sd->prefixEnd == (BYTE*)dest) {
+        if (lz4sd->prefixSize >= 64 KB - 1 || lz4sd->extDictSize == 0)
+            result = LZ4_decompress_fast(source, dest, originalSize);
+        else
+            result = LZ4_decompress_fast_doubleDict(source, dest, originalSize,
+                                                    lz4sd->prefixSize, lz4sd->externalDict, lz4sd->extDictSize);
+        if (result <= 0) return result;
+        lz4sd->prefixSize += (size_t)originalSize;
         lz4sd->prefixEnd  += originalSize;
     } else {
         lz4sd->extDictSize = lz4sd->prefixSize;
         lz4sd->externalDict = lz4sd->prefixEnd - lz4sd->extDictSize;
-        result = LZ4_decompress_generic(source, dest, 0, originalSize,
-                                        endOnOutputSize, full, 0,
-                                        usingExtDict, (BYTE*)dest, lz4sd->externalDict, lz4sd->extDictSize);
+        result = LZ4_decompress_fast_extDict(source, dest, originalSize,
+                                             lz4sd->externalDict, lz4sd->extDictSize);
         if (result <= 0) return result;
-        lz4sd->prefixSize = originalSize;
+        lz4sd->prefixSize = (size_t)originalSize;
         lz4sd->prefixEnd  = (BYTE*)dest + originalSize;
     }
 
@@ -1377,32 +2314,27 @@ Advanced decoding functions :
     the dictionary must be explicitly provided within parameters
 */
 
-FORCE_INLINE int LZ4_decompress_usingDict_generic(const char* source, char* dest, int compressedSize, int maxOutputSize, int safe, const char* dictStart, int dictSize)
+int LZ4_decompress_safe_usingDict(const char* source, char* dest, int compressedSize, int maxOutputSize, const char* dictStart, int dictSize)
 {
     if (dictSize==0)
-        return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, noDict, (BYTE*)dest, NULL, 0);
+        return LZ4_decompress_safe(source, dest, compressedSize, maxOutputSize);
     if (dictStart+dictSize == dest) {
-        if (dictSize >= (int)(64 KB - 1))
-            return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, withPrefix64k, (BYTE*)dest-64 KB, NULL, 0);
-        return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, noDict, (BYTE*)dest-dictSize, NULL, 0);
+        if (dictSize >= 64 KB - 1) {
+            return LZ4_decompress_safe_withPrefix64k(source, dest, compressedSize, maxOutputSize);
+        }
+        assert(dictSize >= 0);
+        return LZ4_decompress_safe_withSmallPrefix(source, dest, compressedSize, maxOutputSize, (size_t)dictSize);
     }
-    return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, usingExtDict, (BYTE*)dest, (const BYTE*)dictStart, dictSize);
-}
-
-int LZ4_decompress_safe_usingDict(const char* source, char* dest, int compressedSize, int maxOutputSize, const char* dictStart, int dictSize)
-{
-    return LZ4_decompress_usingDict_generic(source, dest, compressedSize, maxOutputSize, 1, dictStart, dictSize);
+    assert(dictSize >= 0);
+    return LZ4_decompress_safe_forceExtDict(source, dest, compressedSize, maxOutputSize, dictStart, (size_t)dictSize);
 }
 
 int LZ4_decompress_fast_usingDict(const char* source, char* dest, int originalSize, const char* dictStart, int dictSize)
 {
-    return LZ4_decompress_usingDict_generic(source, dest, 0, originalSize, 0, dictStart, dictSize);
-}
-
-/* debug function */
-int LZ4_decompress_safe_forceExtDict(const char* source, char* dest, int compressedSize, int maxOutputSize, const char* dictStart, int dictSize)
-{
-    return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, endOnInputSize, full, 0, usingExtDict, (BYTE*)dest, (const BYTE*)dictStart, dictSize);
+    if (dictSize==0 || dictStart+dictSize == dest)
+        return LZ4_decompress_fast(source, dest, originalSize);
+    assert(dictSize >= 0);
+    return LZ4_decompress_fast_extDict(source, dest, originalSize, dictStart, (size_t)dictSize);
 }
 
 
@@ -1410,64 +2342,67 @@ int LZ4_decompress_safe_forceExtDict(const char* source, char* dest, int compres
 *  Obsolete Functions
 ***************************************************/
 /* obsolete compression functions */
-int LZ4_compress_limitedOutput(const char* source, char* dest, int inputSize, int maxOutputSize) { return LZ4_compress_default(source, dest, inputSize, maxOutputSize); }
-int LZ4_compress(const char* source, char* dest, int inputSize) { return LZ4_compress_default(source, dest, inputSize, LZ4_compressBound(inputSize)); }
-int LZ4_compress_limitedOutput_withState (void* state, const char* src, char* dst, int srcSize, int dstSize) { return LZ4_compress_fast_extState(state, src, dst, srcSize, dstSize, 1); }
-int LZ4_compress_withState (void* state, const char* src, char* dst, int srcSize) { return LZ4_compress_fast_extState(state, src, dst, srcSize, LZ4_compressBound(srcSize), 1); }
-int LZ4_compress_limitedOutput_continue (LZ4_stream_t* LZ4_stream, const char* src, char* dst, int srcSize, int maxDstSize) { return LZ4_compress_fast_continue(LZ4_stream, src, dst, srcSize, maxDstSize, 1); }
-int LZ4_compress_continue (LZ4_stream_t* LZ4_stream, const char* source, char* dest, int inputSize) { return LZ4_compress_fast_continue(LZ4_stream, source, dest, inputSize, LZ4_compressBound(inputSize), 1); }
+int LZ4_compress_limitedOutput(const char* source, char* dest, int inputSize, int maxOutputSize)
+{
+    return LZ4_compress_default(source, dest, inputSize, maxOutputSize);
+}
+int LZ4_compress(const char* src, char* dest, int srcSize)
+{
+    return LZ4_compress_default(src, dest, srcSize, LZ4_compressBound(srcSize));
+}
+int LZ4_compress_limitedOutput_withState (void* state, const char* src, char* dst, int srcSize, int dstSize)
+{
+    return LZ4_compress_fast_extState(state, src, dst, srcSize, dstSize, 1);
+}
+int LZ4_compress_withState (void* state, const char* src, char* dst, int srcSize)
+{
+    return LZ4_compress_fast_extState(state, src, dst, srcSize, LZ4_compressBound(srcSize), 1);
+}
+int LZ4_compress_limitedOutput_continue (LZ4_stream_t* LZ4_stream, const char* src, char* dst, int srcSize, int dstCapacity)
+{
+    return LZ4_compress_fast_continue(LZ4_stream, src, dst, srcSize, dstCapacity, 1);
+}
+int LZ4_compress_continue (LZ4_stream_t* LZ4_stream, const char* source, char* dest, int inputSize)
+{
+    return LZ4_compress_fast_continue(LZ4_stream, source, dest, inputSize, LZ4_compressBound(inputSize), 1);
+}
 
 /*
-These function names are deprecated and should no longer be used.
+These decompression functions are deprecated and should no longer be used.
 They are only provided here for compatibility with older user programs.
 - LZ4_uncompress is totally equivalent to LZ4_decompress_fast
 - LZ4_uncompress_unknownOutputSize is totally equivalent to LZ4_decompress_safe
 */
-int LZ4_uncompress (const char* source, char* dest, int outputSize) { return LZ4_decompress_fast(source, dest, outputSize); }
-int LZ4_uncompress_unknownOutputSize (const char* source, char* dest, int isize, int maxOutputSize) { return LZ4_decompress_safe(source, dest, isize, maxOutputSize); }
-
+int LZ4_uncompress (const char* source, char* dest, int outputSize)
+{
+    return LZ4_decompress_fast(source, dest, outputSize);
+}
+int LZ4_uncompress_unknownOutputSize (const char* source, char* dest, int isize, int maxOutputSize)
+{
+    return LZ4_decompress_safe(source, dest, isize, maxOutputSize);
+}
 
 /* Obsolete Streaming functions */
 
 int LZ4_sizeofStreamState() { return LZ4_STREAMSIZE; }
 
-static void LZ4_init(LZ4_stream_t* lz4ds, BYTE* base)
-{
-    MEM_INIT(lz4ds, 0, sizeof(LZ4_stream_t));
-    lz4ds->internal_donotuse.bufferStart = base;
-}
-
 int LZ4_resetStreamState(void* state, char* inputBuffer)
 {
-    if ((((uptrval)state) & 3) != 0) return 1;   /* Error : pointer is not aligned on 4-bytes boundary */
-    LZ4_init((LZ4_stream_t*)state, (BYTE*)inputBuffer);
+    (void)inputBuffer;
+    LZ4_resetStream((LZ4_stream_t*)state);
     return 0;
 }
 
 void* LZ4_create (char* inputBuffer)
 {
-    LZ4_stream_t* lz4ds = (LZ4_stream_t*)ALLOCATOR(8, sizeof(LZ4_stream_t));
-    LZ4_init (lz4ds, (BYTE*)inputBuffer);
-    return lz4ds;
+    (void)inputBuffer;
+    return LZ4_createStream();
 }
 
-char* LZ4_slideInputBuffer (void* LZ4_Data)
+char* LZ4_slideInputBuffer (void* state)
 {
-    LZ4_stream_t_internal* ctx = &((LZ4_stream_t*)LZ4_Data)->internal_donotuse;
-    int dictSize = LZ4_saveDict((LZ4_stream_t*)LZ4_Data, (char*)ctx->bufferStart, 64 KB);
-    return (char*)(ctx->bufferStart + dictSize);
-}
-
-/* Obsolete streaming decompression functions */
-
-int LZ4_decompress_safe_withPrefix64k(const char* source, char* dest, int compressedSize, int maxOutputSize)
-{
-    return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, endOnInputSize, full, 0, withPrefix64k, (BYTE*)dest - 64 KB, NULL, 64 KB);
-}
-
-int LZ4_decompress_fast_withPrefix64k(const char* source, char* dest, int originalSize)
-{
-    return LZ4_decompress_generic(source, dest, 0, originalSize, endOnOutputSize, full, 0, withPrefix64k, (BYTE*)dest - 64 KB, NULL, 64 KB);
+    /* avoid const char * -> char * conversion warning */
+    return (char *)(uptrval)((LZ4_stream_t*)state)->internal_donotuse.dictionary;
 }
 
 #endif   /* LZ4_COMMONDEFS_ONLY */
diff --git a/src/compat/compat-lz4.h b/src/compat/compat-lz4.h
index 0aae19c9..32108e23 100644
--- a/src/compat/compat-lz4.h
+++ b/src/compat/compat-lz4.h
@@ -1,7 +1,7 @@
 /*
  *  LZ4 - Fast LZ compression algorithm
  *  Header File
- *  Copyright (C) 2011-2016, Yann Collet.
+ *  Copyright (C) 2011-present, Yann Collet.
 
    BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
 
@@ -32,13 +32,13 @@
     - LZ4 homepage : http://www.lz4.org
     - LZ4 source repository : https://github.com/lz4/lz4
 */
+#if defined (__cplusplus)
+extern "C" {
+#endif
+
 #ifndef LZ4_H_2983827168210
 #define LZ4_H_2983827168210
 
-#if defined (__cplusplus)
-extern "C" {
-#endif
-
 /* --- Dependency --- */
 #include <stddef.h>   /* size_t */
 
@@ -46,24 +46,31 @@ extern "C" {
 /**
   Introduction
 
-  LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core,
+  LZ4 is lossless compression algorithm, providing compression speed >500 MB/s per core,
   scalable with multi-cores CPU. It features an extremely fast decoder, with speed in
   multiple GB/s per core, typically reaching RAM speed limits on multi-core systems.
 
   The LZ4 compression library provides in-memory compression and decompression functions.
+  It gives full buffer control to user.
   Compression can be done in:
     - a single step (described as Simple Functions)
     - a single step, reusing a context (described in Advanced Functions)
     - unbounded multiple steps (described as Streaming compression)
 
-  lz4.h provides block compression functions. It gives full buffer control to user.
-  Decompressing an lz4-compressed block also requires metadata (such as compressed size).
-  Each application is free to encode such metadata in whichever way it wants.
+  lz4.h generates and decodes LZ4-compressed blocks (doc/lz4_Block_format.md).
+  Decompressing such a compressed block requires additional metadata.
+  Exact metadata depends on exact decompression function.
+  For the typical case of LZ4_decompress_safe(),
+  metadata includes block's compressed size, and maximum bound of decompressed size.
+  Each application is free to encode and pass such metadata in whichever way it wants.
 
-  An additional format, called LZ4 frame specification (doc/lz4_Frame_format.md),
-  take care of encoding standard metadata alongside LZ4-compressed blocks.
-  If your application requires interoperability, it's recommended to use it.
-  A library is provided to take care of it, see lz4frame.h.
+  lz4.h only handle blocks, it can not generate Frames.
+
+  Blocks are different from Frames (doc/lz4_Frame_format.md).
+  Frames bundle both blocks and metadata in a specified manner.
+  Embedding metadata is required for compressed data to be self-contained and portable.
+  Frame format is delivered through a companion API, declared in lz4frame.h.
+  The `lz4` CLI can only manage frames.
 */
 
 /*^***************************************************************
@@ -72,20 +79,28 @@ extern "C" {
 /*
 *  LZ4_DLL_EXPORT :
 *  Enable exporting of functions when building a Windows DLL
+*  LZ4LIB_VISIBILITY :
+*  Control library symbols visibility.
 */
+#ifndef LZ4LIB_VISIBILITY
+#  if defined(__GNUC__) && (__GNUC__ >= 4)
+#    define LZ4LIB_VISIBILITY __attribute__ ((visibility ("default")))
+#  else
+#    define LZ4LIB_VISIBILITY
+#  endif
+#endif
 #if defined(LZ4_DLL_EXPORT) && (LZ4_DLL_EXPORT==1)
-#  define LZ4LIB_API __declspec(dllexport)
+#  define LZ4LIB_API __declspec(dllexport) LZ4LIB_VISIBILITY
 #elif defined(LZ4_DLL_IMPORT) && (LZ4_DLL_IMPORT==1)
-#  define LZ4LIB_API __declspec(dllimport) /* It isn't required but allows to generate better code, saving a function pointer load from the IAT and an indirect jump.*/
+#  define LZ4LIB_API __declspec(dllimport) LZ4LIB_VISIBILITY /* It isn't required but allows to generate better code, saving a function pointer load from the IAT and an indirect jump.*/
 #else
-#  define LZ4LIB_API
+#  define LZ4LIB_API LZ4LIB_VISIBILITY
 #endif
 
-
-/*========== Version =========== */
+/*------   Version   ------*/
 #define LZ4_VERSION_MAJOR    1    /* for breaking interface changes  */
-#define LZ4_VERSION_MINOR    7    /* for new (non-breaking) interface capabilities */
-#define LZ4_VERSION_RELEASE  5    /* for tweaks, bug-fixes, or development */
+#define LZ4_VERSION_MINOR    9    /* for new (non-breaking) interface capabilities */
+#define LZ4_VERSION_RELEASE  2    /* for tweaks, bug-fixes, or development */
 
 #define LZ4_VERSION_NUMBER (LZ4_VERSION_MAJOR *100*100 + LZ4_VERSION_MINOR *100 + LZ4_VERSION_RELEASE)
 
@@ -94,8 +109,8 @@ extern "C" {
 #define LZ4_EXPAND_AND_QUOTE(str) LZ4_QUOTE(str)
 #define LZ4_VERSION_STRING LZ4_EXPAND_AND_QUOTE(LZ4_LIB_VERSION)
 
-LZ4LIB_API int LZ4_versionNumber (void);
-LZ4LIB_API const char* LZ4_versionString (void);
+LZ4LIB_API int LZ4_versionNumber (void);  /**< library version number; useful to check dll version */
+LZ4LIB_API const char* LZ4_versionString (void);   /**< library version string; useful to check dll version */
 
 
 /*-************************************
@@ -104,41 +119,49 @@ LZ4LIB_API const char* LZ4_versionString (void);
 /*!
  * LZ4_MEMORY_USAGE :
  * Memory usage formula : N->2^N Bytes (examples : 10 -> 1KB; 12 -> 4KB ; 16 -> 64KB; 20 -> 1MB; etc.)
- * Increasing memory usage improves compression ratio
- * Reduced memory usage can improve speed, due to cache effect
+ * Increasing memory usage improves compression ratio.
+ * Reduced memory usage may improve speed, thanks to better cache locality.
  * Default value is 14, for 16KB, which nicely fits into Intel x86 L1 cache
  */
-#define LZ4_MEMORY_USAGE 14
+#ifndef LZ4_MEMORY_USAGE
+# define LZ4_MEMORY_USAGE 14
+#endif
 
 
 /*-************************************
 *  Simple Functions
 **************************************/
 /*! LZ4_compress_default() :
-    Compresses 'sourceSize' bytes from buffer 'source'
-    into already allocated 'dest' buffer of size 'maxDestSize'.
-    Compression is guaranteed to succeed if 'maxDestSize' >= LZ4_compressBound(sourceSize).
-    It also runs faster, so it's a recommended setting.
-    If the function cannot compress 'source' into a more limited 'dest' budget,
-    compression stops *immediately*, and the function result is zero.
-    As a consequence, 'dest' content is not valid.
-    This function never writes outside 'dest' buffer, nor read outside 'source' buffer.
-        sourceSize  : Max supported value is LZ4_MAX_INPUT_VALUE
-        maxDestSize : full or partial size of buffer 'dest' (which must be already allocated)
-        return : the number of bytes written into buffer 'dest' (necessarily <= maxOutputSize)
-              or 0 if compression fails */
-LZ4LIB_API int LZ4_compress_default(const char* source, char* dest, int sourceSize, int maxDestSize);
+ *  Compresses 'srcSize' bytes from buffer 'src'
+ *  into already allocated 'dst' buffer of size 'dstCapacity'.
+ *  Compression is guaranteed to succeed if 'dstCapacity' >= LZ4_compressBound(srcSize).
+ *  It also runs faster, so it's a recommended setting.
+ *  If the function cannot compress 'src' into a more limited 'dst' budget,
+ *  compression stops *immediately*, and the function result is zero.
+ *  In which case, 'dst' content is undefined (invalid).
+ *      srcSize : max supported value is LZ4_MAX_INPUT_SIZE.
+ *      dstCapacity : size of buffer 'dst' (which must be already allocated)
+ *     @return  : the number of bytes written into buffer 'dst' (necessarily <= dstCapacity)
+ *                or 0 if compression fails
+ * Note : This function is protected against buffer overflow scenarios (never writes outside 'dst' buffer, nor read outside 'source' buffer).
+ */
+LZ4LIB_API int LZ4_compress_default(const char* src, char* dst, int srcSize, int dstCapacity);
 
 /*! LZ4_decompress_safe() :
-    compressedSize : is the precise full size of the compressed block.
-    maxDecompressedSize : is the size of destination buffer, which must be already allocated.
-    return : the number of bytes decompressed into destination buffer (necessarily <= maxDecompressedSize)
-             If destination buffer is not large enough, decoding will stop and output an error code (<0).
-             If the source stream is detected malformed, the function will stop decoding and return a negative result.
-             This function is protected against buffer overflow exploits, including malicious data packets.
-             It never writes outside output buffer, nor reads outside input buffer.
-*/
-LZ4LIB_API int LZ4_decompress_safe (const char* source, char* dest, int compressedSize, int maxDecompressedSize);
+ *  compressedSize : is the exact complete size of the compressed block.
+ *  dstCapacity : is the size of destination buffer (which must be already allocated), presumed an upper bound of decompressed size.
+ * @return : the number of bytes decompressed into destination buffer (necessarily <= dstCapacity)
+ *           If destination buffer is not large enough, decoding will stop and output an error code (negative value).
+ *           If the source stream is detected malformed, the function will stop decoding and return a negative result.
+ * Note 1 : This function is protected against malicious data packets :
+ *          it will never writes outside 'dst' buffer, nor read outside 'source' buffer,
+ *          even if the compressed block is maliciously modified to order the decoder to do these actions.
+ *          In such case, the decoder stops immediately, and considers the compressed block malformed.
+ * Note 2 : compressedSize and dstCapacity must be provided to the function, the compressed block does not contain them.
+ *          The implementation is free to send / store / derive this information in whichever way is most beneficial.
+ *          If there is a need for a different format which bundles together both compressed data and its metadata, consider looking at lz4frame.h instead.
+ */
+LZ4LIB_API int LZ4_decompress_safe (const char* src, char* dst, int compressedSize, int dstCapacity);
 
 
 /*-************************************
@@ -147,184 +170,389 @@ LZ4LIB_API int LZ4_decompress_safe (const char* source, char* dest, int compress
 #define LZ4_MAX_INPUT_SIZE        0x7E000000   /* 2 113 929 216 bytes */
 #define LZ4_COMPRESSBOUND(isize)  ((unsigned)(isize) > (unsigned)LZ4_MAX_INPUT_SIZE ? 0 : (isize) + ((isize)/255) + 16)
 
-/*!
-LZ4_compressBound() :
+/*! LZ4_compressBound() :
     Provides the maximum size that LZ4 compression may output in a "worst case" scenario (input data not compressible)
     This function is primarily useful for memory allocation purposes (destination buffer size).
     Macro LZ4_COMPRESSBOUND() is also provided for compilation-time evaluation (stack memory allocation for example).
-    Note that LZ4_compress_default() compress faster when dest buffer size is >= LZ4_compressBound(srcSize)
+    Note that LZ4_compress_default() compresses faster when dstCapacity is >= LZ4_compressBound(srcSize)
         inputSize  : max supported value is LZ4_MAX_INPUT_SIZE
         return : maximum output size in a "worst case" scenario
-              or 0, if input size is too large ( > LZ4_MAX_INPUT_SIZE)
+              or 0, if input size is incorrect (too large or negative)
 */
 LZ4LIB_API int LZ4_compressBound(int inputSize);
 
-/*!
-LZ4_compress_fast() :
-    Same as LZ4_compress_default(), but allows to select an "acceleration" factor.
+/*! LZ4_compress_fast() :
+    Same as LZ4_compress_default(), but allows selection of "acceleration" factor.
     The larger the acceleration value, the faster the algorithm, but also the lesser the compression.
     It's a trade-off. It can be fine tuned, with each successive value providing roughly +~3% to speed.
     An acceleration value of "1" is the same as regular LZ4_compress_default()
-    Values <= 0 will be replaced by ACCELERATION_DEFAULT (see lz4.c), which is 1.
+    Values <= 0 will be replaced by ACCELERATION_DEFAULT (currently == 1, see lz4.c).
 */
-LZ4LIB_API int LZ4_compress_fast (const char* source, char* dest, int sourceSize, int maxDestSize, int acceleration);
+LZ4LIB_API int LZ4_compress_fast (const char* src, char* dst, int srcSize, int dstCapacity, int acceleration);
 
 
-/*!
-LZ4_compress_fast_extState() :
-    Same compression function, just using an externally allocated memory space to store compression state.
-    Use LZ4_sizeofState() to know how much memory must be allocated,
-    and allocate it on 8-bytes boundaries (using malloc() typically).
-    Then, provide it as 'void* state' to compression function.
-*/
+/*! LZ4_compress_fast_extState() :
+ *  Same as LZ4_compress_fast(), using an externally allocated memory space for its state.
+ *  Use LZ4_sizeofState() to know how much memory must be allocated,
+ *  and allocate it on 8-bytes boundaries (using `malloc()` typically).
+ *  Then, provide this buffer as `void* state` to compression function.
+ */
 LZ4LIB_API int LZ4_sizeofState(void);
-LZ4LIB_API int LZ4_compress_fast_extState (void* state, const char* source, char* dest, int inputSize, int maxDestSize, int acceleration);
+LZ4LIB_API int LZ4_compress_fast_extState (void* state, const char* src, char* dst, int srcSize, int dstCapacity, int acceleration);
 
 
-/*!
-LZ4_compress_destSize() :
-    Reverse the logic, by compressing as much data as possible from 'source' buffer
-    into already allocated buffer 'dest' of size 'targetDestSize'.
-    This function either compresses the entire 'source' content into 'dest' if it's large enough,
-    or fill 'dest' buffer completely with as much data as possible from 'source'.
-        *sourceSizePtr : will be modified to indicate how many bytes where read from 'source' to fill 'dest'.
-                         New value is necessarily <= old value.
-        return : Nb bytes written into 'dest' (necessarily <= targetDestSize)
-              or 0 if compression fails
+/*! LZ4_compress_destSize() :
+ *  Reverse the logic : compresses as much data as possible from 'src' buffer
+ *  into already allocated buffer 'dst', of size >= 'targetDestSize'.
+ *  This function either compresses the entire 'src' content into 'dst' if it's large enough,
+ *  or fill 'dst' buffer completely with as much data as possible from 'src'.
+ *  note: acceleration parameter is fixed to "default".
+ *
+ * *srcSizePtr : will be modified to indicate how many bytes where read from 'src' to fill 'dst'.
+ *               New value is necessarily <= input value.
+ * @return : Nb bytes written into 'dst' (necessarily <= targetDestSize)
+ *           or 0 if compression fails.
 */
-LZ4LIB_API int LZ4_compress_destSize (const char* source, char* dest, int* sourceSizePtr, int targetDestSize);
+LZ4LIB_API int LZ4_compress_destSize (const char* src, char* dst, int* srcSizePtr, int targetDstSize);
 
 
-/*!
-LZ4_decompress_fast() :
-    originalSize : is the original and therefore uncompressed size
-    return : the number of bytes read from the source buffer (in other words, the compressed size)
-             If the source stream is detected malformed, the function will stop decoding and return a negative result.
-             Destination buffer must be already allocated. Its size must be a minimum of 'originalSize' bytes.
-    note : This function fully respect memory boundaries for properly formed compressed data.
-           It is a bit faster than LZ4_decompress_safe().
-           However, it does not provide any protection against intentionally modified data stream (malicious input).
-           Use this function in trusted environment only (data to decode comes from a trusted source).
-*/
-LZ4LIB_API int LZ4_decompress_fast (const char* source, char* dest, int originalSize);
-
-/*!
-LZ4_decompress_safe_partial() :
-    This function decompress a compressed block of size 'compressedSize' at position 'source'
-    into destination buffer 'dest' of size 'maxDecompressedSize'.
-    The function tries to stop decompressing operation as soon as 'targetOutputSize' has been reached,
-    reducing decompression time.
-    return : the number of bytes decoded in the destination buffer (necessarily <= maxDecompressedSize)
-       Note : this number can be < 'targetOutputSize' should the compressed block to decode be smaller.
-             Always control how many bytes were decoded.
-             If the source stream is detected malformed, the function will stop decoding and return a negative result.
-             This function never writes outside of output buffer, and never reads outside of input buffer. It is therefore protected against malicious data packets
-*/
-LZ4LIB_API int LZ4_decompress_safe_partial (const char* source, char* dest, int compressedSize, int targetOutputSize, int maxDecompressedSize);
+/*! LZ4_decompress_safe_partial() :
+ *  Decompress an LZ4 compressed block, of size 'srcSize' at position 'src',
+ *  into destination buffer 'dst' of size 'dstCapacity'.
+ *  Up to 'targetOutputSize' bytes will be decoded.
+ *  The function stops decoding on reaching this objective,
+ *  which can boost performance when only the beginning of a block is required.
+ *
+ * @return : the number of bytes decoded in `dst` (necessarily <= dstCapacity)
+ *           If source stream is detected malformed, function returns a negative result.
+ *
+ *  Note : @return can be < targetOutputSize, if compressed block contains less data.
+ *
+ *  Note 2 : this function features 2 parameters, targetOutputSize and dstCapacity,
+ *           and expects targetOutputSize <= dstCapacity.
+ *           It effectively stops decoding on reaching targetOutputSize,
+ *           so dstCapacity is kind of redundant.
+ *           This is because in a previous version of this function,
+ *           decoding operation would not "break" a sequence in the middle.
+ *           As a consequence, there was no guarantee that decoding would stop at exactly targetOutputSize,
+ *           it could write more bytes, though only up to dstCapacity.
+ *           Some "margin" used to be required for this operation to work properly.
+ *           This is no longer necessary.
+ *           The function nonetheless keeps its signature, in an effort to not break API.
+ */
+LZ4LIB_API int LZ4_decompress_safe_partial (const char* src, char* dst, int srcSize, int targetOutputSize, int dstCapacity);
 
 
 /*-*********************************************
 *  Streaming Compression Functions
 ***********************************************/
-typedef union LZ4_stream_u LZ4_stream_t;   /* incomplete type (defined later) */
+typedef union LZ4_stream_u LZ4_stream_t;  /* incomplete type (defined later) */
 
-/*! LZ4_createStream() and LZ4_freeStream() :
- *  LZ4_createStream() will allocate and initialize an `LZ4_stream_t` structure.
- *  LZ4_freeStream() releases its memory.
- */
 LZ4LIB_API LZ4_stream_t* LZ4_createStream(void);
 LZ4LIB_API int           LZ4_freeStream (LZ4_stream_t* streamPtr);
 
-/*! LZ4_resetStream() :
- *  An LZ4_stream_t structure can be allocated once and re-used multiple times.
- *  Use this function to init an allocated `LZ4_stream_t` structure and start a new compression.
+/*! LZ4_resetStream_fast() : v1.9.0+
+ *  Use this to prepare an LZ4_stream_t for a new chain of dependent blocks
+ *  (e.g., LZ4_compress_fast_continue()).
+ *
+ *  An LZ4_stream_t must be initialized once before usage.
+ *  This is automatically done when created by LZ4_createStream().
+ *  However, should the LZ4_stream_t be simply declared on stack (for example),
+ *  it's necessary to initialize it first, using LZ4_initStream().
+ *
+ *  After init, start any new stream with LZ4_resetStream_fast().
+ *  A same LZ4_stream_t can be re-used multiple times consecutively
+ *  and compress multiple streams,
+ *  provided that it starts each new stream with LZ4_resetStream_fast().
+ *
+ *  LZ4_resetStream_fast() is much faster than LZ4_initStream(),
+ *  but is not compatible with memory regions containing garbage data.
+ *
+ *  Note: it's only useful to call LZ4_resetStream_fast()
+ *        in the context of streaming compression.
+ *        The *extState* functions perform their own resets.
+ *        Invoking LZ4_resetStream_fast() before is redundant, and even counterproductive.
  */
-LZ4LIB_API void LZ4_resetStream (LZ4_stream_t* streamPtr);
+LZ4LIB_API void LZ4_resetStream_fast (LZ4_stream_t* streamPtr);
 
 /*! LZ4_loadDict() :
- *  Use this function to load a static dictionary into LZ4_stream.
- *  Any previous data will be forgotten, only 'dictionary' will remain in memory.
- *  Loading a size of 0 is allowed.
- *  Return : dictionary size, in bytes (necessarily <= 64 KB)
+ *  Use this function to reference a static dictionary into LZ4_stream_t.
+ *  The dictionary must remain available during compression.
+ *  LZ4_loadDict() triggers a reset, so any previous data will be forgotten.
+ *  The same dictionary will have to be loaded on decompression side for successful decoding.
+ *  Dictionary are useful for better compression of small data (KB range).
+ *  While LZ4 accept any input as dictionary,
+ *  results are generally better when using Zstandard's Dictionary Builder.
+ *  Loading a size of 0 is allowed, and is the same as reset.
+ * @return : loaded dictionary size, in bytes (necessarily <= 64 KB)
  */
 LZ4LIB_API int LZ4_loadDict (LZ4_stream_t* streamPtr, const char* dictionary, int dictSize);
 
 /*! LZ4_compress_fast_continue() :
- *  Compress buffer content 'src', using data from previously compressed blocks as dictionary to improve compression ratio.
- *  Important : Previous data blocks are assumed to still be present and unmodified !
- *  'dst' buffer must be already allocated.
- *  If maxDstSize >= LZ4_compressBound(srcSize), compression is guaranteed to succeed, and runs faster.
- *  If not, and if compressed data cannot fit into 'dst' buffer size, compression stops, and function returns a zero.
+ *  Compress 'src' content using data from previously compressed blocks, for better compression ratio.
+ * 'dst' buffer must be already allocated.
+ *  If dstCapacity >= LZ4_compressBound(srcSize), compression is guaranteed to succeed, and runs faster.
+ *
+ * @return : size of compressed block
+ *           or 0 if there is an error (typically, cannot fit into 'dst').
+ *
+ *  Note 1 : Each invocation to LZ4_compress_fast_continue() generates a new block.
+ *           Each block has precise boundaries.
+ *           Each block must be decompressed separately, calling LZ4_decompress_*() with relevant metadata.
+ *           It's not possible to append blocks together and expect a single invocation of LZ4_decompress_*() to decompress them together.
+ *
+ *  Note 2 : The previous 64KB of source data is __assumed__ to remain present, unmodified, at same address in memory !
+ *
+ *  Note 3 : When input is structured as a double-buffer, each buffer can have any size, including < 64 KB.
+ *           Make sure that buffers are separated, by at least one byte.
+ *           This construction ensures that each block only depends on previous block.
+ *
+ *  Note 4 : If input buffer is a ring-buffer, it can have any size, including < 64 KB.
+ *
+ *  Note 5 : After an error, the stream status is undefined (invalid), it can only be reset or freed.
  */
-LZ4LIB_API int LZ4_compress_fast_continue (LZ4_stream_t* streamPtr, const char* src, char* dst, int srcSize, int maxDstSize, int acceleration);
+LZ4LIB_API int LZ4_compress_fast_continue (LZ4_stream_t* streamPtr, const char* src, char* dst, int srcSize, int dstCapacity, int acceleration);
 
 /*! LZ4_saveDict() :
- *  If previously compressed data block is not guaranteed to remain available at its memory location,
+ *  If last 64KB data cannot be guaranteed to remain available at its current memory location,
  *  save it into a safer place (char* safeBuffer).
- *  Note : you don't need to call LZ4_loadDict() afterwards,
- *         dictionary is immediately usable, you can therefore call LZ4_compress_fast_continue().
- *  Return : saved dictionary size in bytes (necessarily <= dictSize), or 0 if error.
+ *  This is schematically equivalent to a memcpy() followed by LZ4_loadDict(),
+ *  but is much faster, because LZ4_saveDict() doesn't need to rebuild tables.
+ * @return : saved dictionary size in bytes (necessarily <= maxDictSize), or 0 if error.
  */
-LZ4LIB_API int LZ4_saveDict (LZ4_stream_t* streamPtr, char* safeBuffer, int dictSize);
+LZ4LIB_API int LZ4_saveDict (LZ4_stream_t* streamPtr, char* safeBuffer, int maxDictSize);
 
 
 /*-**********************************************
 *  Streaming Decompression Functions
 *  Bufferless synchronous API
 ************************************************/
-typedef union LZ4_streamDecode_u LZ4_streamDecode_t;   /* incomplete type (defined later) */
+typedef union LZ4_streamDecode_u LZ4_streamDecode_t;   /* tracking context */
 
-/* creation / destruction of streaming decompression tracking structure */
+/*! LZ4_createStreamDecode() and LZ4_freeStreamDecode() :
+ *  creation / destruction of streaming decompression tracking context.
+ *  A tracking context can be re-used multiple times.
+ */
 LZ4LIB_API LZ4_streamDecode_t* LZ4_createStreamDecode(void);
 LZ4LIB_API int                 LZ4_freeStreamDecode (LZ4_streamDecode_t* LZ4_stream);
 
 /*! LZ4_setStreamDecode() :
- *  Use this function to instruct where to find the dictionary.
- *  Setting a size of 0 is allowed (same effect as reset).
- *  @return : 1 if OK, 0 if error
+ *  An LZ4_streamDecode_t context can be allocated once and re-used multiple times.
+ *  Use this function to start decompression of a new stream of blocks.
+ *  A dictionary can optionally be set. Use NULL or size 0 for a reset order.
+ *  Dictionary is presumed stable : it must remain accessible and unmodified during next decompression.
+ * @return : 1 if OK, 0 if error
  */
 LZ4LIB_API int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dictionary, int dictSize);
 
-/*!
-LZ4_decompress_*_continue() :
-    These decoding functions allow decompression of multiple blocks in "streaming" mode.
-    Previously decoded blocks *must* remain available at the memory position where they were decoded (up to 64 KB)
-    In the case of a ring buffers, decoding buffer must be either :
-    - Exactly same size as encoding buffer, with same update rule (block boundaries at same positions)
-      In which case, the decoding & encoding ring buffer can have any size, including very small ones ( < 64 KB).
-    - Larger than encoding buffer, by a minimum of maxBlockSize more bytes.
-      maxBlockSize is implementation dependent. It's the maximum size you intend to compress into a single block.
-      In which case, encoding and decoding buffers do not need to be synchronized,
-      and encoding ring buffer can have any size, including small ones ( < 64 KB).
-    - _At least_ 64 KB + 8 bytes + maxBlockSize.
-      In which case, encoding and decoding buffers do not need to be synchronized,
-      and encoding ring buffer can have any size, including larger than decoding buffer.
-    Whenever these conditions are not possible, save the last 64KB of decoded data into a safe buffer,
-    and indicate where it is saved using LZ4_setStreamDecode()
+/*! LZ4_decoderRingBufferSize() : v1.8.2+
+ *  Note : in a ring buffer scenario (optional),
+ *  blocks are presumed decompressed next to each other
+ *  up to the moment there is not enough remaining space for next block (remainingSize < maxBlockSize),
+ *  at which stage it resumes from beginning of ring buffer.
+ *  When setting such a ring buffer for streaming decompression,
+ *  provides the minimum size of this ring buffer
+ *  to be compatible with any source respecting maxBlockSize condition.
+ * @return : minimum ring buffer size,
+ *           or 0 if there is an error (invalid maxBlockSize).
+ */
+LZ4LIB_API int LZ4_decoderRingBufferSize(int maxBlockSize);
+#define LZ4_DECODER_RING_BUFFER_SIZE(maxBlockSize) (65536 + 14 + (maxBlockSize))  /* for static allocation; maxBlockSize presumed valid */
+
+/*! LZ4_decompress_*_continue() :
+ *  These decoding functions allow decompression of consecutive blocks in "streaming" mode.
+ *  A block is an unsplittable entity, it must be presented entirely to a decompression function.
+ *  Decompression functions only accepts one block at a time.
+ *  The last 64KB of previously decoded data *must* remain available and unmodified at the memory position where they were decoded.
+ *  If less than 64KB of data has been decoded, all the data must be present.
+ *
+ *  Special : if decompression side sets a ring buffer, it must respect one of the following conditions :
+ *  - Decompression buffer size is _at least_ LZ4_decoderRingBufferSize(maxBlockSize).
+ *    maxBlockSize is the maximum size of any single block. It can have any value > 16 bytes.
+ *    In which case, encoding and decoding buffers do not need to be synchronized.
+ *    Actually, data can be produced by any source compliant with LZ4 format specification, and respecting maxBlockSize.
+ *  - Synchronized mode :
+ *    Decompression buffer size is _exactly_ the same as compression buffer size,
+ *    and follows exactly same update rule (block boundaries at same positions),
+ *    and decoding function is provided with exact decompressed size of each block (exception for last block of the stream),
+ *    _then_ decoding & encoding ring buffer can have any size, including small ones ( < 64 KB).
+ *  - Decompression buffer is larger than encoding buffer, by a minimum of maxBlockSize more bytes.
+ *    In which case, encoding and decoding buffers do not need to be synchronized,
+ *    and encoding ring buffer can have any size, including small ones ( < 64 KB).
+ *
+ *  Whenever these conditions are not possible,
+ *  save the last 64KB of decoded data into a safe buffer where it can't be modified during decompression,
+ *  then indicate where this data is saved using LZ4_setStreamDecode(), before decompressing next block.
 */
-LZ4LIB_API int LZ4_decompress_safe_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int compressedSize, int maxDecompressedSize);
-LZ4LIB_API int LZ4_decompress_fast_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int originalSize);
+LZ4LIB_API int LZ4_decompress_safe_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* src, char* dst, int srcSize, int dstCapacity);
 
 
 /*! LZ4_decompress_*_usingDict() :
  *  These decoding functions work the same as
  *  a combination of LZ4_setStreamDecode() followed by LZ4_decompress_*_continue()
  *  They are stand-alone, and don't need an LZ4_streamDecode_t structure.
+ *  Dictionary is presumed stable : it must remain accessible and unmodified during decompression.
+ *  Performance tip : Decompression speed can be substantially increased
+ *                    when dst == dictStart + dictSize.
  */
-LZ4LIB_API int LZ4_decompress_safe_usingDict (const char* source, char* dest, int compressedSize, int maxDecompressedSize, const char* dictStart, int dictSize);
-LZ4LIB_API int LZ4_decompress_fast_usingDict (const char* source, char* dest, int originalSize, const char* dictStart, int dictSize);
+LZ4LIB_API int LZ4_decompress_safe_usingDict (const char* src, char* dst, int srcSize, int dstCapcity, const char* dictStart, int dictSize);
 
+#endif /* LZ4_H_2983827168210 */
 
-/*^**********************************************
+
+/*^*************************************
  * !!!!!!   STATIC LINKING ONLY   !!!!!!
- ***********************************************/
-/*-************************************
- *  Private definitions
- **************************************
- * Do not use these definitions.
- * They are exposed to allow static allocation of `LZ4_stream_t` and `LZ4_streamDecode_t`.
- * Using these definitions will expose code to API and/or ABI break in future versions of the library.
- **************************************/
+ ***************************************/
+
+/*-****************************************************************************
+ * Experimental section
+ *
+ * Symbols declared in this section must be considered unstable. Their
+ * signatures or semantics may change, or they may be removed altogether in the
+ * future. They are therefore only safe to depend on when the caller is
+ * statically linked against the library.
+ *
+ * To protect against unsafe usage, not only are the declarations guarded,
+ * the definitions are hidden by default
+ * when building LZ4 as a shared/dynamic library.
+ *
+ * In order to access these declarations,
+ * define LZ4_STATIC_LINKING_ONLY in your application
+ * before including LZ4's headers.
+ *
+ * In order to make their implementations accessible dynamically, you must
+ * define LZ4_PUBLISH_STATIC_FUNCTIONS when building the LZ4 library.
+ ******************************************************************************/
+
+#ifdef LZ4_STATIC_LINKING_ONLY
+
+#ifndef LZ4_STATIC_3504398509
+#define LZ4_STATIC_3504398509
+
+#ifdef LZ4_PUBLISH_STATIC_FUNCTIONS
+#define LZ4LIB_STATIC_API LZ4LIB_API
+#else
+#define LZ4LIB_STATIC_API
+#endif
+
+
+/*! LZ4_compress_fast_extState_fastReset() :
+ *  A variant of LZ4_compress_fast_extState().
+ *
+ *  Using this variant avoids an expensive initialization step.
+ *  It is only safe to call if the state buffer is known to be correctly initialized already
+ *  (see above comment on LZ4_resetStream_fast() for a definition of "correctly initialized").
+ *  From a high level, the difference is that
+ *  this function initializes the provided state with a call to something like LZ4_resetStream_fast()
+ *  while LZ4_compress_fast_extState() starts with a call to LZ4_resetStream().
+ */
+LZ4LIB_STATIC_API int LZ4_compress_fast_extState_fastReset (void* state, const char* src, char* dst, int srcSize, int dstCapacity, int acceleration);
+
+/*! LZ4_attach_dictionary() :
+ *  This is an experimental API that allows
+ *  efficient use of a static dictionary many times.
+ *
+ *  Rather than re-loading the dictionary buffer into a working context before
+ *  each compression, or copying a pre-loaded dictionary's LZ4_stream_t into a
+ *  working LZ4_stream_t, this function introduces a no-copy setup mechanism,
+ *  in which the working stream references the dictionary stream in-place.
+ *
+ *  Several assumptions are made about the state of the dictionary stream.
+ *  Currently, only streams which have been prepared by LZ4_loadDict() should
+ *  be expected to work.
+ *
+ *  Alternatively, the provided dictionaryStream may be NULL,
+ *  in which case any existing dictionary stream is unset.
+ *
+ *  If a dictionary is provided, it replaces any pre-existing stream history.
+ *  The dictionary contents are the only history that can be referenced and
+ *  logically immediately precede the data compressed in the first subsequent
+ *  compression call.
+ *
+ *  The dictionary will only remain attached to the working stream through the
+ *  first compression call, at the end of which it is cleared. The dictionary
+ *  stream (and source buffer) must remain in-place / accessible / unchanged
+ *  through the completion of the first compression call on the stream.
+ */
+LZ4LIB_STATIC_API void LZ4_attach_dictionary(LZ4_stream_t* workingStream, const LZ4_stream_t* dictionaryStream);
+
+
+/*! In-place compression and decompression
+ *
+ * It's possible to have input and output sharing the same buffer,
+ * for highly contrained memory environments.
+ * In both cases, it requires input to lay at the end of the buffer,
+ * and decompression to start at beginning of the buffer.
+ * Buffer size must feature some margin, hence be larger than final size.
+ *
+ * |<------------------------buffer--------------------------------->|
+ *                             |<-----------compressed data--------->|
+ * |<-----------decompressed size------------------>|
+ *                                                  |<----margin---->|
+ *
+ * This technique is more useful for decompression,
+ * since decompressed size is typically larger,
+ * and margin is short.
+ *
+ * In-place decompression will work inside any buffer
+ * which size is >= LZ4_DECOMPRESS_INPLACE_BUFFER_SIZE(decompressedSize).
+ * This presumes that decompressedSize > compressedSize.
+ * Otherwise, it means compression actually expanded data,
+ * and it would be more efficient to store such data with a flag indicating it's not compressed.
+ * This can happen when data is not compressible (already compressed, or encrypted).
+ *
+ * For in-place compression, margin is larger, as it must be able to cope with both
+ * history preservation, requiring input data to remain unmodified up to LZ4_DISTANCE_MAX,
+ * and data expansion, which can happen when input is not compressible.
+ * As a consequence, buffer size requirements are much higher,
+ * and memory savings offered by in-place compression are more limited.
+ *
+ * There are ways to limit this cost for compression :
+ * - Reduce history size, by modifying LZ4_DISTANCE_MAX.
+ *   Note that it is a compile-time constant, so all compressions will apply this limit.
+ *   Lower values will reduce compression ratio, except when input_size < LZ4_DISTANCE_MAX,
+ *   so it's a reasonable trick when inputs are known to be small.
+ * - Require the compressor to deliver a "maximum compressed size".
+ *   This is the `dstCapacity` parameter in `LZ4_compress*()`.
+ *   When this size is < LZ4_COMPRESSBOUND(inputSize), then compression can fail,
+ *   in which case, the return code will be 0 (zero).
+ *   The caller must be ready for these cases to happen,
+ *   and typically design a backup scheme to send data uncompressed.
+ * The combination of both techniques can significantly reduce
+ * the amount of margin required for in-place compression.
+ *
+ * In-place compression can work in any buffer
+ * which size is >= (maxCompressedSize)
+ * with maxCompressedSize == LZ4_COMPRESSBOUND(srcSize) for guaranteed compression success.
+ * LZ4_COMPRESS_INPLACE_BUFFER_SIZE() depends on both maxCompressedSize and LZ4_DISTANCE_MAX,
+ * so it's possible to reduce memory requirements by playing with them.
+ */
+
+#define LZ4_DECOMPRESS_INPLACE_MARGIN(compressedSize)          (((compressedSize) >> 8) + 32)
+#define LZ4_DECOMPRESS_INPLACE_BUFFER_SIZE(decompressedSize)   ((decompressedSize) + LZ4_DECOMPRESS_INPLACE_MARGIN(decompressedSize))  /**< note: presumes that compressedSize < decompressedSize. note2: margin is overestimated a bit, since it could use compressedSize instead */
+
+#ifndef LZ4_DISTANCE_MAX   /* history window size; can be user-defined at compile time */
+#  define LZ4_DISTANCE_MAX 65535   /* set to maximum value by default */
+#endif
+
+#define LZ4_COMPRESS_INPLACE_MARGIN                           (LZ4_DISTANCE_MAX + 32)   /* LZ4_DISTANCE_MAX can be safely replaced by srcSize when it's smaller */
+#define LZ4_COMPRESS_INPLACE_BUFFER_SIZE(maxCompressedSize)   ((maxCompressedSize) + LZ4_COMPRESS_INPLACE_MARGIN)  /**< maxCompressedSize is generally LZ4_COMPRESSBOUND(inputSize), but can be set to any lower value, with the risk that compression can fail (return code 0(zero)) */
+
+#endif   /* LZ4_STATIC_3504398509 */
+#endif   /* LZ4_STATIC_LINKING_ONLY */
+
+
+
+#ifndef LZ4_H_98237428734687
+#define LZ4_H_98237428734687
+
+/*-************************************************************
+ *  PRIVATE DEFINITIONS
+ **************************************************************
+ * Do not use these definitions directly.
+ * They are only exposed to allow static allocation of `LZ4_stream_t` and `LZ4_streamDecode_t`.
+ * Accessing members will expose code to API and/or ABI break in future versions of the library.
+ **************************************************************/
 #define LZ4_HASHLOG   (LZ4_MEMORY_USAGE-2)
 #define LZ4_HASHTABLESIZE (1 << LZ4_MEMORY_USAGE)
 #define LZ4_HASH_SIZE_U32 (1 << LZ4_HASHLOG)       /* required as macro for static allocation */
@@ -332,14 +560,16 @@ LZ4LIB_API int LZ4_decompress_fast_usingDict (const char* source, char* dest, in
 #if defined(__cplusplus) || (defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) /* C99 */)
 #include <stdint.h>
 
-typedef struct {
+typedef struct LZ4_stream_t_internal LZ4_stream_t_internal;
+struct LZ4_stream_t_internal {
     uint32_t hashTable[LZ4_HASH_SIZE_U32];
     uint32_t currentOffset;
-    uint32_t initCheck;
+    uint16_t dirty;
+    uint16_t tableType;
     const uint8_t* dictionary;
-    uint8_t* bufferStart;   /* obsolete, used for slideInputBuffer */
+    const LZ4_stream_t_internal* dictCtx;
     uint32_t dictSize;
-} LZ4_stream_t_internal;
+};
 
 typedef struct {
     const uint8_t* externalDict;
@@ -350,49 +580,67 @@ typedef struct {
 
 #else
 
-typedef struct {
+typedef struct LZ4_stream_t_internal LZ4_stream_t_internal;
+struct LZ4_stream_t_internal {
     unsigned int hashTable[LZ4_HASH_SIZE_U32];
     unsigned int currentOffset;
-    unsigned int initCheck;
+    unsigned short dirty;
+    unsigned short tableType;
     const unsigned char* dictionary;
-    unsigned char* bufferStart;   /* obsolete, used for slideInputBuffer */
+    const LZ4_stream_t_internal* dictCtx;
     unsigned int dictSize;
-} LZ4_stream_t_internal;
+};
 
 typedef struct {
     const unsigned char* externalDict;
-    size_t extDictSize;
     const unsigned char* prefixEnd;
+    size_t extDictSize;
     size_t prefixSize;
 } LZ4_streamDecode_t_internal;
 
 #endif
 
-/*!
- * LZ4_stream_t :
- * information structure to track an LZ4 stream.
- * init this structure before first use.
- * note : only use in association with static linking !
- *        this definition is not API/ABI safe,
- *        and may change in a future version !
+/*! LZ4_stream_t :
+ *  information structure to track an LZ4 stream.
+ *  LZ4_stream_t can also be created using LZ4_createStream(), which is recommended.
+ *  The structure definition can be convenient for static allocation
+ *  (on stack, or as part of larger structure).
+ *  Init this structure with LZ4_initStream() before first use.
+ *  note : only use this definition in association with static linking !
+ *    this definition is not API/ABI safe, and may change in a future version.
  */
-#define LZ4_STREAMSIZE_U64 ((1 << (LZ4_MEMORY_USAGE-3)) + 4)
+#define LZ4_STREAMSIZE_U64 ((1 << (LZ4_MEMORY_USAGE-3)) + 4 + ((sizeof(void*)==16) ? 4 : 0) /*AS-400*/ )
 #define LZ4_STREAMSIZE     (LZ4_STREAMSIZE_U64 * sizeof(unsigned long long))
 union LZ4_stream_u {
     unsigned long long table[LZ4_STREAMSIZE_U64];
     LZ4_stream_t_internal internal_donotuse;
 } ;  /* previously typedef'd to LZ4_stream_t */
 
+/*! LZ4_initStream() : v1.9.0+
+ *  An LZ4_stream_t structure must be initialized at least once.
+ *  This is automatically done when invoking LZ4_createStream(),
+ *  but it's not when the structure is simply declared on stack (for example).
+ *
+ *  Use LZ4_initStream() to properly initialize a newly declared LZ4_stream_t.
+ *  It can also initialize any arbitrary buffer of sufficient size,
+ *  and will @return a pointer of proper type upon initialization.
+ *
+ *  Note : initialization fails if size and alignment conditions are not respected.
+ *         In which case, the function will @return NULL.
+ *  Note2: An LZ4_stream_t structure guarantees correct alignment and size.
+ *  Note3: Before v1.9.0, use LZ4_resetStream() instead
+ */
+LZ4LIB_API LZ4_stream_t* LZ4_initStream (void* buffer, size_t size);
+
 
-/*!
- * LZ4_streamDecode_t :
- * information structure to track an LZ4 stream during decompression.
- * init this structure  using LZ4_setStreamDecode (or memset()) before first use
- * note : only use in association with static linking !
- *        this definition is not API/ABI safe,
- *        and may change in a future version !
+/*! LZ4_streamDecode_t :
+ *  information structure to track an LZ4 stream during decompression.
+ *  init this structure  using LZ4_setStreamDecode() before first use.
+ *  note : only use in association with static linking !
+ *         this definition is not API/ABI safe,
+ *         and may change in a future version !
  */
-#define LZ4_STREAMDECODESIZE_U64  4
+#define LZ4_STREAMDECODESIZE_U64 (4 + ((sizeof(void*)==16) ? 2 : 0) /*AS-400*/ )
 #define LZ4_STREAMDECODESIZE     (LZ4_STREAMDECODESIZE_U64 * sizeof(unsigned long long))
 union LZ4_streamDecode_u {
     unsigned long long table[LZ4_STREAMDECODESIZE_U64];
@@ -400,15 +648,22 @@ union LZ4_streamDecode_u {
 } ;   /* previously typedef'd to LZ4_streamDecode_t */
 
 
-/*=************************************
+
+/*-************************************
 *  Obsolete Functions
 **************************************/
-/* Deprecation warnings */
-/* Should these warnings be a problem,
-   it is generally possible to disable them,
-   typically with -Wno-deprecated-declarations for gcc
-   or _CRT_SECURE_NO_WARNINGS in Visual.
-   Otherwise, it's also possible to define LZ4_DISABLE_DEPRECATE_WARNINGS */
+
+/*! Deprecation warnings
+ *
+ *  Deprecated functions make the compiler generate a warning when invoked.
+ *  This is meant to invite users to update their source code.
+ *  Should deprecation warnings be a problem, it is generally possible to disable them,
+ *  typically with -Wno-deprecated-declarations for gcc
+ *  or _CRT_SECURE_NO_WARNINGS in Visual.
+ *
+ *  Another method is to define LZ4_DISABLE_DEPRECATE_WARNINGS
+ *  before including the header file.
+ */
 #ifdef LZ4_DISABLE_DEPRECATE_WARNINGS
 #  define LZ4_DEPRECATED(message)   /* disable deprecation warnings */
 #else
@@ -428,36 +683,82 @@ union LZ4_streamDecode_u {
 #endif /* LZ4_DISABLE_DEPRECATE_WARNINGS */
 
 /* Obsolete compression functions */
-LZ4_DEPRECATED("use LZ4_compress_default() instead") int LZ4_compress               (const char* source, char* dest, int sourceSize);
-LZ4_DEPRECATED("use LZ4_compress_default() instead") int LZ4_compress_limitedOutput (const char* source, char* dest, int sourceSize, int maxOutputSize);
-LZ4_DEPRECATED("use LZ4_compress_fast_extState() instead") int LZ4_compress_withState               (void* state, const char* source, char* dest, int inputSize);
-LZ4_DEPRECATED("use LZ4_compress_fast_extState() instead") int LZ4_compress_limitedOutput_withState (void* state, const char* source, char* dest, int inputSize, int maxOutputSize);
-LZ4_DEPRECATED("use LZ4_compress_fast_continue() instead") int LZ4_compress_continue                (LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize);
-LZ4_DEPRECATED("use LZ4_compress_fast_continue() instead") int LZ4_compress_limitedOutput_continue  (LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize, int maxOutputSize);
+LZ4_DEPRECATED("use LZ4_compress_default() instead")       LZ4LIB_API int LZ4_compress               (const char* src, char* dest, int srcSize);
+LZ4_DEPRECATED("use LZ4_compress_default() instead")       LZ4LIB_API int LZ4_compress_limitedOutput (const char* src, char* dest, int srcSize, int maxOutputSize);
+LZ4_DEPRECATED("use LZ4_compress_fast_extState() instead") LZ4LIB_API int LZ4_compress_withState               (void* state, const char* source, char* dest, int inputSize);
+LZ4_DEPRECATED("use LZ4_compress_fast_extState() instead") LZ4LIB_API int LZ4_compress_limitedOutput_withState (void* state, const char* source, char* dest, int inputSize, int maxOutputSize);
+LZ4_DEPRECATED("use LZ4_compress_fast_continue() instead") LZ4LIB_API int LZ4_compress_continue                (LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize);
+LZ4_DEPRECATED("use LZ4_compress_fast_continue() instead") LZ4LIB_API int LZ4_compress_limitedOutput_continue  (LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize, int maxOutputSize);
 
 /* Obsolete decompression functions */
-/* These function names are completely deprecated and must no longer be used.
-   They are only provided in lz4.c for compatibility with older programs.
-    - LZ4_uncompress is the same as LZ4_decompress_fast
-    - LZ4_uncompress_unknownOutputSize is the same as LZ4_decompress_safe
-   These function prototypes are now disabled; uncomment them only if you really need them.
-   It is highly recommended to stop using these prototypes and migrate to maintained ones */
-/* int LZ4_uncompress (const char* source, char* dest, int outputSize); */
-/* int LZ4_uncompress_unknownOutputSize (const char* source, char* dest, int isize, int maxOutputSize); */
+LZ4_DEPRECATED("use LZ4_decompress_fast() instead") LZ4LIB_API int LZ4_uncompress (const char* source, char* dest, int outputSize);
+LZ4_DEPRECATED("use LZ4_decompress_safe() instead") LZ4LIB_API int LZ4_uncompress_unknownOutputSize (const char* source, char* dest, int isize, int maxOutputSize);
 
-/* Obsolete streaming functions; use new streaming interface whenever possible */
-LZ4_DEPRECATED("use LZ4_createStream() instead") void* LZ4_create (char* inputBuffer);
-LZ4_DEPRECATED("use LZ4_createStream() instead") int   LZ4_sizeofStreamState(void);
-LZ4_DEPRECATED("use LZ4_resetStream() instead")  int   LZ4_resetStreamState(void* state, char* inputBuffer);
-LZ4_DEPRECATED("use LZ4_saveDict() instead")     char* LZ4_slideInputBuffer (void* state);
+/* Obsolete streaming functions; degraded functionality; do not use!
+ *
+ * In order to perform streaming compression, these functions depended on data
+ * that is no longer tracked in the state. They have been preserved as well as
+ * possible: using them will still produce a correct output. However, they don't
+ * actually retain any history between compression calls. The compression ratio
+ * achieved will therefore be no better than compressing each chunk
+ * independently.
+ */
+LZ4_DEPRECATED("Use LZ4_createStream() instead") LZ4LIB_API void* LZ4_create (char* inputBuffer);
+LZ4_DEPRECATED("Use LZ4_createStream() instead") LZ4LIB_API int   LZ4_sizeofStreamState(void);
+LZ4_DEPRECATED("Use LZ4_resetStream() instead")  LZ4LIB_API int   LZ4_resetStreamState(void* state, char* inputBuffer);
+LZ4_DEPRECATED("Use LZ4_saveDict() instead")     LZ4LIB_API char* LZ4_slideInputBuffer (void* state);
 
 /* Obsolete streaming decoding functions */
-LZ4_DEPRECATED("use LZ4_decompress_safe_usingDict() instead") int LZ4_decompress_safe_withPrefix64k (const char* src, char* dst, int compressedSize, int maxDstSize);
-LZ4_DEPRECATED("use LZ4_decompress_fast_usingDict() instead") int LZ4_decompress_fast_withPrefix64k (const char* src, char* dst, int originalSize);
+LZ4_DEPRECATED("use LZ4_decompress_safe_usingDict() instead") LZ4LIB_API int LZ4_decompress_safe_withPrefix64k (const char* src, char* dst, int compressedSize, int maxDstSize);
+LZ4_DEPRECATED("use LZ4_decompress_fast_usingDict() instead") LZ4LIB_API int LZ4_decompress_fast_withPrefix64k (const char* src, char* dst, int originalSize);
+
+/*! LZ4_decompress_fast() : **unsafe!**
+ *  These functions used to be faster than LZ4_decompress_safe(),
+ *  but it has changed, and they are now slower than LZ4_decompress_safe().
+ *  This is because LZ4_decompress_fast() doesn't know the input size,
+ *  and therefore must progress more cautiously in the input buffer to not read beyond the end of block.
+ *  On top of that `LZ4_decompress_fast()` is not protected vs malformed or malicious inputs, making it a security liability.
+ *  As a consequence, LZ4_decompress_fast() is strongly discouraged, and deprecated.
+ *
+ *  The last remaining LZ4_decompress_fast() specificity is that
+ *  it can decompress a block without knowing its compressed size.
+ *  Such functionality could be achieved in a more secure manner,
+ *  by also providing the maximum size of input buffer,
+ *  but it would require new prototypes, and adaptation of the implementation to this new use case.
+ *
+ *  Parameters:
+ *  originalSize : is the uncompressed size to regenerate.
+ *                 `dst` must be already allocated, its size must be >= 'originalSize' bytes.
+ * @return : number of bytes read from source buffer (== compressed size).
+ *           The function expects to finish at block's end exactly.
+ *           If the source stream is detected malformed, the function stops decoding and returns a negative result.
+ *  note : LZ4_decompress_fast*() requires originalSize. Thanks to this information, it never writes past the output buffer.
+ *         However, since it doesn't know its 'src' size, it may read an unknown amount of input, past input buffer bounds.
+ *         Also, since match offsets are not validated, match reads from 'src' may underflow too.
+ *         These issues never happen if input (compressed) data is correct.
+ *         But they may happen if input data is invalid (error or intentional tampering).
+ *         As a consequence, use these functions in trusted environments with trusted data **only**.
+ */
+
+LZ4_DEPRECATED("This function is deprecated and unsafe. Consider using LZ4_decompress_safe() instead")
+LZ4LIB_API int LZ4_decompress_fast (const char* src, char* dst, int originalSize);
+LZ4_DEPRECATED("This function is deprecated and unsafe. Consider using LZ4_decompress_safe_continue() instead")
+LZ4LIB_API int LZ4_decompress_fast_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* src, char* dst, int originalSize);
+LZ4_DEPRECATED("This function is deprecated and unsafe. Consider using LZ4_decompress_safe_usingDict() instead")
+LZ4LIB_API int LZ4_decompress_fast_usingDict (const char* src, char* dst, int originalSize, const char* dictStart, int dictSize);
+
+/*! LZ4_resetStream() :
+ *  An LZ4_stream_t structure must be initialized at least once.
+ *  This is done with LZ4_initStream(), or LZ4_resetStream().
+ *  Consider switching to LZ4_initStream(),
+ *  invoking LZ4_resetStream() will trigger deprecation warnings in the future.
+ */
+LZ4LIB_API void LZ4_resetStream (LZ4_stream_t* streamPtr);
+
+
+#endif /* LZ4_H_98237428734687 */
 
 
 #if defined (__cplusplus)
 }
 #endif
-
-#endif /* LZ4_H_2983827168210 */
-- 
2.26.0


