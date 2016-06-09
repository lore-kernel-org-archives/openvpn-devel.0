From: Gert Doering <gert@...1296...>
Date: Thu,  9 Jun 2016 13:51:29 +0200
Message-Id: <1465473089-20754-1-git-send-email-gert@...1296...>
In-Reply-To: <1465411043-32096-1-git-send-email-gert@...1296...>
References: <1465411043-32096-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Upgrade bundled compat-lz4 to upstream
	release r131.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Take upstream release from https://github.com/Cyan4973/lz4/releases,
  copy lz4-r131/lib/lz4.c to src/compat/compat-lz4.c
  copy lz4-r131/lib/lz4.h to src/compat/compat-lz4.h
  change #include line in compat-lz4.c to use "compat-lz4.h" not "lz4.h"
  add "config.h" block and wrap in #ifdef NEED_COMPAT_LZ4 / #endif

No other changes to upstream code.

This commit is quite huge, but this is because we bundled a fairly old
version and upstream refactored quite a lot of code, changed // comments
to /* */ style, etc - to review, compare compat-lz4.* files to upstream.

v2: add missing #ifdef NEED_COMPAT_LZ4 wrapping

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/compat/compat-lz4.c | 1704 +++++++++++++++++++++++++++++++++--------------
 src/compat/compat-lz4.h |  375 ++++++++---
 2 files changed, 1464 insertions(+), 615 deletions(-)

diff --git a/src/compat/compat-lz4.c b/src/compat/compat-lz4.c
index c63c18b..5855ca1 100644
--- a/src/compat/compat-lz4.c
+++ b/src/compat/compat-lz4.c
@@ -1,6 +1,7 @@
 /*
    LZ4 - Fast LZ compression algorithm
-   Copyright (C) 2011-2013, Yann Collet.
+   Copyright (C) 2011-2015, Yann Collet.
+
    BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
 
    Redistribution and use in source and binary forms, with or without
@@ -27,7 +28,7 @@
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
    You can contact the author at :
-   - LZ4 source repository : http://code.google.com/p/lz4/
+   - LZ4 source repository : https://github.com/Cyan4973/lz4
    - LZ4 public forum : https://groups.google.com/forum/#!forum/lz4c
 */
 
@@ -39,109 +40,63 @@
 
 #ifdef NEED_COMPAT_LZ4
 
-//**************************************
-// Tuning parameters
-//**************************************
-// MEMORY_USAGE :
-// Memory usage formula : N->2^N Bytes (examples : 10 -> 1KB; 12 -> 4KB ; 16 -> 64KB; 20 -> 1MB; etc.)
-// Increasing memory usage improves compression ratio
-// Reduced memory usage can improve speed, due to cache effect
-// Default value is 14, for 16KB, which nicely fits into Intel x86 L1 cache
-#define MEMORY_USAGE 14
-
-// HEAPMODE :
-// Select how default compression functions will allocate memory for their hash table,
-// in memory stack (0:default, fastest), or in memory heap (1:requires memory allocation (malloc)).
+/**************************************
+*  Tuning parameters
+**************************************/
+/*
+ * HEAPMODE :
+ * Select how default compression functions will allocate memory for their hash table,
+ * in memory stack (0:default, fastest), or in memory heap (1:requires malloc()).
+ */
 #define HEAPMODE 0
 
+/*
+ * ACCELERATION_DEFAULT :
+ * Select "acceleration" for LZ4_compress_fast() when parameter value <= 0
+ */
+#define ACCELERATION_DEFAULT 1
 
-//**************************************
-// CPU Feature Detection
-//**************************************
-// 32 or 64 bits ?
-#if (defined(__x86_64__) || defined(_M_X64) || defined(_WIN64) \
-  || defined(__powerpc64__) || defined(__ppc64__) || defined(__PPC64__) \
-  || defined(__64BIT__) || defined(_LP64) || defined(__LP64__) \
-  || defined(__ia64) || defined(__itanium__) || defined(_M_IA64) )   // Detects 64 bits mode
-#  define LZ4_ARCH64 1
-#else
-#  define LZ4_ARCH64 0
-#endif
-
-// Little Endian or Big Endian ?
-// Overwrite the #define below if you know your architecture endianess
-#if defined (__GLIBC__)
-#  include <endian.h>
-#  if (__BYTE_ORDER == __BIG_ENDIAN)
-#     define LZ4_BIG_ENDIAN 1
-#  endif
-#elif (defined(__BIG_ENDIAN__) || defined(__BIG_ENDIAN) || defined(_BIG_ENDIAN)) && !(defined(__LITTLE_ENDIAN__) || defined(__LITTLE_ENDIAN) || defined(_LITTLE_ENDIAN))
-#  define LZ4_BIG_ENDIAN 1
-#elif defined(__sparc) || defined(__sparc__) \
-   || defined(__powerpc__) || defined(__ppc__) || defined(__PPC__) \
-   || defined(__hpux)  || defined(__hppa) \
-   || defined(_MIPSEB) || defined(__s390__)
-#  define LZ4_BIG_ENDIAN 1
-#else
-// Little Endian assumed. PDP Endian and other very rare endian format are unsupported.
-#endif
-
-// Unaligned memory access is automatically enabled for "common" CPU, such as x86.
-// For others CPU, such as ARM, the compiler may be more cautious, inserting unnecessary extra code to ensure aligned access property
-// If you know your target CPU supports unaligned memory access, you want to force this option manually to improve performance
-#if defined(__ARM_FEATURE_UNALIGNED)
-#  define LZ4_FORCE_UNALIGNED_ACCESS 1
-#endif
 
-// Define this parameter if your target system or compiler does not support hardware bit count
-#if defined(_MSC_VER) && defined(_WIN32_WCE)            // Visual Studio for Windows CE does not support Hardware bit count
+/**************************************
+*  CPU Feature Detection
+**************************************/
+/*
+ * LZ4_FORCE_SW_BITCOUNT
+ * Define this parameter if your target system or compiler does not support hardware bit count
+ */
+#if defined(_MSC_VER) && defined(_WIN32_WCE)   /* Visual Studio for Windows CE does not support Hardware bit count */
 #  define LZ4_FORCE_SW_BITCOUNT
 #endif
 
-// BIG_ENDIAN_NATIVE_BUT_INCOMPATIBLE :
-// This option may provide a small boost to performance for some big endian cpu, although probably modest.
-// You may set this option to 1 if data will remain within closed environment.
-// This option is useless on Little_Endian CPU (such as x86)
-//#define BIG_ENDIAN_NATIVE_BUT_INCOMPATIBLE 1
 
+/**************************************
+*  Includes
+**************************************/
+#include "compat-lz4.h"
 
-//**************************************
-// Compiler Options
-//**************************************
-#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)   // C99
-/* "restrict" is a known keyword */
-#else
-#  define restrict // Disable restrict
-#endif
 
-#ifdef _MSC_VER    // Visual Studio
+/**************************************
+*  Compiler Options
+**************************************/
+#ifdef _MSC_VER    /* Visual Studio */
 #  define FORCE_INLINE static __forceinline
-#  include <intrin.h>                    // For Visual 2005
-#  if LZ4_ARCH64   // 64-bits
-#    pragma intrinsic(_BitScanForward64) // For Visual 2005
-#    pragma intrinsic(_BitScanReverse64) // For Visual 2005
-#  else            // 32-bits
-#    pragma intrinsic(_BitScanForward)   // For Visual 2005
-#    pragma intrinsic(_BitScanReverse)   // For Visual 2005
-#  endif
-#  pragma warning(disable : 4127)        // disable: C4127: conditional expression is constant
+#  include <intrin.h>
+#  pragma warning(disable : 4127)        /* disable: C4127: conditional expression is constant */
+#  pragma warning(disable : 4293)        /* disable: C4293: too large shift (32-bits) */
 #else
-#  ifdef __GNUC__
-#    define FORCE_INLINE static inline __attribute__((always_inline))
+#  if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)   /* C99 */
+#    if defined(__GNUC__) || defined(__clang__)
+#      define FORCE_INLINE static inline __attribute__((always_inline))
+#    else
+#      define FORCE_INLINE static inline
+#    endif
 #  else
-#    define FORCE_INLINE static inline
-#  endif
-#endif
-
-#ifdef _MSC_VER
-#  define lz4_bswap16(x) _byteswap_ushort(x)
-#else
-#  define lz4_bswap16(x) ((unsigned short int) ((((x) >> 8) & 0xffu) | (((x) & 0xffu) << 8)))
-#endif
-
-#define GCC_VERSION (__GNUC__ * 100 + __GNUC_MINOR__)
+#    define FORCE_INLINE static
+#  endif   /* __STDC_VERSION__ */
+#endif  /* _MSC_VER */
 
-#if (GCC_VERSION >= 302) || (__INTEL_COMPILER >= 800) || defined(__clang__)
+/* LZ4_GCC_VERSION is defined into lz4.h */
+#if (LZ4_GCC_VERSION >= 302) || (__INTEL_COMPILER >= 800) || defined(__clang__)
 #  define expect(expr,value)    (__builtin_expect ((expr),(value)) )
 #else
 #  define expect(expr,value)    (expr)
@@ -151,26 +106,20 @@
 #define unlikely(expr)   expect((expr) != 0, 0)
 
 
-//**************************************
-// Memory routines
-//**************************************
-#include <stdlib.h>   // malloc, calloc, free
+/**************************************
+*  Memory routines
+**************************************/
+#include <stdlib.h>   /* malloc, calloc, free */
 #define ALLOCATOR(n,s) calloc(n,s)
 #define FREEMEM        free
-#include <string.h>   // memset, memcpy
+#include <string.h>   /* memset, memcpy */
 #define MEM_INIT       memset
 
 
-//**************************************
-// Includes
-//**************************************
-#include "compat-lz4.h"
-
-
-//**************************************
-// Basic Types
-//**************************************
-#if defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L   // C99
+/**************************************
+*  Basic Types
+**************************************/
+#if defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)   /* C99 */
 # include <stdint.h>
   typedef  uint8_t BYTE;
   typedef uint16_t U16;
@@ -185,55 +134,105 @@
   typedef unsigned long long  U64;
 #endif
 
-#if defined(__GNUC__)  && !defined(LZ4_FORCE_UNALIGNED_ACCESS)
-#  define _PACKED __attribute__ ((packed))
-#else
-#  define _PACKED
-#endif
 
-#if !defined(LZ4_FORCE_UNALIGNED_ACCESS) && !defined(__GNUC__)
-#  if defined(__IBMC__) || defined(__SUNPRO_C) || defined(__SUNPRO_CC)
-#    pragma pack(1)
-#  else
-#    pragma pack(push, 1)
-#  endif
-#endif
+/**************************************
+*  Reading and writing into memory
+**************************************/
+#define STEPSIZE sizeof(size_t)
 
-typedef struct { U16 v; }  _PACKED U16_S;
-typedef struct { U32 v; }  _PACKED U32_S;
-typedef struct { U64 v; }  _PACKED U64_S;
-typedef struct {size_t v;} _PACKED size_t_S;
+static unsigned LZ4_64bits(void) { return sizeof(void*)==8; }
 
-#if !defined(LZ4_FORCE_UNALIGNED_ACCESS) && !defined(__GNUC__)
-#  if defined(__SUNPRO_C) || defined(__SUNPRO_CC)
-#    pragma pack(0)
-#  else
-#    pragma pack(pop)
-#  endif
-#endif
+static unsigned LZ4_isLittleEndian(void)
+{
+    const union { U32 i; BYTE c[4]; } one = { 1 };   /* don't use static : performance detrimental  */
+    return one.c[0];
+}
+
+
+static U16 LZ4_read16(const void* memPtr)
+{
+    U16 val16;
+    memcpy(&val16, memPtr, 2);
+    return val16;
+}
+
+static U16 LZ4_readLE16(const void* memPtr)
+{
+    if (LZ4_isLittleEndian())
+    {
+        return LZ4_read16(memPtr);
+    }
+    else
+    {
+        const BYTE* p = (const BYTE*)memPtr;
+        return (U16)((U16)p[0] + (p[1]<<8));
+    }
+}
+
+static void LZ4_writeLE16(void* memPtr, U16 value)
+{
+    if (LZ4_isLittleEndian())
+    {
+        memcpy(memPtr, &value, 2);
+    }
+    else
+    {
+        BYTE* p = (BYTE*)memPtr;
+        p[0] = (BYTE) value;
+        p[1] = (BYTE)(value>>8);
+    }
+}
 
-#define A16(x)   (((U16_S *)(x))->v)
-#define A32(x)   (((U32_S *)(x))->v)
-#define A64(x)   (((U64_S *)(x))->v)
-#define AARCH(x) (((size_t_S *)(x))->v)
+static U32 LZ4_read32(const void* memPtr)
+{
+    U32 val32;
+    memcpy(&val32, memPtr, 4);
+    return val32;
+}
 
+static U64 LZ4_read64(const void* memPtr)
+{
+    U64 val64;
+    memcpy(&val64, memPtr, 8);
+    return val64;
+}
 
-//**************************************
-// Constants
-//**************************************
-#define LZ4_HASHLOG   (MEMORY_USAGE-2)
-#define HASHTABLESIZE (1 << MEMORY_USAGE)
-#define HASHNBCELLS4  (1 << LZ4_HASHLOG)
+static size_t LZ4_read_ARCH(const void* p)
+{
+    if (LZ4_64bits())
+        return (size_t)LZ4_read64(p);
+    else
+        return (size_t)LZ4_read32(p);
+}
+
+
+static void LZ4_copy4(void* dstPtr, const void* srcPtr) { memcpy(dstPtr, srcPtr, 4); }
+
+static void LZ4_copy8(void* dstPtr, const void* srcPtr) { memcpy(dstPtr, srcPtr, 8); }
+
+/* customized version of memcpy, which may overwrite up to 7 bytes beyond dstEnd */
+static void LZ4_wildCopy(void* dstPtr, const void* srcPtr, void* dstEnd)
+{
+    BYTE* d = (BYTE*)dstPtr;
+    const BYTE* s = (const BYTE*)srcPtr;
+    BYTE* e = (BYTE*)dstEnd;
+    do { LZ4_copy8(d,s); d+=8; s+=8; } while (d<e);
+}
 
+
+/**************************************
+*  Common Constants
+**************************************/
 #define MINMATCH 4
 
 #define COPYLENGTH 8
 #define LASTLITERALS 5
 #define MFLIMIT (COPYLENGTH+MINMATCH)
-const int LZ4_minLength = (MFLIMIT+1);
+static const int LZ4_minLength = (MFLIMIT+1);
 
-#define LZ4_64KLIMIT ((1<<16) + (MFLIMIT-1))
-#define SKIPSTRENGTH 6     // Increasing this value will make the compression run slower on incompressible data
+#define KB *(1 <<10)
+#define MB *(1 <<20)
+#define GB *(1U<<30)
 
 #define MAXD_LOG 16
 #define MAX_DISTANCE ((1 << MAXD_LOG) - 1)
@@ -243,135 +242,150 @@ const int LZ4_minLength = (MFLIMIT+1);
 #define RUN_BITS (8-ML_BITS)
 #define RUN_MASK ((1U<<RUN_BITS)-1)
 
-#define KB *(1U<<10)
-#define MB *(1U<<20)
-#define GB *(1U<<30)
 
+/**************************************
+*  Common Utils
+**************************************/
+#define LZ4_STATIC_ASSERT(c)    { enum { LZ4_static_assert = 1/(int)(!!(c)) }; }   /* use only *after* variable declarations */
 
-//**************************************
-// Structures and local types
-//**************************************
 
-typedef struct {
-    U32 hashTable[HASHNBCELLS4];
-    const BYTE* bufferStart;
-    const BYTE* base;
-    const BYTE* nextBlock;
-} LZ4_Data_Structure;
+/**************************************
+*  Common functions
+**************************************/
+static unsigned LZ4_NbCommonBytes (register size_t val)
+{
+    if (LZ4_isLittleEndian())
+    {
+        if (LZ4_64bits())
+        {
+#       if defined(_MSC_VER) && defined(_WIN64) && !defined(LZ4_FORCE_SW_BITCOUNT)
+            unsigned long r = 0;
+            _BitScanForward64( &r, (U64)val );
+            return (int)(r>>3);
+#       elif (defined(__clang__) || (LZ4_GCC_VERSION >= 304)) && !defined(LZ4_FORCE_SW_BITCOUNT)
+            return (__builtin_ctzll((U64)val) >> 3);
+#       else
+            static const int DeBruijnBytePos[64] = { 0, 0, 0, 0, 0, 1, 1, 2, 0, 3, 1, 3, 1, 4, 2, 7, 0, 2, 3, 6, 1, 5, 3, 5, 1, 3, 4, 4, 2, 5, 6, 7, 7, 0, 1, 2, 3, 3, 4, 6, 2, 6, 5, 5, 3, 4, 5, 6, 7, 1, 2, 4, 6, 4, 4, 5, 7, 2, 6, 5, 7, 6, 7, 7 };
+            return DeBruijnBytePos[((U64)((val & -(long long)val) * 0x0218A392CDABBD3FULL)) >> 58];
+#       endif
+        }
+        else /* 32 bits */
+        {
+#       if defined(_MSC_VER) && !defined(LZ4_FORCE_SW_BITCOUNT)
+            unsigned long r;
+            _BitScanForward( &r, (U32)val );
+            return (int)(r>>3);
+#       elif (defined(__clang__) || (LZ4_GCC_VERSION >= 304)) && !defined(LZ4_FORCE_SW_BITCOUNT)
+            return (__builtin_ctz((U32)val) >> 3);
+#       else
+            static const int DeBruijnBytePos[32] = { 0, 0, 3, 0, 3, 1, 3, 0, 3, 2, 2, 1, 3, 2, 0, 1, 3, 3, 1, 2, 2, 2, 2, 0, 3, 1, 2, 0, 1, 0, 1, 1 };
+            return DeBruijnBytePos[((U32)((val & -(S32)val) * 0x077CB531U)) >> 27];
+#       endif
+        }
+    }
+    else   /* Big Endian CPU */
+    {
+        if (LZ4_64bits())
+        {
+#       if defined(_MSC_VER) && defined(_WIN64) && !defined(LZ4_FORCE_SW_BITCOUNT)
+            unsigned long r = 0;
+            _BitScanReverse64( &r, val );
+            return (unsigned)(r>>3);
+#       elif (defined(__clang__) || (LZ4_GCC_VERSION >= 304)) && !defined(LZ4_FORCE_SW_BITCOUNT)
+            return (__builtin_clzll((U64)val) >> 3);
+#       else
+            unsigned r;
+            if (!(val>>32)) { r=4; } else { r=0; val>>=32; }
+            if (!(val>>16)) { r+=2; val>>=8; } else { val>>=24; }
+            r += (!val);
+            return r;
+#       endif
+        }
+        else /* 32 bits */
+        {
+#       if defined(_MSC_VER) && !defined(LZ4_FORCE_SW_BITCOUNT)
+            unsigned long r = 0;
+            _BitScanReverse( &r, (unsigned long)val );
+            return (unsigned)(r>>3);
+#       elif (defined(__clang__) || (LZ4_GCC_VERSION >= 304)) && !defined(LZ4_FORCE_SW_BITCOUNT)
+            return (__builtin_clz((U32)val) >> 3);
+#       else
+            unsigned r;
+            if (!(val>>16)) { r=2; val>>=8; } else { r=0; val>>=24; }
+            r += (!val);
+            return r;
+#       endif
+        }
+    }
+}
 
-typedef enum { notLimited = 0, limited = 1 } limitedOutput_directive;
-typedef enum { byPtr, byU32, byU16 } tableType_t;
+static unsigned LZ4_count(const BYTE* pIn, const BYTE* pMatch, const BYTE* pInLimit)
+{
+    const BYTE* const pStart = pIn;
 
-typedef enum { noPrefix = 0, withPrefix = 1 } prefix64k_directive;
+    while (likely(pIn<pInLimit-(STEPSIZE-1)))
+    {
+        size_t diff = LZ4_read_ARCH(pMatch) ^ LZ4_read_ARCH(pIn);
+        if (!diff) { pIn+=STEPSIZE; pMatch+=STEPSIZE; continue; }
+        pIn += LZ4_NbCommonBytes(diff);
+        return (unsigned)(pIn - pStart);
+    }
 
-typedef enum { endOnOutputSize = 0, endOnInputSize = 1 } endCondition_directive;
-typedef enum { full = 0, partial = 1 } earlyEnd_directive;
+    if (LZ4_64bits()) if ((pIn<(pInLimit-3)) && (LZ4_read32(pMatch) == LZ4_read32(pIn))) { pIn+=4; pMatch+=4; }
+    if ((pIn<(pInLimit-1)) && (LZ4_read16(pMatch) == LZ4_read16(pIn))) { pIn+=2; pMatch+=2; }
+    if ((pIn<pInLimit) && (*pMatch == *pIn)) pIn++;
+    return (unsigned)(pIn - pStart);
+}
 
 
-//**************************************
-// Architecture-specific macros
-//**************************************
-#define STEPSIZE                  sizeof(size_t)
-#define LZ4_COPYSTEP(d,s)         { AARCH(d) = AARCH(s); d+=STEPSIZE; s+=STEPSIZE; }
-#define LZ4_COPY8(d,s)            { LZ4_COPYSTEP(d,s); if (STEPSIZE<8) LZ4_COPYSTEP(d,s); }
-#define LZ4_SECURECOPY(d,s,e)     { if ((STEPSIZE==4)||(d<e)) LZ4_WILDCOPY(d,s,e); }
-
-#if LZ4_ARCH64   // 64-bit
-#  define HTYPE                   U32
-#  define INITBASE(base)          const BYTE* const base = ip
-#else            // 32-bit
-#  define HTYPE                   const BYTE*
-#  define INITBASE(base)          const int base = 0
-#endif
+#ifndef LZ4_COMMONDEFS_ONLY
+/**************************************
+*  Local Constants
+**************************************/
+#define LZ4_HASHLOG   (LZ4_MEMORY_USAGE-2)
+#define HASHTABLESIZE (1 << LZ4_MEMORY_USAGE)
+#define HASH_SIZE_U32 (1 << LZ4_HASHLOG)       /* required as macro for static allocation */
 
-#if (defined(LZ4_BIG_ENDIAN) && !defined(BIG_ENDIAN_NATIVE_BUT_INCOMPATIBLE))
-#  define LZ4_READ_LITTLEENDIAN_16(d,s,p) { U16 v = A16(p); v = lz4_bswap16(v); d = (s) - v; }
-#  define LZ4_WRITE_LITTLEENDIAN_16(p,i)  { U16 v = (U16)(i); v = lz4_bswap16(v); A16(p) = v; p+=2; }
-#else      // Little Endian
-#  define LZ4_READ_LITTLEENDIAN_16(d,s,p) { d = (s) - A16(p); }
-#  define LZ4_WRITE_LITTLEENDIAN_16(p,v)  { A16(p) = v; p+=2; }
-#endif
+static const int LZ4_64Klimit = ((64 KB) + (MFLIMIT-1));
+static const U32 LZ4_skipTrigger = 6;  /* Increase this value ==> compression run slower on incompressible data */
 
 
-//**************************************
-// Macros
-//**************************************
-#define LZ4_WILDCOPY(d,s,e)     { do { LZ4_COPY8(d,s) } while (d<e); }           // at the end, d>=e;
-
-
-//****************************
-// Private functions
-//****************************
-#if LZ4_ARCH64
-
-FORCE_INLINE int LZ4_NbCommonBytes (register U64 val)
-{
-# if defined(LZ4_BIG_ENDIAN)
-#   if defined(_MSC_VER) && !defined(LZ4_FORCE_SW_BITCOUNT)
-    unsigned long r = 0;
-    _BitScanReverse64( &r, val );
-    return (int)(r>>3);
-#   elif defined(__GNUC__) && (GCC_VERSION >= 304) && !defined(LZ4_FORCE_SW_BITCOUNT)
-    return (__builtin_clzll(val) >> 3);
-#   else
-    int r;
-    if (!(val>>32)) { r=4; } else { r=0; val>>=32; }
-    if (!(val>>16)) { r+=2; val>>=8; } else { val>>=24; }
-    r += (!val);
-    return r;
-#   endif
-# else
-#   if defined(_MSC_VER) && !defined(LZ4_FORCE_SW_BITCOUNT)
-    unsigned long r = 0;
-    _BitScanForward64( &r, val );
-    return (int)(r>>3);
-#   elif defined(__GNUC__) && (GCC_VERSION >= 304) && !defined(LZ4_FORCE_SW_BITCOUNT)
-    return (__builtin_ctzll(val) >> 3);
-#   else
-    static const int DeBruijnBytePos[64] = { 0, 0, 0, 0, 0, 1, 1, 2, 0, 3, 1, 3, 1, 4, 2, 7, 0, 2, 3, 6, 1, 5, 3, 5, 1, 3, 4, 4, 2, 5, 6, 7, 7, 0, 1, 2, 3, 3, 4, 6, 2, 6, 5, 5, 3, 4, 5, 6, 7, 1, 2, 4, 6, 4, 4, 5, 7, 2, 6, 5, 7, 6, 7, 7 };
-    return DeBruijnBytePos[((U64)((val & -(long long)val) * 0x0218A392CDABBD3FULL)) >> 58];
-#   endif
-# endif
-}
+/**************************************
+*  Local Structures and types
+**************************************/
+typedef struct {
+    U32 hashTable[HASH_SIZE_U32];
+    U32 currentOffset;
+    U32 initCheck;
+    const BYTE* dictionary;
+    BYTE* bufferStart;   /* obsolete, used for slideInputBuffer */
+    U32 dictSize;
+} LZ4_stream_t_internal;
+
+typedef enum { notLimited = 0, limitedOutput = 1 } limitedOutput_directive;
+typedef enum { byPtr, byU32, byU16 } tableType_t;
 
-#else
+typedef enum { noDict = 0, withPrefix64k, usingExtDict } dict_directive;
+typedef enum { noDictIssue = 0, dictSmall } dictIssue_directive;
 
-FORCE_INLINE int LZ4_NbCommonBytes (register U32 val)
-{
-# if defined(LZ4_BIG_ENDIAN)
-#   if defined(_MSC_VER) && !defined(LZ4_FORCE_SW_BITCOUNT)
-    unsigned long r = 0;
-    _BitScanReverse( &r, val );
-    return (int)(r>>3);
-#   elif defined(__GNUC__) && (GCC_VERSION >= 304) && !defined(LZ4_FORCE_SW_BITCOUNT)
-    return (__builtin_clz(val) >> 3);
-#   else
-    int r;
-    if (!(val>>16)) { r=2; val>>=8; } else { r=0; val>>=24; }
-    r += (!val);
-    return r;
-#   endif
-# else
-#   if defined(_MSC_VER) && !defined(LZ4_FORCE_SW_BITCOUNT)
-    unsigned long r;
-    _BitScanForward( &r, val );
-    return (int)(r>>3);
-#   elif defined(__GNUC__) && (GCC_VERSION >= 304) && !defined(LZ4_FORCE_SW_BITCOUNT)
-    return (__builtin_ctz(val) >> 3);
-#   else
-    static const int DeBruijnBytePos[32] = { 0, 0, 3, 0, 3, 1, 3, 0, 3, 2, 2, 1, 3, 2, 0, 1, 3, 3, 1, 2, 2, 2, 2, 0, 3, 1, 2, 0, 1, 0, 1, 1 };
-    return DeBruijnBytePos[((U32)((val & -(S32)val) * 0x077CB531U)) >> 27];
-#   endif
-# endif
-}
+typedef enum { endOnOutputSize = 0, endOnInputSize = 1 } endCondition_directive;
+typedef enum { full = 0, partial = 1 } earlyEnd_directive;
 
-#endif
+
+/**************************************
+*  Local Utils
+**************************************/
+int LZ4_versionNumber (void) { return LZ4_VERSION_NUMBER; }
+int LZ4_compressBound(int isize)  { return LZ4_COMPRESSBOUND(isize); }
+int LZ4_sizeofState() { return LZ4_STREAMSIZE; }
 
 
-//****************************
-// Compression functions
-//****************************
-FORCE_INLINE int LZ4_hashSequence(U32 sequence, tableType_t tableType)
+
+/********************************
+*  Compression functions
+********************************/
+
+static U32 LZ4_hashSequence(U32 sequence, tableType_t const tableType)
 {
     if (tableType == byU16)
         return (((sequence) * 2654435761U) >> ((MINMATCH*8)-(LZ4_HASHLOG+1)));
@@ -379,220 +393,539 @@ FORCE_INLINE int LZ4_hashSequence(U32 sequence, tableType_t tableType)
         return (((sequence) * 2654435761U) >> ((MINMATCH*8)-LZ4_HASHLOG));
 }
 
-FORCE_INLINE int LZ4_hashPosition(const BYTE* p, tableType_t tableType) { return LZ4_hashSequence(A32(p), tableType); }
+static const U64 prime5bytes = 889523592379ULL;
+static U32 LZ4_hashSequence64(size_t sequence, tableType_t const tableType)
+{
+    const U32 hashLog = (tableType == byU16) ? LZ4_HASHLOG+1 : LZ4_HASHLOG;
+    const U32 hashMask = (1<<hashLog) - 1;
+    return ((sequence * prime5bytes) >> (40 - hashLog)) & hashMask;
+}
 
-FORCE_INLINE void LZ4_putPositionOnHash(const BYTE* p, U32 h, void* tableBase, tableType_t tableType, const BYTE* srcBase)
+static U32 LZ4_hashSequenceT(size_t sequence, tableType_t const tableType)
+{
+    if (LZ4_64bits())
+        return LZ4_hashSequence64(sequence, tableType);
+    return LZ4_hashSequence((U32)sequence, tableType);
+}
+
+static U32 LZ4_hashPosition(const void* p, tableType_t tableType) { return LZ4_hashSequenceT(LZ4_read_ARCH(p), tableType); }
+
+static void LZ4_putPositionOnHash(const BYTE* p, U32 h, void* tableBase, tableType_t const tableType, const BYTE* srcBase)
 {
     switch (tableType)
     {
-    case byPtr: { const BYTE** hashTable = (const BYTE**) tableBase; hashTable[h] = p; break; }
-    case byU32: { U32* hashTable = (U32*) tableBase; hashTable[h] = (U32)(p-srcBase); break; }
-    case byU16: { U16* hashTable = (U16*) tableBase; hashTable[h] = (U16)(p-srcBase); break; }
+    case byPtr: { const BYTE** hashTable = (const BYTE**)tableBase; hashTable[h] = p; return; }
+    case byU32: { U32* hashTable = (U32*) tableBase; hashTable[h] = (U32)(p-srcBase); return; }
+    case byU16: { U16* hashTable = (U16*) tableBase; hashTable[h] = (U16)(p-srcBase); return; }
     }
 }
 
-FORCE_INLINE void LZ4_putPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
+static void LZ4_putPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
 {
     U32 h = LZ4_hashPosition(p, tableType);
     LZ4_putPositionOnHash(p, h, tableBase, tableType, srcBase);
 }
 
-FORCE_INLINE const BYTE* LZ4_getPositionOnHash(U32 h, void* tableBase, tableType_t tableType, const BYTE* srcBase)
+static const BYTE* LZ4_getPositionOnHash(U32 h, void* tableBase, tableType_t tableType, const BYTE* srcBase)
 {
     if (tableType == byPtr) { const BYTE** hashTable = (const BYTE**) tableBase; return hashTable[h]; }
     if (tableType == byU32) { U32* hashTable = (U32*) tableBase; return hashTable[h] + srcBase; }
-    { U16* hashTable = (U16*) tableBase; return hashTable[h] + srcBase; }   // default, to ensure a return
+    { U16* hashTable = (U16*) tableBase; return hashTable[h] + srcBase; }   /* default, to ensure a return */
 }
 
-FORCE_INLINE const BYTE* LZ4_getPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
+static const BYTE* LZ4_getPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
 {
     U32 h = LZ4_hashPosition(p, tableType);
     return LZ4_getPositionOnHash(h, tableBase, tableType, srcBase);
 }
 
-
 FORCE_INLINE int LZ4_compress_generic(
-                 void* ctx,
-                 const char* source,
-                 char* dest,
-                 int inputSize,
-                 int maxOutputSize,
-
-                 limitedOutput_directive limitedOutput,
-                 tableType_t tableType,
-                 prefix64k_directive prefix)
+                 void* const ctx,
+                 const char* const source,
+                 char* const dest,
+                 const int inputSize,
+                 const int maxOutputSize,
+                 const limitedOutput_directive outputLimited,
+                 const tableType_t tableType,
+                 const dict_directive dict,
+                 const dictIssue_directive dictIssue,
+                 const U32 acceleration)
 {
+    LZ4_stream_t_internal* const dictPtr = (LZ4_stream_t_internal*)ctx;
+
     const BYTE* ip = (const BYTE*) source;
-    const BYTE* const base = (prefix==withPrefix) ? ((LZ4_Data_Structure*)ctx)->base : (const BYTE*) source;
-    const BYTE* const lowLimit = ((prefix==withPrefix) ? ((LZ4_Data_Structure*)ctx)->bufferStart : (const BYTE*)source);
+    const BYTE* base;
+    const BYTE* lowLimit;
+    const BYTE* const lowRefLimit = ip - dictPtr->dictSize;
+    const BYTE* const dictionary = dictPtr->dictionary;
+    const BYTE* const dictEnd = dictionary + dictPtr->dictSize;
+    const size_t dictDelta = dictEnd - (const BYTE*)source;
     const BYTE* anchor = (const BYTE*) source;
     const BYTE* const iend = ip + inputSize;
     const BYTE* const mflimit = iend - MFLIMIT;
     const BYTE* const matchlimit = iend - LASTLITERALS;
 
     BYTE* op = (BYTE*) dest;
-    BYTE* const oend = op + maxOutputSize;
+    BYTE* const olimit = op + maxOutputSize;
 
-    int length;
-    const int skipStrength = SKIPSTRENGTH;
     U32 forwardH;
+    size_t refDelta=0;
 
-    // Init conditions
-    if ((U32)inputSize > (U32)LZ4_MAX_INPUT_SIZE) return 0;                                // Unsupported input size, too large (or negative)
-    if ((prefix==withPrefix) && (ip != ((LZ4_Data_Structure*)ctx)->nextBlock)) return 0;   // must continue from end of previous block
-    if (prefix==withPrefix) ((LZ4_Data_Structure*)ctx)->nextBlock=iend;                    // do it now, due to potential early exit
-    if ((tableType == byU16) && (inputSize>=LZ4_64KLIMIT)) return 0;                       // Size too large (not within 64K limit)
-    if (inputSize<LZ4_minLength) goto _last_literals;                                      // Input too small, no compression (all literals)
+    /* Init conditions */
+    if ((U32)inputSize > (U32)LZ4_MAX_INPUT_SIZE) return 0;   /* Unsupported input size, too large (or negative) */
+    switch(dict)
+    {
+    case noDict:
+    default:
+        base = (const BYTE*)source;
+        lowLimit = (const BYTE*)source;
+        break;
+    case withPrefix64k:
+        base = (const BYTE*)source - dictPtr->currentOffset;
+        lowLimit = (const BYTE*)source - dictPtr->dictSize;
+        break;
+    case usingExtDict:
+        base = (const BYTE*)source - dictPtr->currentOffset;
+        lowLimit = (const BYTE*)source;
+        break;
+    }
+    if ((tableType == byU16) && (inputSize>=LZ4_64Klimit)) return 0;   /* Size too large (not within 64K limit) */
+    if (inputSize<LZ4_minLength) goto _last_literals;                  /* Input too small, no compression (all literals) */
 
-    // First Byte
+    /* First Byte */
     LZ4_putPosition(ip, ctx, tableType, base);
     ip++; forwardH = LZ4_hashPosition(ip, tableType);
 
-    // Main Loop
+    /* Main Loop */
     for ( ; ; )
     {
-        int findMatchAttempts = (1U << skipStrength) + 3;
-        const BYTE* forwardIp = ip;
-        const BYTE* ref;
+        const BYTE* match;
         BYTE* token;
+        {
+            const BYTE* forwardIp = ip;
+            unsigned step = 1;
+            unsigned searchMatchNb = acceleration << LZ4_skipTrigger;
+
+            /* Find a match */
+            do {
+                U32 h = forwardH;
+                ip = forwardIp;
+                forwardIp += step;
+                step = (searchMatchNb++ >> LZ4_skipTrigger);
+
+                if (unlikely(forwardIp > mflimit)) goto _last_literals;
+
+                match = LZ4_getPositionOnHash(h, ctx, tableType, base);
+                if (dict==usingExtDict)
+                {
+                    if (match<(const BYTE*)source)
+                    {
+                        refDelta = dictDelta;
+                        lowLimit = dictionary;
+                    }
+                    else
+                    {
+                        refDelta = 0;
+                        lowLimit = (const BYTE*)source;
+                    }
+                }
+                forwardH = LZ4_hashPosition(forwardIp, tableType);
+                LZ4_putPositionOnHash(ip, h, ctx, tableType, base);
+
+            } while ( ((dictIssue==dictSmall) ? (match < lowRefLimit) : 0)
+                || ((tableType==byU16) ? 0 : (match + MAX_DISTANCE < ip))
+                || (LZ4_read32(match+refDelta) != LZ4_read32(ip)) );
+        }
 
-        // Find a match
-        do {
-            U32 h = forwardH;
-            int step = findMatchAttempts++ >> skipStrength;
-            ip = forwardIp;
-            forwardIp = ip + step;
-
-            if unlikely(forwardIp > mflimit) { goto _last_literals; }
+        /* Catch up */
+        while ((ip>anchor) && (match+refDelta > lowLimit) && (unlikely(ip[-1]==match[refDelta-1]))) { ip--; match--; }
 
-            forwardH = LZ4_hashPosition(forwardIp, tableType);
-            ref = LZ4_getPositionOnHash(h, ctx, tableType, base);
-            LZ4_putPositionOnHash(ip, h, ctx, tableType, base);
+        {
+            /* Encode Literal length */
+            unsigned litLength = (unsigned)(ip - anchor);
+            token = op++;
+            if ((outputLimited) && (unlikely(op + litLength + (2 + 1 + LASTLITERALS) + (litLength/255) > olimit)))
+                return 0;   /* Check output limit */
+            if (litLength>=RUN_MASK)
+            {
+                int len = (int)litLength-RUN_MASK;
+                *token=(RUN_MASK<<ML_BITS);
+                for(; len >= 255 ; len-=255) *op++ = 255;
+                *op++ = (BYTE)len;
+            }
+            else *token = (BYTE)(litLength<<ML_BITS);
 
-        } while ((ref + MAX_DISTANCE < ip) || (A32(ref) != A32(ip)));
+            /* Copy Literals */
+            LZ4_wildCopy(op, anchor, op+litLength);
+            op+=litLength;
+        }
 
-        // Catch up
-        while ((ip>anchor) && (ref > lowLimit) && unlikely(ip[-1]==ref[-1])) { ip--; ref--; }
+_next_match:
+        /* Encode Offset */
+        LZ4_writeLE16(op, (U16)(ip-match)); op+=2;
 
-        // Encode Literal length
-        length = (int)(ip - anchor);
-        token = op++;
-        if ((limitedOutput) && unlikely(op + length + (2 + 1 + LASTLITERALS) + (length/255) > oend)) return 0;   // Check output limit
-        if (length>=(int)RUN_MASK)
+        /* Encode MatchLength */
         {
-            int len = length-RUN_MASK;
-            *token=(RUN_MASK<<ML_BITS);
-            for(; len >= 255 ; len-=255) *op++ = 255;
-            *op++ = (BYTE)len;
-        }
-        else *token = (BYTE)(length<<ML_BITS);
+            unsigned matchLength;
 
-        // Copy Literals
-        { BYTE* end=(op)+(length); LZ4_WILDCOPY(op,anchor,end); op=end; }
+            if ((dict==usingExtDict) && (lowLimit==dictionary))
+            {
+                const BYTE* limit;
+                match += refDelta;
+                limit = ip + (dictEnd-match);
+                if (limit > matchlimit) limit = matchlimit;
+                matchLength = LZ4_count(ip+MINMATCH, match+MINMATCH, limit);
+                ip += MINMATCH + matchLength;
+                if (ip==limit)
+                {
+                    unsigned more = LZ4_count(ip, (const BYTE*)source, matchlimit);
+                    matchLength += more;
+                    ip += more;
+                }
+            }
+            else
+            {
+                matchLength = LZ4_count(ip+MINMATCH, match+MINMATCH, matchlimit);
+                ip += MINMATCH + matchLength;
+            }
 
-_next_match:
-        // Encode Offset
-        LZ4_WRITE_LITTLEENDIAN_16(op,(U16)(ip-ref));
+            if ((outputLimited) && (unlikely(op + (1 + LASTLITERALS) + (matchLength>>8) > olimit)))
+                return 0;    /* Check output limit */
+            if (matchLength>=ML_MASK)
+            {
+                *token += ML_MASK;
+                matchLength -= ML_MASK;
+                for (; matchLength >= 510 ; matchLength-=510) { *op++ = 255; *op++ = 255; }
+                if (matchLength >= 255) { matchLength-=255; *op++ = 255; }
+                *op++ = (BYTE)matchLength;
+            }
+            else *token += (BYTE)(matchLength);
+        }
 
-        // Start Counting
-        ip+=MINMATCH; ref+=MINMATCH;    // MinMatch already verified
         anchor = ip;
-        while likely(ip<matchlimit-(STEPSIZE-1))
-        {
-            size_t diff = AARCH(ref) ^ AARCH(ip);
-            if (!diff) { ip+=STEPSIZE; ref+=STEPSIZE; continue; }
-            ip += LZ4_NbCommonBytes(diff);
-            goto _endCount;
-        }
-        if (LZ4_ARCH64) if ((ip<(matchlimit-3)) && (A32(ref) == A32(ip))) { ip+=4; ref+=4; }
-        if ((ip<(matchlimit-1)) && (A16(ref) == A16(ip))) { ip+=2; ref+=2; }
-        if ((ip<matchlimit) && (*ref == *ip)) ip++;
-_endCount:
-
-        // Encode MatchLength
-        length = (int)(ip - anchor);
-        if ((limitedOutput) && unlikely(op + (1 + LASTLITERALS) + (length>>8) > oend)) return 0;    // Check output limit
-        if (length>=(int)ML_MASK)
-        {
-            *token += ML_MASK;
-            length -= ML_MASK;
-            for (; length > 509 ; length-=510) { *op++ = 255; *op++ = 255; }
-            if (length >= 255) { length-=255; *op++ = 255; }
-            *op++ = (BYTE)length;
-        }
-        else *token += (BYTE)(length);
 
-        // Test end of chunk
-        if (ip > mflimit) { anchor = ip;  break; }
+        /* Test end of chunk */
+        if (ip > mflimit) break;
 
-        // Fill table
+        /* Fill table */
         LZ4_putPosition(ip-2, ctx, tableType, base);
 
-        // Test next position
-        ref = LZ4_getPosition(ip, ctx, tableType, base);
+        /* Test next position */
+        match = LZ4_getPosition(ip, ctx, tableType, base);
+        if (dict==usingExtDict)
+        {
+            if (match<(const BYTE*)source)
+            {
+                refDelta = dictDelta;
+                lowLimit = dictionary;
+            }
+            else
+            {
+                refDelta = 0;
+                lowLimit = (const BYTE*)source;
+            }
+        }
         LZ4_putPosition(ip, ctx, tableType, base);
-        if ((ref + MAX_DISTANCE >= ip) && (A32(ref) == A32(ip))) { token = op++; *token=0; goto _next_match; }
+        if ( ((dictIssue==dictSmall) ? (match>=lowRefLimit) : 1)
+            && (match+MAX_DISTANCE>=ip)
+            && (LZ4_read32(match+refDelta)==LZ4_read32(ip)) )
+        { token=op++; *token=0; goto _next_match; }
 
-        // Prepare next loop
-        anchor = ip++;
-        forwardH = LZ4_hashPosition(ip, tableType);
+        /* Prepare next loop */
+        forwardH = LZ4_hashPosition(++ip, tableType);
     }
 
 _last_literals:
-    // Encode Last Literals
+    /* Encode Last Literals */
     {
-        int lastRun = (int)(iend - anchor);
-        if ((limitedOutput) && (((char*)op - dest) + lastRun + 1 + ((lastRun+255-RUN_MASK)/255) > (U32)maxOutputSize)) return 0;   // Check output limit
-        if (lastRun>=(int)RUN_MASK) { *op++=(RUN_MASK<<ML_BITS); lastRun-=RUN_MASK; for(; lastRun >= 255 ; lastRun-=255) *op++ = 255; *op++ = (BYTE) lastRun; }
-        else *op++ = (BYTE)(lastRun<<ML_BITS);
-        memcpy(op, anchor, iend - anchor);
-        op += iend-anchor;
+        const size_t lastRun = (size_t)(iend - anchor);
+        if ((outputLimited) && ((op - (BYTE*)dest) + lastRun + 1 + ((lastRun+255-RUN_MASK)/255) > (U32)maxOutputSize))
+            return 0;   /* Check output limit */
+        if (lastRun >= RUN_MASK)
+        {
+            size_t accumulator = lastRun - RUN_MASK;
+            *op++ = RUN_MASK << ML_BITS;
+            for(; accumulator >= 255 ; accumulator-=255) *op++ = 255;
+            *op++ = (BYTE) accumulator;
+        }
+        else
+        {
+            *op++ = (BYTE)(lastRun<<ML_BITS);
+        }
+        memcpy(op, anchor, lastRun);
+        op += lastRun;
     }
 
-    // End
+    /* End */
     return (int) (((char*)op)-dest);
 }
 
 
-int LZ4_compress(const char* source, char* dest, int inputSize)
+int LZ4_compress_fast_extState(void* state, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
+{
+    LZ4_resetStream((LZ4_stream_t*)state);
+    if (acceleration < 1) acceleration = ACCELERATION_DEFAULT;
+
+    if (maxOutputSize >= LZ4_compressBound(inputSize))
+    {
+        if (inputSize < LZ4_64Klimit)
+            return LZ4_compress_generic(state, source, dest, inputSize, 0, notLimited, byU16,                        noDict, noDictIssue, acceleration);
+        else
+            return LZ4_compress_generic(state, source, dest, inputSize, 0, notLimited, LZ4_64bits() ? byU32 : byPtr, noDict, noDictIssue, acceleration);
+    }
+    else
+    {
+        if (inputSize < LZ4_64Klimit)
+            return LZ4_compress_generic(state, source, dest, inputSize, maxOutputSize, limitedOutput, byU16,                        noDict, noDictIssue, acceleration);
+        else
+            return LZ4_compress_generic(state, source, dest, inputSize, maxOutputSize, limitedOutput, LZ4_64bits() ? byU32 : byPtr, noDict, noDictIssue, acceleration);
+    }
+}
+
+
+int LZ4_compress_fast(const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
 {
 #if (HEAPMODE)
-    void* ctx = ALLOCATOR(HASHNBCELLS4, 4);   // Aligned on 4-bytes boundaries
+    void* ctxPtr = ALLOCATOR(1, sizeof(LZ4_stream_t));   /* malloc-calloc always properly aligned */
 #else
-    U32 ctx[1U<<(MEMORY_USAGE-2)] = {0};           // Ensure data is aligned on 4-bytes boundaries
+    LZ4_stream_t ctx;
+    void* ctxPtr = &ctx;
 #endif
-    int result;
 
-    if (inputSize < (int)LZ4_64KLIMIT)
-        result = LZ4_compress_generic((void*)ctx, source, dest, inputSize, 0, notLimited, byU16, noPrefix);
-    else
-        result = LZ4_compress_generic((void*)ctx, source, dest, inputSize, 0, notLimited, (sizeof(void*)==8) ? byU32 : byPtr, noPrefix);
+    int result = LZ4_compress_fast_extState(ctxPtr, source, dest, inputSize, maxOutputSize, acceleration);
 
 #if (HEAPMODE)
-    FREEMEM(ctx);
+    FREEMEM(ctxPtr);
 #endif
     return result;
 }
 
-int LZ4_compress_continue (void* LZ4_Data, const char* source, char* dest, int inputSize)
+
+int LZ4_compress_default(const char* source, char* dest, int inputSize, int maxOutputSize)
+{
+    return LZ4_compress_fast(source, dest, inputSize, maxOutputSize, 1);
+}
+
+
+/* hidden debug function */
+/* strangely enough, gcc generates faster code when this function is uncommented, even if unused */
+int LZ4_compress_fast_force(const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
+{
+    LZ4_stream_t ctx;
+
+    LZ4_resetStream(&ctx);
+
+    if (inputSize < LZ4_64Klimit)
+        return LZ4_compress_generic(&ctx, source, dest, inputSize, maxOutputSize, limitedOutput, byU16,                        noDict, noDictIssue, acceleration);
+    else
+        return LZ4_compress_generic(&ctx, source, dest, inputSize, maxOutputSize, limitedOutput, LZ4_64bits() ? byU32 : byPtr, noDict, noDictIssue, acceleration);
+}
+
+
+/********************************
+*  destSize variant
+********************************/
+
+static int LZ4_compress_destSize_generic(
+                       void* const ctx,
+                 const char* const src,
+                       char* const dst,
+                       int*  const srcSizePtr,
+                 const int targetDstSize,
+                 const tableType_t tableType)
+{
+    const BYTE* ip = (const BYTE*) src;
+    const BYTE* base = (const BYTE*) src;
+    const BYTE* lowLimit = (const BYTE*) src;
+    const BYTE* anchor = ip;
+    const BYTE* const iend = ip + *srcSizePtr;
+    const BYTE* const mflimit = iend - MFLIMIT;
+    const BYTE* const matchlimit = iend - LASTLITERALS;
+
+    BYTE* op = (BYTE*) dst;
+    BYTE* const oend = op + targetDstSize;
+    BYTE* const oMaxLit = op + targetDstSize - 2 /* offset */ - 8 /* because 8+MINMATCH==MFLIMIT */ - 1 /* token */;
+    BYTE* const oMaxMatch = op + targetDstSize - (LASTLITERALS + 1 /* token */);
+    BYTE* const oMaxSeq = oMaxLit - 1 /* token */;
+
+    U32 forwardH;
+
+
+    /* Init conditions */
+    if (targetDstSize < 1) return 0;                                     /* Impossible to store anything */
+    if ((U32)*srcSizePtr > (U32)LZ4_MAX_INPUT_SIZE) return 0;            /* Unsupported input size, too large (or negative) */
+    if ((tableType == byU16) && (*srcSizePtr>=LZ4_64Klimit)) return 0;   /* Size too large (not within 64K limit) */
+    if (*srcSizePtr<LZ4_minLength) goto _last_literals;                  /* Input too small, no compression (all literals) */
+
+    /* First Byte */
+    *srcSizePtr = 0;
+    LZ4_putPosition(ip, ctx, tableType, base);
+    ip++; forwardH = LZ4_hashPosition(ip, tableType);
+
+    /* Main Loop */
+    for ( ; ; )
+    {
+        const BYTE* match;
+        BYTE* token;
+        {
+            const BYTE* forwardIp = ip;
+            unsigned step = 1;
+            unsigned searchMatchNb = 1 << LZ4_skipTrigger;
+
+            /* Find a match */
+            do {
+                U32 h = forwardH;
+                ip = forwardIp;
+                forwardIp += step;
+                step = (searchMatchNb++ >> LZ4_skipTrigger);
+
+                if (unlikely(forwardIp > mflimit))
+                    goto _last_literals;
+
+                match = LZ4_getPositionOnHash(h, ctx, tableType, base);
+                forwardH = LZ4_hashPosition(forwardIp, tableType);
+                LZ4_putPositionOnHash(ip, h, ctx, tableType, base);
+
+            } while ( ((tableType==byU16) ? 0 : (match + MAX_DISTANCE < ip))
+                || (LZ4_read32(match) != LZ4_read32(ip)) );
+        }
+
+        /* Catch up */
+        while ((ip>anchor) && (match > lowLimit) && (unlikely(ip[-1]==match[-1]))) { ip--; match--; }
+
+        {
+            /* Encode Literal length */
+            unsigned litLength = (unsigned)(ip - anchor);
+            token = op++;
+            if (op + ((litLength+240)/255) + litLength > oMaxLit)
+            {
+                /* Not enough space for a last match */
+                op--;
+                goto _last_literals;
+            }
+            if (litLength>=RUN_MASK)
+            {
+                unsigned len = litLength - RUN_MASK;
+                *token=(RUN_MASK<<ML_BITS);
+                for(; len >= 255 ; len-=255) *op++ = 255;
+                *op++ = (BYTE)len;
+            }
+            else *token = (BYTE)(litLength<<ML_BITS);
+
+            /* Copy Literals */
+            LZ4_wildCopy(op, anchor, op+litLength);
+            op += litLength;
+        }
+
+_next_match:
+        /* Encode Offset */
+        LZ4_writeLE16(op, (U16)(ip-match)); op+=2;
+
+        /* Encode MatchLength */
+        {
+            size_t matchLength;
+
+            matchLength = LZ4_count(ip+MINMATCH, match+MINMATCH, matchlimit);
+
+            if (op + ((matchLength+240)/255) > oMaxMatch)
+            {
+                /* Match description too long : reduce it */
+                matchLength = (15-1) + (oMaxMatch-op) * 255;
+            }
+            //printf("offset %5i, matchLength%5i \n", (int)(ip-match), matchLength + MINMATCH);
+            ip += MINMATCH + matchLength;
+
+            if (matchLength>=ML_MASK)
+            {
+                *token += ML_MASK;
+                matchLength -= ML_MASK;
+                while (matchLength >= 255) { matchLength-=255; *op++ = 255; }
+                *op++ = (BYTE)matchLength;
+            }
+            else *token += (BYTE)(matchLength);
+        }
+
+        anchor = ip;
+
+        /* Test end of block */
+        if (ip > mflimit) break;
+        if (op > oMaxSeq) break;
+
+        /* Fill table */
+        LZ4_putPosition(ip-2, ctx, tableType, base);
+
+        /* Test next position */
+        match = LZ4_getPosition(ip, ctx, tableType, base);
+        LZ4_putPosition(ip, ctx, tableType, base);
+        if ( (match+MAX_DISTANCE>=ip)
+            && (LZ4_read32(match)==LZ4_read32(ip)) )
+        { token=op++; *token=0; goto _next_match; }
+
+        /* Prepare next loop */
+        forwardH = LZ4_hashPosition(++ip, tableType);
+    }
+
+_last_literals:
+    /* Encode Last Literals */
+    {
+        size_t lastRunSize = (size_t)(iend - anchor);
+        if (op + 1 /* token */ + ((lastRunSize+240)/255) /* litLength */ + lastRunSize /* literals */ > oend)
+        {
+            /* adapt lastRunSize to fill 'dst' */
+            lastRunSize  = (oend-op) - 1;
+            lastRunSize -= (lastRunSize+240)/255;
+        }
+        ip = anchor + lastRunSize;
+
+        if (lastRunSize >= RUN_MASK)
+        {
+            size_t accumulator = lastRunSize - RUN_MASK;
+            *op++ = RUN_MASK << ML_BITS;
+            for(; accumulator >= 255 ; accumulator-=255) *op++ = 255;
+            *op++ = (BYTE) accumulator;
+        }
+        else
+        {
+            *op++ = (BYTE)(lastRunSize<<ML_BITS);
+        }
+        memcpy(op, anchor, lastRunSize);
+        op += lastRunSize;
+    }
+
+    /* End */
+    *srcSizePtr = (int) (((const char*)ip)-src);
+    return (int) (((char*)op)-dst);
+}
+
+
+static int LZ4_compress_destSize_extState (void* state, const char* src, char* dst, int* srcSizePtr, int targetDstSize)
 {
-    return LZ4_compress_generic(LZ4_Data, source, dest, inputSize, 0, notLimited, byU32, withPrefix);
+    LZ4_resetStream((LZ4_stream_t*)state);
+
+    if (targetDstSize >= LZ4_compressBound(*srcSizePtr))   /* compression success is guaranteed */
+    {
+        return LZ4_compress_fast_extState(state, src, dst, *srcSizePtr, targetDstSize, 1);
+    }
+    else
+    {
+        if (*srcSizePtr < LZ4_64Klimit)
+            return LZ4_compress_destSize_generic(state, src, dst, srcSizePtr, targetDstSize, byU16);
+        else
+            return LZ4_compress_destSize_generic(state, src, dst, srcSizePtr, targetDstSize, LZ4_64bits() ? byU32 : byPtr);
+    }
 }
 
 
-int LZ4_compress_limitedOutput(const char* source, char* dest, int inputSize, int maxOutputSize)
+int LZ4_compress_destSize(const char* src, char* dst, int* srcSizePtr, int targetDstSize)
 {
 #if (HEAPMODE)
-    void* ctx = ALLOCATOR(HASHNBCELLS4, 4);   // Aligned on 4-bytes boundaries
+    void* ctx = ALLOCATOR(1, sizeof(LZ4_stream_t));   /* malloc-calloc always properly aligned */
 #else
-    U32 ctx[1U<<(MEMORY_USAGE-2)] = {0};           // Ensure data is aligned on 4-bytes boundaries
+    LZ4_stream_t ctxBody;
+    void* ctx = &ctxBody;
 #endif
-    int result;
 
-    if (inputSize < (int)LZ4_64KLIMIT)
-        result = LZ4_compress_generic((void*)ctx, source, dest, inputSize, maxOutputSize, limited, byU16, noPrefix);
-    else
-        result = LZ4_compress_generic((void*)ctx, source, dest, inputSize, maxOutputSize, limited, (sizeof(void*)==8) ? byU32 : byPtr, noPrefix);
+    int result = LZ4_compress_destSize_extState(ctx, src, dst, srcSizePtr, targetDstSize);
 
 #if (HEAPMODE)
     FREEMEM(ctx);
@@ -600,231 +933,592 @@ int LZ4_compress_limitedOutput(const char* source, char* dest, int inputSize, in
     return result;
 }
 
-int LZ4_compress_limitedOutput_continue (void* LZ4_Data, const char* source, char* dest, int inputSize, int maxOutputSize)
+
+
+/********************************
+*  Streaming functions
+********************************/
+
+LZ4_stream_t* LZ4_createStream(void)
 {
-    return LZ4_compress_generic(LZ4_Data, source, dest, inputSize, maxOutputSize, limited, byU32, withPrefix);
+    LZ4_stream_t* lz4s = (LZ4_stream_t*)ALLOCATOR(8, LZ4_STREAMSIZE_U64);
+    LZ4_STATIC_ASSERT(LZ4_STREAMSIZE >= sizeof(LZ4_stream_t_internal));    /* A compilation error here means LZ4_STREAMSIZE is not large enough */
+    LZ4_resetStream(lz4s);
+    return lz4s;
 }
 
+void LZ4_resetStream (LZ4_stream_t* LZ4_stream)
+{
+    MEM_INIT(LZ4_stream, 0, sizeof(LZ4_stream_t));
+}
 
-//****************************
-// Stream functions
-//****************************
-
-FORCE_INLINE void LZ4_init(LZ4_Data_Structure* lz4ds, const BYTE* base)
+int LZ4_freeStream (LZ4_stream_t* LZ4_stream)
 {
-    MEM_INIT(lz4ds->hashTable, 0, sizeof(lz4ds->hashTable));
-    lz4ds->bufferStart = base;
-    lz4ds->base = base;
-    lz4ds->nextBlock = base;
+    FREEMEM(LZ4_stream);
+    return (0);
 }
 
 
-void* LZ4_create (const char* inputBuffer)
+#define HASH_UNIT sizeof(size_t)
+int LZ4_loadDict (LZ4_stream_t* LZ4_dict, const char* dictionary, int dictSize)
 {
-    void* lz4ds = ALLOCATOR(1, sizeof(LZ4_Data_Structure));
-    LZ4_init ((LZ4_Data_Structure*)lz4ds, (const BYTE*)inputBuffer);
-    return lz4ds;
+    LZ4_stream_t_internal* dict = (LZ4_stream_t_internal*) LZ4_dict;
+    const BYTE* p = (const BYTE*)dictionary;
+    const BYTE* const dictEnd = p + dictSize;
+    const BYTE* base;
+
+    if ((dict->initCheck) || (dict->currentOffset > 1 GB))  /* Uninitialized structure, or reuse overflow */
+        LZ4_resetStream(LZ4_dict);
+
+    if (dictSize < (int)HASH_UNIT)
+    {
+        dict->dictionary = NULL;
+        dict->dictSize = 0;
+        return 0;
+    }
+
+    if ((dictEnd - p) > 64 KB) p = dictEnd - 64 KB;
+    dict->currentOffset += 64 KB;
+    base = p - dict->currentOffset;
+    dict->dictionary = p;
+    dict->dictSize = (U32)(dictEnd - p);
+    dict->currentOffset += dict->dictSize;
+
+    while (p <= dictEnd-HASH_UNIT)
+    {
+        LZ4_putPosition(p, dict->hashTable, byU32, base);
+        p+=3;
+    }
+
+    return dict->dictSize;
 }
 
 
-int LZ4_free (void* LZ4_Data)
+static void LZ4_renormDictT(LZ4_stream_t_internal* LZ4_dict, const BYTE* src)
 {
-    FREEMEM(LZ4_Data);
-    return (0);
+    if ((LZ4_dict->currentOffset > 0x80000000) ||
+        ((size_t)LZ4_dict->currentOffset > (size_t)src))   /* address space overflow */
+    {
+        /* rescale hash table */
+        U32 delta = LZ4_dict->currentOffset - 64 KB;
+        const BYTE* dictEnd = LZ4_dict->dictionary + LZ4_dict->dictSize;
+        int i;
+        for (i=0; i<HASH_SIZE_U32; i++)
+        {
+            if (LZ4_dict->hashTable[i] < delta) LZ4_dict->hashTable[i]=0;
+            else LZ4_dict->hashTable[i] -= delta;
+        }
+        LZ4_dict->currentOffset = 64 KB;
+        if (LZ4_dict->dictSize > 64 KB) LZ4_dict->dictSize = 64 KB;
+        LZ4_dict->dictionary = dictEnd - LZ4_dict->dictSize;
+    }
 }
 
 
-char* LZ4_slideInputBuffer (void* LZ4_Data)
+int LZ4_compress_fast_continue (LZ4_stream_t* LZ4_stream, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
 {
-    LZ4_Data_Structure* lz4ds = (LZ4_Data_Structure*)LZ4_Data;
-    size_t delta = lz4ds->nextBlock - (lz4ds->bufferStart + 64 KB);
+    LZ4_stream_t_internal* streamPtr = (LZ4_stream_t_internal*)LZ4_stream;
+    const BYTE* const dictEnd = streamPtr->dictionary + streamPtr->dictSize;
 
-    if ( (lz4ds->base - delta > lz4ds->base)                          // underflow control
-       || ((size_t)(lz4ds->nextBlock - lz4ds->base) > 0xE0000000) )   // close to 32-bits limit
-    {
-        size_t deltaLimit = (lz4ds->nextBlock - 64 KB) - lz4ds->base;
-        int nH;
+    const BYTE* smallest = (const BYTE*) source;
+    if (streamPtr->initCheck) return 0;   /* Uninitialized structure detected */
+    if ((streamPtr->dictSize>0) && (smallest>dictEnd)) smallest = dictEnd;
+    LZ4_renormDictT(streamPtr, smallest);
+    if (acceleration < 1) acceleration = ACCELERATION_DEFAULT;
 
-        for (nH=0; nH < HASHNBCELLS4; nH++)
+    /* Check overlapping input/dictionary space */
+    {
+        const BYTE* sourceEnd = (const BYTE*) source + inputSize;
+        if ((sourceEnd > streamPtr->dictionary) && (sourceEnd < dictEnd))
         {
-            if ((size_t)(lz4ds->hashTable[nH]) < deltaLimit) lz4ds->hashTable[nH] = 0;
-            else lz4ds->hashTable[nH] -= (U32)deltaLimit;
+            streamPtr->dictSize = (U32)(dictEnd - sourceEnd);
+            if (streamPtr->dictSize > 64 KB) streamPtr->dictSize = 64 KB;
+            if (streamPtr->dictSize < 4) streamPtr->dictSize = 0;
+            streamPtr->dictionary = dictEnd - streamPtr->dictSize;
         }
-        memcpy((void*)(lz4ds->bufferStart), (const void*)(lz4ds->nextBlock - 64 KB), 64 KB);
-        lz4ds->base = lz4ds->bufferStart;
-        lz4ds->nextBlock = lz4ds->base + 64 KB;
     }
-    else
+
+    /* prefix mode : source data follows dictionary */
+    if (dictEnd == (const BYTE*)source)
+    {
+        int result;
+        if ((streamPtr->dictSize < 64 KB) && (streamPtr->dictSize < streamPtr->currentOffset))
+            result = LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, withPrefix64k, dictSmall, acceleration);
+        else
+            result = LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, withPrefix64k, noDictIssue, acceleration);
+        streamPtr->dictSize += (U32)inputSize;
+        streamPtr->currentOffset += (U32)inputSize;
+        return result;
+    }
+
+    /* external dictionary mode */
     {
-        memcpy((void*)(lz4ds->bufferStart), (const void*)(lz4ds->nextBlock - 64 KB), 64 KB);
-        lz4ds->nextBlock -= delta;
-        lz4ds->base -= delta;
+        int result;
+        if ((streamPtr->dictSize < 64 KB) && (streamPtr->dictSize < streamPtr->currentOffset))
+            result = LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, usingExtDict, dictSmall, acceleration);
+        else
+            result = LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, usingExtDict, noDictIssue, acceleration);
+        streamPtr->dictionary = (const BYTE*)source;
+        streamPtr->dictSize = (U32)inputSize;
+        streamPtr->currentOffset += (U32)inputSize;
+        return result;
     }
+}
+
+
+/* Hidden debug function, to force external dictionary mode */
+int LZ4_compress_forceExtDict (LZ4_stream_t* LZ4_dict, const char* source, char* dest, int inputSize)
+{
+    LZ4_stream_t_internal* streamPtr = (LZ4_stream_t_internal*)LZ4_dict;
+    int result;
+    const BYTE* const dictEnd = streamPtr->dictionary + streamPtr->dictSize;
 
-    return (char*)(lz4ds->nextBlock);
+    const BYTE* smallest = dictEnd;
+    if (smallest > (const BYTE*) source) smallest = (const BYTE*) source;
+    LZ4_renormDictT((LZ4_stream_t_internal*)LZ4_dict, smallest);
+
+    result = LZ4_compress_generic(LZ4_dict, source, dest, inputSize, 0, notLimited, byU32, usingExtDict, noDictIssue, 1);
+
+    streamPtr->dictionary = (const BYTE*)source;
+    streamPtr->dictSize = (U32)inputSize;
+    streamPtr->currentOffset += (U32)inputSize;
+
+    return result;
 }
 
 
-//****************************
-// Decompression functions
-//****************************
+int LZ4_saveDict (LZ4_stream_t* LZ4_dict, char* safeBuffer, int dictSize)
+{
+    LZ4_stream_t_internal* dict = (LZ4_stream_t_internal*) LZ4_dict;
+    const BYTE* previousDictEnd = dict->dictionary + dict->dictSize;
+
+    if ((U32)dictSize > 64 KB) dictSize = 64 KB;   /* useless to define a dictionary > 64 KB */
+    if ((U32)dictSize > dict->dictSize) dictSize = dict->dictSize;
 
-// This generic decompression function cover all use cases.
-// It shall be instanciated several times, using different sets of directives
-// Note that it is essential this generic function is really inlined,
-// in order to remove useless branches during compilation optimisation.
+    memmove(safeBuffer, previousDictEnd - dictSize, dictSize);
+
+    dict->dictionary = (const BYTE*)safeBuffer;
+    dict->dictSize = (U32)dictSize;
+
+    return dictSize;
+}
+
+
+
+/*******************************
+*  Decompression functions
+*******************************/
+/*
+ * This generic decompression function cover all use cases.
+ * It shall be instantiated several times, using different sets of directives
+ * Note that it is essential this generic function is really inlined,
+ * in order to remove useless branches during compilation optimization.
+ */
 FORCE_INLINE int LZ4_decompress_generic(
-                 const char* source,
-                 char* dest,
-                 int inputSize,          //
-                 int outputSize,         // If endOnInput==endOnInputSize, this value is the max size of Output Buffer.
-
-                 int endOnInput,         // endOnOutputSize, endOnInputSize
-                 int prefix64k,          // noPrefix, withPrefix
-                 int partialDecoding,    // full, partial
-                 int targetOutputSize    // only used if partialDecoding==partial
+                 const char* const source,
+                 char* const dest,
+                 int inputSize,
+                 int outputSize,         /* If endOnInput==endOnInputSize, this value is the max size of Output Buffer. */
+
+                 int endOnInput,         /* endOnOutputSize, endOnInputSize */
+                 int partialDecoding,    /* full, partial */
+                 int targetOutputSize,   /* only used if partialDecoding==partial */
+                 int dict,               /* noDict, withPrefix64k, usingExtDict */
+                 const BYTE* const lowPrefix,  /* == dest if dict == noDict */
+                 const BYTE* const dictStart,  /* only if dict==usingExtDict */
+                 const size_t dictSize         /* note : = 0 if noDict */
                  )
 {
-    // Local Variables
-    const BYTE* restrict ip = (const BYTE*) source;
-    const BYTE* ref;
+    /* Local Variables */
+    const BYTE* ip = (const BYTE*) source;
     const BYTE* const iend = ip + inputSize;
 
     BYTE* op = (BYTE*) dest;
     BYTE* const oend = op + outputSize;
     BYTE* cpy;
     BYTE* oexit = op + targetOutputSize;
+    const BYTE* const lowLimit = lowPrefix - dictSize;
 
-    const size_t dec32table[] = {0, 3, 2, 3, 0, 0, 0, 0};   // static reduces speed for LZ4_decompress_safe() on GCC64
-    static const size_t dec64table[] = {0, 0, 0, (size_t)-1, 0, 1, 2, 3};
+    const BYTE* const dictEnd = (const BYTE*)dictStart + dictSize;
+    const size_t dec32table[] = {4, 1, 2, 1, 4, 4, 4, 4};
+    const size_t dec64table[] = {0, 0, 0, (size_t)-1, 0, 1, 2, 3};
 
+    const int safeDecode = (endOnInput==endOnInputSize);
+    const int checkOffset = ((safeDecode) && (dictSize < (int)(64 KB)));
 
-    // Special cases
-    if ((partialDecoding) && (oexit> oend-MFLIMIT)) oexit = oend-MFLIMIT;                        // targetOutputSize too high => decode everything
-    if ((endOnInput) && unlikely(outputSize==0)) return ((inputSize==1) && (*ip==0)) ? 0 : -1;   // Empty output buffer
-    if ((!endOnInput) && unlikely(outputSize==0)) return (*ip==0?1:-1);
 
+    /* Special cases */
+    if ((partialDecoding) && (oexit> oend-MFLIMIT)) oexit = oend-MFLIMIT;                         /* targetOutputSize too high => decode everything */
+    if ((endOnInput) && (unlikely(outputSize==0))) return ((inputSize==1) && (*ip==0)) ? 0 : -1;  /* Empty output buffer */
+    if ((!endOnInput) && (unlikely(outputSize==0))) return (*ip==0?1:-1);
 
-    // Main Loop
+
+    /* Main Loop */
     while (1)
     {
         unsigned token;
         size_t length;
+        const BYTE* match;
 
-        // get runlength
+        /* get literal length */
         token = *ip++;
         if ((length=(token>>ML_BITS)) == RUN_MASK)
         {
-            unsigned s=255;
-            while (((endOnInput)?ip<iend:1) && (s==255))
+            unsigned s;
+            do
             {
                 s = *ip++;
                 length += s;
             }
+            while (likely((endOnInput)?ip<iend-RUN_MASK:1) && (s==255));
+            if ((safeDecode) && unlikely((size_t)(op+length)<(size_t)(op))) goto _output_error;   /* overflow detection */
+            if ((safeDecode) && unlikely((size_t)(ip+length)<(size_t)(ip))) goto _output_error;   /* overflow detection */
         }
 
-        // copy literals
+        /* copy literals */
         cpy = op+length;
         if (((endOnInput) && ((cpy>(partialDecoding?oexit:oend-MFLIMIT)) || (ip+length>iend-(2+1+LASTLITERALS))) )
             || ((!endOnInput) && (cpy>oend-COPYLENGTH)))
         {
             if (partialDecoding)
             {
-                if (cpy > oend) goto _output_error;                           // Error : write attempt beyond end of output buffer
-                if ((endOnInput) && (ip+length > iend)) goto _output_error;   // Error : read attempt beyond end of input buffer
+                if (cpy > oend) goto _output_error;                           /* Error : write attempt beyond end of output buffer */
+                if ((endOnInput) && (ip+length > iend)) goto _output_error;   /* Error : read attempt beyond end of input buffer */
             }
             else
             {
-                if ((!endOnInput) && (cpy != oend)) goto _output_error;       // Error : block decoding must stop exactly there
-                if ((endOnInput) && ((ip+length != iend) || (cpy > oend))) goto _output_error;   // Error : input must be consumed
+                if ((!endOnInput) && (cpy != oend)) goto _output_error;       /* Error : block decoding must stop exactly there */
+                if ((endOnInput) && ((ip+length != iend) || (cpy > oend))) goto _output_error;   /* Error : input must be consumed */
             }
             memcpy(op, ip, length);
             ip += length;
             op += length;
-            break;                                       // Necessarily EOF, due to parsing restrictions
+            break;     /* Necessarily EOF, due to parsing restrictions */
         }
-        LZ4_WILDCOPY(op, ip, cpy); ip -= (op-cpy); op = cpy;
+        LZ4_wildCopy(op, ip, cpy);
+        ip += length; op = cpy;
 
-        // get offset
-        LZ4_READ_LITTLEENDIAN_16(ref,cpy,ip); ip+=2;
-        if ((prefix64k==noPrefix) && unlikely(ref < (BYTE* const)dest)) goto _output_error;   // Error : offset outside destination buffer
+        /* get offset */
+        match = cpy - LZ4_readLE16(ip); ip+=2;
+        if ((checkOffset) && (unlikely(match < lowLimit))) goto _output_error;   /* Error : offset outside destination buffer */
 
-        // get matchlength
-        if ((length=(token&ML_MASK)) == ML_MASK)
+        /* get matchlength */
+        length = token & ML_MASK;
+        if (length == ML_MASK)
         {
-            while ((!endOnInput) || (ip<iend-(LASTLITERALS+1)))   // Ensure enough bytes remain for LASTLITERALS + token
+            unsigned s;
+            do
             {
-                unsigned s = *ip++;
+                if ((endOnInput) && (ip > iend-LASTLITERALS)) goto _output_error;
+                s = *ip++;
                 length += s;
-                if (s==255) continue;
-                break;
+            } while (s==255);
+            if ((safeDecode) && unlikely((size_t)(op+length)<(size_t)op)) goto _output_error;   /* overflow detection */
+        }
+        length += MINMATCH;
+
+        /* check external dictionary */
+        if ((dict==usingExtDict) && (match < lowPrefix))
+        {
+            if (unlikely(op+length > oend-LASTLITERALS)) goto _output_error;   /* doesn't respect parsing restriction */
+
+            if (length <= (size_t)(lowPrefix-match))
+            {
+                /* match can be copied as a single segment from external dictionary */
+                match = dictEnd - (lowPrefix-match);
+                memmove(op, match, length); op += length;
+            }
+            else
+            {
+                /* match encompass external dictionary and current segment */
+                size_t copySize = (size_t)(lowPrefix-match);
+                memcpy(op, dictEnd - copySize, copySize);
+                op += copySize;
+                copySize = length - copySize;
+                if (copySize > (size_t)(op-lowPrefix))   /* overlap within current segment */
+                {
+                    BYTE* const endOfMatch = op + copySize;
+                    const BYTE* copyFrom = lowPrefix;
+                    while (op < endOfMatch) *op++ = *copyFrom++;
+                }
+                else
+                {
+                    memcpy(op, lowPrefix, copySize);
+                    op += copySize;
+                }
             }
+            continue;
         }
 
-        // copy repeated sequence
-        if unlikely((op-ref)<(int)STEPSIZE)
+        /* copy repeated sequence */
+        cpy = op + length;
+        if (unlikely((op-match)<8))
         {
-            const size_t dec64 = dec64table[(sizeof(void*)==4) ? 0 : op-ref];
-            op[0] = ref[0];
-            op[1] = ref[1];
-            op[2] = ref[2];
-            op[3] = ref[3];
-            op += 4, ref += 4; ref -= dec32table[op-ref];
-            A32(op) = A32(ref);
-            op += STEPSIZE-4; ref -= dec64;
-        } else { LZ4_COPYSTEP(op,ref); }
-        cpy = op + length - (STEPSIZE-4);
-
-        if unlikely(cpy>oend-COPYLENGTH-(STEPSIZE-4))
+            const size_t dec64 = dec64table[op-match];
+            op[0] = match[0];
+            op[1] = match[1];
+            op[2] = match[2];
+            op[3] = match[3];
+            match += dec32table[op-match];
+            LZ4_copy4(op+4, match);
+            op += 8; match -= dec64;
+        } else { LZ4_copy8(op, match); op+=8; match+=8; }
+
+        if (unlikely(cpy>oend-12))
         {
-            if (cpy > oend-LASTLITERALS) goto _output_error;    // Error : last 5 bytes must be literals
-            LZ4_SECURECOPY(op, ref, (oend-COPYLENGTH));
-            while(op<cpy) *op++=*ref++;
-            op=cpy;
-            continue;
+            if (cpy > oend-LASTLITERALS) goto _output_error;    /* Error : last LASTLITERALS bytes must be literals */
+            if (op < oend-8)
+            {
+                LZ4_wildCopy(op, match, oend-8);
+                match += (oend-8) - op;
+                op = oend-8;
+            }
+            while (op<cpy) *op++ = *match++;
         }
-        LZ4_WILDCOPY(op, ref, cpy);
-        op=cpy;   // correction
+        else
+            LZ4_wildCopy(op, match, cpy);
+        op=cpy;   /* correction */
     }
 
-    // end of decoding
+    /* end of decoding */
     if (endOnInput)
-       return (int) (((char*)op)-dest);     // Nb of output bytes decoded
+       return (int) (((char*)op)-dest);     /* Nb of output bytes decoded */
     else
-       return (int) (((char*)ip)-source);   // Nb of input bytes read
+       return (int) (((const char*)ip)-source);   /* Nb of input bytes read */
 
-    // Overflow error detected
+    /* Overflow error detected */
 _output_error:
-    return (int) (-(((char*)ip)-source))-1;
+    return (int) (-(((const char*)ip)-source))-1;
 }
 
 
-int LZ4_decompress_safe(const char* source, char* dest, int inputSize, int maxOutputSize)
+int LZ4_decompress_safe(const char* source, char* dest, int compressedSize, int maxDecompressedSize)
 {
-    return LZ4_decompress_generic(source, dest, inputSize, maxOutputSize, endOnInputSize, noPrefix, full, 0);
+    return LZ4_decompress_generic(source, dest, compressedSize, maxDecompressedSize, endOnInputSize, full, 0, noDict, (BYTE*)dest, NULL, 0);
 }
 
-int LZ4_decompress_safe_withPrefix64k(const char* source, char* dest, int inputSize, int maxOutputSize)
+int LZ4_decompress_safe_partial(const char* source, char* dest, int compressedSize, int targetOutputSize, int maxDecompressedSize)
 {
-    return LZ4_decompress_generic(source, dest, inputSize, maxOutputSize, endOnInputSize, withPrefix, full, 0);
+    return LZ4_decompress_generic(source, dest, compressedSize, maxDecompressedSize, endOnInputSize, partial, targetOutputSize, noDict, (BYTE*)dest, NULL, 0);
 }
 
-int LZ4_decompress_safe_partial(const char* source, char* dest, int inputSize, int targetOutputSize, int maxOutputSize)
+int LZ4_decompress_fast(const char* source, char* dest, int originalSize)
 {
-    return LZ4_decompress_generic(source, dest, inputSize, maxOutputSize, endOnInputSize, noPrefix, partial, targetOutputSize);
+    return LZ4_decompress_generic(source, dest, 0, originalSize, endOnOutputSize, full, 0, withPrefix64k, (BYTE*)(dest - 64 KB), NULL, 64 KB);
 }
 
-int LZ4_decompress_fast_withPrefix64k(const char* source, char* dest, int outputSize)
+
+/* streaming decompression functions */
+
+typedef struct
 {
-    return LZ4_decompress_generic(source, dest, 0, outputSize, endOnOutputSize, withPrefix, full, 0);
+    const BYTE* externalDict;
+    size_t extDictSize;
+    const BYTE* prefixEnd;
+    size_t prefixSize;
+} LZ4_streamDecode_t_internal;
+
+/*
+ * If you prefer dynamic allocation methods,
+ * LZ4_createStreamDecode()
+ * provides a pointer (void*) towards an initialized LZ4_streamDecode_t structure.
+ */
+LZ4_streamDecode_t* LZ4_createStreamDecode(void)
+{
+    LZ4_streamDecode_t* lz4s = (LZ4_streamDecode_t*) ALLOCATOR(1, sizeof(LZ4_streamDecode_t));
+    return lz4s;
 }
 
-int LZ4_decompress_fast(const char* source, char* dest, int outputSize)
+int LZ4_freeStreamDecode (LZ4_streamDecode_t* LZ4_stream)
 {
-#ifdef _MSC_VER   // This version is faster with Visual
-    return LZ4_decompress_generic(source, dest, 0, outputSize, endOnOutputSize, noPrefix, full, 0);
-#else
-    return LZ4_decompress_generic(source, dest, 0, outputSize, endOnOutputSize, withPrefix, full, 0);
-#endif
+    FREEMEM(LZ4_stream);
+    return 0;
 }
-#endif
+
+/*
+ * LZ4_setStreamDecode
+ * Use this function to instruct where to find the dictionary
+ * This function is not necessary if previous data is still available where it was decoded.
+ * Loading a size of 0 is allowed (same effect as no dictionary).
+ * Return : 1 if OK, 0 if error
+ */
+int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dictionary, int dictSize)
+{
+    LZ4_streamDecode_t_internal* lz4sd = (LZ4_streamDecode_t_internal*) LZ4_streamDecode;
+    lz4sd->prefixSize = (size_t) dictSize;
+    lz4sd->prefixEnd = (const BYTE*) dictionary + dictSize;
+    lz4sd->externalDict = NULL;
+    lz4sd->extDictSize  = 0;
+    return 1;
+}
+
+/*
+*_continue() :
+    These decoding functions allow decompression of multiple blocks in "streaming" mode.
+    Previously decoded blocks must still be available at the memory position where they were decoded.
+    If it's not possible, save the relevant part of decoded data into a safe buffer,
+    and indicate where it stands using LZ4_setStreamDecode()
+*/
+int LZ4_decompress_safe_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int compressedSize, int maxOutputSize)
+{
+    LZ4_streamDecode_t_internal* lz4sd = (LZ4_streamDecode_t_internal*) LZ4_streamDecode;
+    int result;
+
+    if (lz4sd->prefixEnd == (BYTE*)dest)
+    {
+        result = LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize,
+                                        endOnInputSize, full, 0,
+                                        usingExtDict, lz4sd->prefixEnd - lz4sd->prefixSize, lz4sd->externalDict, lz4sd->extDictSize);
+        if (result <= 0) return result;
+        lz4sd->prefixSize += result;
+        lz4sd->prefixEnd  += result;
+    }
+    else
+    {
+        lz4sd->extDictSize = lz4sd->prefixSize;
+        lz4sd->externalDict = lz4sd->prefixEnd - lz4sd->extDictSize;
+        result = LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize,
+                                        endOnInputSize, full, 0,
+                                        usingExtDict, (BYTE*)dest, lz4sd->externalDict, lz4sd->extDictSize);
+        if (result <= 0) return result;
+        lz4sd->prefixSize = result;
+        lz4sd->prefixEnd  = (BYTE*)dest + result;
+    }
+
+    return result;
+}
+
+int LZ4_decompress_fast_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int originalSize)
+{
+    LZ4_streamDecode_t_internal* lz4sd = (LZ4_streamDecode_t_internal*) LZ4_streamDecode;
+    int result;
+
+    if (lz4sd->prefixEnd == (BYTE*)dest)
+    {
+        result = LZ4_decompress_generic(source, dest, 0, originalSize,
+                                        endOnOutputSize, full, 0,
+                                        usingExtDict, lz4sd->prefixEnd - lz4sd->prefixSize, lz4sd->externalDict, lz4sd->extDictSize);
+        if (result <= 0) return result;
+        lz4sd->prefixSize += originalSize;
+        lz4sd->prefixEnd  += originalSize;
+    }
+    else
+    {
+        lz4sd->extDictSize = lz4sd->prefixSize;
+        lz4sd->externalDict = (BYTE*)dest - lz4sd->extDictSize;
+        result = LZ4_decompress_generic(source, dest, 0, originalSize,
+                                        endOnOutputSize, full, 0,
+                                        usingExtDict, (BYTE*)dest, lz4sd->externalDict, lz4sd->extDictSize);
+        if (result <= 0) return result;
+        lz4sd->prefixSize = originalSize;
+        lz4sd->prefixEnd  = (BYTE*)dest + originalSize;
+    }
+
+    return result;
+}
+
+
+/*
+Advanced decoding functions :
+*_usingDict() :
+    These decoding functions work the same as "_continue" ones,
+    the dictionary must be explicitly provided within parameters
+*/
+
+FORCE_INLINE int LZ4_decompress_usingDict_generic(const char* source, char* dest, int compressedSize, int maxOutputSize, int safe, const char* dictStart, int dictSize)
+{
+    if (dictSize==0)
+        return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, noDict, (BYTE*)dest, NULL, 0);
+    if (dictStart+dictSize == dest)
+    {
+        if (dictSize >= (int)(64 KB - 1))
+            return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, withPrefix64k, (BYTE*)dest-64 KB, NULL, 0);
+        return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, noDict, (BYTE*)dest-dictSize, NULL, 0);
+    }
+    return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, usingExtDict, (BYTE*)dest, (const BYTE*)dictStart, dictSize);
+}
+
+int LZ4_decompress_safe_usingDict(const char* source, char* dest, int compressedSize, int maxOutputSize, const char* dictStart, int dictSize)
+{
+    return LZ4_decompress_usingDict_generic(source, dest, compressedSize, maxOutputSize, 1, dictStart, dictSize);
+}
+
+int LZ4_decompress_fast_usingDict(const char* source, char* dest, int originalSize, const char* dictStart, int dictSize)
+{
+    return LZ4_decompress_usingDict_generic(source, dest, 0, originalSize, 0, dictStart, dictSize);
+}
+
+/* debug function */
+int LZ4_decompress_safe_forceExtDict(const char* source, char* dest, int compressedSize, int maxOutputSize, const char* dictStart, int dictSize)
+{
+    return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, endOnInputSize, full, 0, usingExtDict, (BYTE*)dest, (const BYTE*)dictStart, dictSize);
+}
+
+
+/***************************************************
+*  Obsolete Functions
+***************************************************/
+/* obsolete compression functions */
+int LZ4_compress_limitedOutput(const char* source, char* dest, int inputSize, int maxOutputSize) { return LZ4_compress_default(source, dest, inputSize, maxOutputSize); }
+int LZ4_compress(const char* source, char* dest, int inputSize) { return LZ4_compress_default(source, dest, inputSize, LZ4_compressBound(inputSize)); }
+int LZ4_compress_limitedOutput_withState (void* state, const char* src, char* dst, int srcSize, int dstSize) { return LZ4_compress_fast_extState(state, src, dst, srcSize, dstSize, 1); }
+int LZ4_compress_withState (void* state, const char* src, char* dst, int srcSize) { return LZ4_compress_fast_extState(state, src, dst, srcSize, LZ4_compressBound(srcSize), 1); }
+int LZ4_compress_limitedOutput_continue (LZ4_stream_t* LZ4_stream, const char* src, char* dst, int srcSize, int maxDstSize) { return LZ4_compress_fast_continue(LZ4_stream, src, dst, srcSize, maxDstSize, 1); }
+int LZ4_compress_continue (LZ4_stream_t* LZ4_stream, const char* source, char* dest, int inputSize) { return LZ4_compress_fast_continue(LZ4_stream, source, dest, inputSize, LZ4_compressBound(inputSize), 1); }
+
+/*
+These function names are deprecated and should no longer be used.
+They are only provided here for compatibility with older user programs.
+- LZ4_uncompress is totally equivalent to LZ4_decompress_fast
+- LZ4_uncompress_unknownOutputSize is totally equivalent to LZ4_decompress_safe
+*/
+int LZ4_uncompress (const char* source, char* dest, int outputSize) { return LZ4_decompress_fast(source, dest, outputSize); }
+int LZ4_uncompress_unknownOutputSize (const char* source, char* dest, int isize, int maxOutputSize) { return LZ4_decompress_safe(source, dest, isize, maxOutputSize); }
+
+
+/* Obsolete Streaming functions */
+
+int LZ4_sizeofStreamState() { return LZ4_STREAMSIZE; }
+
+static void LZ4_init(LZ4_stream_t_internal* lz4ds, BYTE* base)
+{
+    MEM_INIT(lz4ds, 0, LZ4_STREAMSIZE);
+    lz4ds->bufferStart = base;
+}
+
+int LZ4_resetStreamState(void* state, char* inputBuffer)
+{
+    if ((((size_t)state) & 3) != 0) return 1;   /* Error : pointer is not aligned on 4-bytes boundary */
+    LZ4_init((LZ4_stream_t_internal*)state, (BYTE*)inputBuffer);
+    return 0;
+}
+
+void* LZ4_create (char* inputBuffer)
+{
+    void* lz4ds = ALLOCATOR(8, LZ4_STREAMSIZE_U64);
+    LZ4_init ((LZ4_stream_t_internal*)lz4ds, (BYTE*)inputBuffer);
+    return lz4ds;
+}
+
+char* LZ4_slideInputBuffer (void* LZ4_Data)
+{
+    LZ4_stream_t_internal* ctx = (LZ4_stream_t_internal*)LZ4_Data;
+    int dictSize = LZ4_saveDict((LZ4_stream_t*)LZ4_Data, (char*)ctx->bufferStart, 64 KB);
+    return (char*)(ctx->bufferStart + dictSize);
+}
+
+/* Obsolete streaming decompression functions */
+
+int LZ4_decompress_safe_withPrefix64k(const char* source, char* dest, int compressedSize, int maxOutputSize)
+{
+    return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, endOnInputSize, full, 0, withPrefix64k, (BYTE*)dest - 64 KB, NULL, 64 KB);
+}
+
+int LZ4_decompress_fast_withPrefix64k(const char* source, char* dest, int originalSize)
+{
+    return LZ4_decompress_generic(source, dest, 0, originalSize, endOnOutputSize, full, 0, withPrefix64k, (BYTE*)dest - 64 KB, NULL, 64 KB);
+}
+
+#endif   /* LZ4_COMMONDEFS_ONLY */
+
+#endif /* NEED_COMPAT_LZ4 */
diff --git a/src/compat/compat-lz4.h b/src/compat/compat-lz4.h
index a289fcf..3e74002 100644
--- a/src/compat/compat-lz4.h
+++ b/src/compat/compat-lz4.h
@@ -1,7 +1,8 @@
 /*
    LZ4 - Fast LZ compression algorithm
    Header File
-   Copyright (C) 2011-2013, Yann Collet.
+   Copyright (C) 2011-2015, Yann Collet.
+
    BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
 
    Redistribution and use in source and binary forms, with or without
@@ -28,8 +29,8 @@
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
    You can contact the author at :
-   - LZ4 homepage : http://fastcompression.blogspot.com/p/lz4.html
-   - LZ4 source repository : http://code.google.com/p/lz4/
+   - LZ4 source repository : https://github.com/Cyan4973/lz4
+   - LZ4 public forum : https://groups.google.com/forum/#!forum/lz4c
 */
 #pragma once
 
@@ -37,167 +38,321 @@
 extern "C" {
 #endif
 
+/*
+ * lz4.h provides block compression functions, and gives full buffer control to programmer.
+ * If you need to generate inter-operable compressed data (respecting LZ4 frame specification),
+ * and can let the library handle its own memory, please use lz4frame.h instead.
+*/
 
-//**************************************
-// Compiler Options
-//**************************************
-#if defined(_MSC_VER) && !defined(__cplusplus)   // Visual Studio
-#  define inline __inline           // Visual C is not C99, but supports some kind of inline
-#endif
+/**************************************
+*  Version
+**************************************/
+#define LZ4_VERSION_MAJOR    1    /* for breaking interface changes  */
+#define LZ4_VERSION_MINOR    7    /* for new (non-breaking) interface capabilities */
+#define LZ4_VERSION_RELEASE  1    /* for tweaks, bug-fixes, or development */
+#define LZ4_VERSION_NUMBER (LZ4_VERSION_MAJOR *100*100 + LZ4_VERSION_MINOR *100 + LZ4_VERSION_RELEASE)
+int LZ4_versionNumber (void);
+
+/**************************************
+*  Tuning parameter
+**************************************/
+/*
+ * LZ4_MEMORY_USAGE :
+ * Memory usage formula : N->2^N Bytes (examples : 10 -> 1KB; 12 -> 4KB ; 16 -> 64KB; 20 -> 1MB; etc.)
+ * Increasing memory usage improves compression ratio
+ * Reduced memory usage can improve speed, due to cache effect
+ * Default value is 14, for 16KB, which nicely fits into Intel x86 L1 cache
+ */
+#define LZ4_MEMORY_USAGE 14
 
 
-//****************************
-// Simple Functions
-//****************************
+/**************************************
+*  Simple Functions
+**************************************/
 
-int LZ4_compress        (const char* source, char* dest, int inputSize);
-int LZ4_decompress_safe (const char* source, char* dest, int inputSize, int maxOutputSize);
+int LZ4_compress_default(const char* source, char* dest, int sourceSize, int maxDestSize);
+int LZ4_decompress_safe (const char* source, char* dest, int compressedSize, int maxDecompressedSize);
 
 /*
-LZ4_compress() :
-    Compresses 'inputSize' bytes from 'source' into 'dest'.
-    Destination buffer must be already allocated,
-    and must be sized to handle worst cases situations (input data not compressible)
-    Worst case size evaluation is provided by function LZ4_compressBound()
-    inputSize : Max supported value is LZ4_MAX_INPUT_VALUE
-    return : the number of bytes written in buffer dest
-             or 0 if the compression fails
+LZ4_compress_default() :
+    Compresses 'sourceSize' bytes from buffer 'source'
+    into already allocated 'dest' buffer of size 'maxDestSize'.
+    Compression is guaranteed to succeed if 'maxDestSize' >= LZ4_compressBound(sourceSize).
+    It also runs faster, so it's a recommended setting.
+    If the function cannot compress 'source' into a more limited 'dest' budget,
+    compression stops *immediately*, and the function result is zero.
+    As a consequence, 'dest' content is not valid.
+    This function never writes outside 'dest' buffer, nor read outside 'source' buffer.
+        sourceSize  : Max supported value is LZ4_MAX_INPUT_VALUE
+        maxDestSize : full or partial size of buffer 'dest' (which must be already allocated)
+        return : the number of bytes written into buffer 'dest' (necessarily <= maxOutputSize)
+              or 0 if compression fails
 
 LZ4_decompress_safe() :
-    maxOutputSize : is the size of the destination buffer (which must be already allocated)
-    return : the number of bytes decoded in the destination buffer (necessarily <= maxOutputSize)
+    compressedSize : is the precise full size of the compressed block.
+    maxDecompressedSize : is the size of destination buffer, which must be already allocated.
+    return : the number of bytes decompressed into destination buffer (necessarily <= maxDecompressedSize)
+             If destination buffer is not large enough, decoding will stop and output an error code (<0).
              If the source stream is detected malformed, the function will stop decoding and return a negative result.
-             This function is protected against buffer overflow exploits (never writes outside of output buffer, and never reads outside of input buffer). Therefore, it is protected against malicious data packets
+             This function is protected against buffer overflow exploits, including malicious data packets.
+             It never writes outside output buffer, nor reads outside input buffer.
 */
 
 
-//****************************
-// Advanced Functions
-//****************************
-#define LZ4_MAX_INPUT_SIZE        0x7E000000   // 2 113 929 216 bytes
-#define LZ4_COMPRESSBOUND(isize)  ((unsigned int)(isize) > (unsigned int)LZ4_MAX_INPUT_SIZE ? 0 : (isize) + ((isize)/255) + 16)
-static inline int LZ4_compressBound(int isize)  { return LZ4_COMPRESSBOUND(isize); }
+/**************************************
+*  Advanced Functions
+**************************************/
+#define LZ4_MAX_INPUT_SIZE        0x7E000000   /* 2 113 929 216 bytes */
+#define LZ4_COMPRESSBOUND(isize)  ((unsigned)(isize) > (unsigned)LZ4_MAX_INPUT_SIZE ? 0 : (isize) + ((isize)/255) + 16)
 
 /*
 LZ4_compressBound() :
-    Provides the maximum size that LZ4 may output in a "worst case" scenario (input data not compressible)
-    primarily useful for memory allocation of output buffer.
-    inline function is recommended for the general case,
-    macro is also provided when result needs to be evaluated at compilation (such as stack memory allocation).
-
-    isize  : is the input size. Max supported value is LZ4_MAX_INPUT_SIZE
-    return : maximum output size in a "worst case" scenario
-             or 0, if input size is too large ( > LZ4_MAX_INPUT_SIZE)
+    Provides the maximum size that LZ4 compression may output in a "worst case" scenario (input data not compressible)
+    This function is primarily useful for memory allocation purposes (destination buffer size).
+    Macro LZ4_COMPRESSBOUND() is also provided for compilation-time evaluation (stack memory allocation for example).
+    Note that LZ4_compress_default() compress faster when dest buffer size is >= LZ4_compressBound(srcSize)
+        inputSize  : max supported value is LZ4_MAX_INPUT_SIZE
+        return : maximum output size in a "worst case" scenario
+              or 0, if input size is too large ( > LZ4_MAX_INPUT_SIZE)
 */
+int LZ4_compressBound(int inputSize);
 
+/*
+LZ4_compress_fast() :
+    Same as LZ4_compress_default(), but allows to select an "acceleration" factor.
+    The larger the acceleration value, the faster the algorithm, but also the lesser the compression.
+    It's a trade-off. It can be fine tuned, with each successive value providing roughly +~3% to speed.
+    An acceleration value of "1" is the same as regular LZ4_compress_default()
+    Values <= 0 will be replaced by ACCELERATION_DEFAULT (see lz4.c), which is 1.
+*/
+int LZ4_compress_fast (const char* source, char* dest, int sourceSize, int maxDestSize, int acceleration);
 
-int LZ4_compress_limitedOutput (const char* source, char* dest, int inputSize, int maxOutputSize);
 
 /*
-LZ4_compress_limitedOutput() :
-    Compress 'inputSize' bytes from 'source' into an output buffer 'dest' of maximum size 'maxOutputSize'.
-    If it cannot achieve it, compression will stop, and result of the function will be zero.
-    This function never writes outside of provided output buffer.
-
-    inputSize  : Max supported value is LZ4_MAX_INPUT_VALUE
-    maxOutputSize : is the size of the destination buffer (which must be already allocated)
-    return : the number of bytes written in buffer 'dest'
-             or 0 if the compression fails
+LZ4_compress_fast_extState() :
+    Same compression function, just using an externally allocated memory space to store compression state.
+    Use LZ4_sizeofState() to know how much memory must be allocated,
+    and allocate it on 8-bytes boundaries (using malloc() typically).
+    Then, provide it as 'void* state' to compression function.
 */
+int LZ4_sizeofState(void);
+int LZ4_compress_fast_extState (void* state, const char* source, char* dest, int inputSize, int maxDestSize, int acceleration);
+
 
+/*
+LZ4_compress_destSize() :
+    Reverse the logic, by compressing as much data as possible from 'source' buffer
+    into already allocated buffer 'dest' of size 'targetDestSize'.
+    This function either compresses the entire 'source' content into 'dest' if it's large enough,
+    or fill 'dest' buffer completely with as much data as possible from 'source'.
+        *sourceSizePtr : will be modified to indicate how many bytes where read from 'source' to fill 'dest'.
+                         New value is necessarily <= old value.
+        return : Nb bytes written into 'dest' (necessarily <= targetDestSize)
+              or 0 if compression fails
+*/
+int LZ4_compress_destSize (const char* source, char* dest, int* sourceSizePtr, int targetDestSize);
 
-int LZ4_decompress_fast (const char* source, char* dest, int outputSize);
 
 /*
 LZ4_decompress_fast() :
-    outputSize : is the original (uncompressed) size
+    originalSize : is the original and therefore uncompressed size
     return : the number of bytes read from the source buffer (in other words, the compressed size)
-             If the source stream is malformed, the function will stop decoding and return a negative result.
-    note : This function is a bit faster than LZ4_decompress_safe()
-           This function never writes outside of output buffers, but may read beyond input buffer in case of malicious data packet.
-           Use this function preferably into a trusted environment (data to decode comes from a trusted source).
-           Destination buffer must be already allocated. Its size must be a minimum of 'outputSize' bytes.
+             If the source stream is detected malformed, the function will stop decoding and return a negative result.
+             Destination buffer must be already allocated. Its size must be a minimum of 'originalSize' bytes.
+    note : This function fully respect memory boundaries for properly formed compressed data.
+           It is a bit faster than LZ4_decompress_safe().
+           However, it does not provide any protection against intentionally modified data stream (malicious input).
+           Use this function in trusted environment only (data to decode comes from a trusted source).
 */
-
-int LZ4_decompress_safe_partial (const char* source, char* dest, int inputSize, int targetOutputSize, int maxOutputSize);
+int LZ4_decompress_fast (const char* source, char* dest, int originalSize);
 
 /*
 LZ4_decompress_safe_partial() :
-    This function decompress a compressed block of size 'inputSize' at position 'source'
-    into output buffer 'dest' of size 'maxOutputSize'.
+    This function decompress a compressed block of size 'compressedSize' at position 'source'
+    into destination buffer 'dest' of size 'maxDecompressedSize'.
     The function tries to stop decompressing operation as soon as 'targetOutputSize' has been reached,
     reducing decompression time.
-    return : the number of bytes decoded in the destination buffer (necessarily <= maxOutputSize)
+    return : the number of bytes decoded in the destination buffer (necessarily <= maxDecompressedSize)
        Note : this number can be < 'targetOutputSize' should the compressed block to decode be smaller.
              Always control how many bytes were decoded.
              If the source stream is detected malformed, the function will stop decoding and return a negative result.
              This function never writes outside of output buffer, and never reads outside of input buffer. It is therefore protected against malicious data packets
 */
+int LZ4_decompress_safe_partial (const char* source, char* dest, int compressedSize, int targetOutputSize, int maxDecompressedSize);
 
 
-//****************************
-// Stream Functions
-//****************************
-
-void* LZ4_create (const char* inputBuffer);
-int   LZ4_compress_continue (void* LZ4_Data, const char* source, char* dest, int inputSize);
-int   LZ4_compress_limitedOutput_continue (void* LZ4_Data, const char* source, char* dest, int inputSize, int maxOutputSize);
-char* LZ4_slideInputBuffer (void* LZ4_Data);
-int   LZ4_free (void* LZ4_Data);
-
+/***********************************************
+*  Streaming Compression Functions
+***********************************************/
+#define LZ4_STREAMSIZE_U64 ((1 << (LZ4_MEMORY_USAGE-3)) + 4)
+#define LZ4_STREAMSIZE     (LZ4_STREAMSIZE_U64 * sizeof(long long))
 /*
-These functions allow the compression of dependent blocks, where each block benefits from prior 64 KB within preceding blocks.
-In order to achieve this, it is necessary to start creating the LZ4 Data Structure, thanks to the function :
-
-void* LZ4_create (const char* inputBuffer);
-The result of the function is the (void*) pointer on the LZ4 Data Structure.
-This pointer will be needed in all other functions.
-If the pointer returned is NULL, then the allocation has failed, and compression must be aborted.
-The only parameter 'const char* inputBuffer' must, obviously, point at the beginning of input buffer.
-The input buffer must be already allocated, and size at least 192KB.
-'inputBuffer' will also be the 'const char* source' of the first block.
+ * LZ4_stream_t
+ * information structure to track an LZ4 stream.
+ * important : init this structure content before first use !
+ * note : only allocated directly the structure if you are statically linking LZ4
+ *        If you are using liblz4 as a DLL, please use below construction methods instead.
+ */
+typedef struct { long long table[LZ4_STREAMSIZE_U64]; } LZ4_stream_t;
 
-All blocks are expected to lay next to each other within the input buffer, starting from 'inputBuffer'.
-To compress each block, use either LZ4_compress_continue() or LZ4_compress_limitedOutput_continue().
-Their behavior are identical to LZ4_compress() or LZ4_compress_limitedOutput(),
-but require the LZ4 Data Structure as their first argument, and check that each block starts right after the previous one.
-If next block does not begin immediately after the previous one, the compression will fail (return 0).
+/*
+ * LZ4_resetStream
+ * Use this function to init an allocated LZ4_stream_t structure
+ */
+void LZ4_resetStream (LZ4_stream_t* streamPtr);
 
-When it's no longer possible to lay the next block after the previous one (not enough space left into input buffer), a call to :
-char* LZ4_slideInputBuffer(void* LZ4_Data);
-must be performed. It will typically copy the latest 64KB of input at the beginning of input buffer.
-Note that, for this function to work properly, minimum size of an input buffer must be 192KB.
-==> The memory position where the next input data block must start is provided as the result of the function.
+/*
+ * LZ4_createStream will allocate and initialize an LZ4_stream_t structure
+ * LZ4_freeStream releases its memory.
+ * In the context of a DLL (liblz4), please use these methods rather than the static struct.
+ * They are more future proof, in case of a change of LZ4_stream_t size.
+ */
+LZ4_stream_t* LZ4_createStream(void);
+int           LZ4_freeStream (LZ4_stream_t* streamPtr);
 
-Compression can then resume, using LZ4_compress_continue() or LZ4_compress_limitedOutput_continue(), as usual.
+/*
+ * LZ4_loadDict
+ * Use this function to load a static dictionary into LZ4_stream.
+ * Any previous data will be forgotten, only 'dictionary' will remain in memory.
+ * Loading a size of 0 is allowed.
+ * Return : dictionary size, in bytes (necessarily <= 64 KB)
+ */
+int LZ4_loadDict (LZ4_stream_t* streamPtr, const char* dictionary, int dictSize);
 
-When compression is completed, a call to LZ4_free() will release the memory used by the LZ4 Data Structure.
-*/
+/*
+ * LZ4_compress_fast_continue
+ * Compress buffer content 'src', using data from previously compressed blocks as dictionary to improve compression ratio.
+ * Important : Previous data blocks are assumed to still be present and unmodified !
+ * 'dst' buffer must be already allocated.
+ * If maxDstSize >= LZ4_compressBound(srcSize), compression is guaranteed to succeed, and runs faster.
+ * If not, and if compressed data cannot fit into 'dst' buffer size, compression stops, and function returns a zero.
+ */
+int LZ4_compress_fast_continue (LZ4_stream_t* streamPtr, const char* src, char* dst, int srcSize, int maxDstSize, int acceleration);
 
+/*
+ * LZ4_saveDict
+ * If previously compressed data block is not guaranteed to remain available at its memory location
+ * save it into a safer place (char* safeBuffer)
+ * Note : you don't need to call LZ4_loadDict() afterwards,
+ *        dictionary is immediately usable, you can therefore call LZ4_compress_fast_continue()
+ * Return : saved dictionary size in bytes (necessarily <= dictSize), or 0 if error
+ */
+int LZ4_saveDict (LZ4_stream_t* streamPtr, char* safeBuffer, int dictSize);
+
+
+/************************************************
+*  Streaming Decompression Functions
+************************************************/
+
+#define LZ4_STREAMDECODESIZE_U64  4
+#define LZ4_STREAMDECODESIZE     (LZ4_STREAMDECODESIZE_U64 * sizeof(unsigned long long))
+typedef struct { unsigned long long table[LZ4_STREAMDECODESIZE_U64]; } LZ4_streamDecode_t;
+/*
+ * LZ4_streamDecode_t
+ * information structure to track an LZ4 stream.
+ * init this structure content using LZ4_setStreamDecode or memset() before first use !
+ *
+ * In the context of a DLL (liblz4) please prefer usage of construction methods below.
+ * They are more future proof, in case of a change of LZ4_streamDecode_t size in the future.
+ * LZ4_createStreamDecode will allocate and initialize an LZ4_streamDecode_t structure
+ * LZ4_freeStreamDecode releases its memory.
+ */
+LZ4_streamDecode_t* LZ4_createStreamDecode(void);
+int                 LZ4_freeStreamDecode (LZ4_streamDecode_t* LZ4_stream);
 
-int LZ4_decompress_safe_withPrefix64k (const char* source, char* dest, int inputSize, int maxOutputSize);
-int LZ4_decompress_fast_withPrefix64k (const char* source, char* dest, int outputSize);
+/*
+ * LZ4_setStreamDecode
+ * Use this function to instruct where to find the dictionary.
+ * Setting a size of 0 is allowed (same effect as reset).
+ * Return : 1 if OK, 0 if error
+ */
+int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dictionary, int dictSize);
 
 /*
-*_withPrefix64k() :
-    These decoding functions work the same as their "normal name" versions,
-    but can use up to 64KB of data in front of 'char* dest'.
-    These functions are necessary to decode inter-dependant blocks.
+*_continue() :
+    These decoding functions allow decompression of multiple blocks in "streaming" mode.
+    Previously decoded blocks *must* remain available at the memory position where they were decoded (up to 64 KB)
+    In the case of a ring buffers, decoding buffer must be either :
+    - Exactly same size as encoding buffer, with same update rule (block boundaries at same positions)
+      In which case, the decoding & encoding ring buffer can have any size, including very small ones ( < 64 KB).
+    - Larger than encoding buffer, by a minimum of maxBlockSize more bytes.
+      maxBlockSize is implementation dependent. It's the maximum size you intend to compress into a single block.
+      In which case, encoding and decoding buffers do not need to be synchronized,
+      and encoding ring buffer can have any size, including small ones ( < 64 KB).
+    - _At least_ 64 KB + 8 bytes + maxBlockSize.
+      In which case, encoding and decoding buffers do not need to be synchronized,
+      and encoding ring buffer can have any size, including larger than decoding buffer.
+    Whenever these conditions are not possible, save the last 64KB of decoded data into a safe buffer,
+    and indicate where it is saved using LZ4_setStreamDecode()
 */
+int LZ4_decompress_safe_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int compressedSize, int maxDecompressedSize);
+int LZ4_decompress_fast_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int originalSize);
 
 
-//****************************
-// Obsolete Functions
-//****************************
-
-static inline int LZ4_uncompress (const char* source, char* dest, int outputSize) { return LZ4_decompress_fast(source, dest, outputSize); }
-static inline int LZ4_uncompress_unknownOutputSize (const char* source, char* dest, int isize, int maxOutputSize) { return LZ4_decompress_safe(source, dest, isize, maxOutputSize); }
-
 /*
-These functions are deprecated and should no longer be used.
-They are provided here for compatibility with existing user programs.
+Advanced decoding functions :
+*_usingDict() :
+    These decoding functions work the same as
+    a combination of LZ4_setStreamDecode() followed by LZ4_decompress_x_continue()
+    They are stand-alone. They don't need nor update an LZ4_streamDecode_t structure.
 */
-
+int LZ4_decompress_safe_usingDict (const char* source, char* dest, int compressedSize, int maxDecompressedSize, const char* dictStart, int dictSize);
+int LZ4_decompress_fast_usingDict (const char* source, char* dest, int originalSize, const char* dictStart, int dictSize);
+
+
+
+/**************************************
+*  Obsolete Functions
+**************************************/
+/* Deprecate Warnings */
+/* Should these warnings messages be a problem,
+   it is generally possible to disable them,
+   with -Wno-deprecated-declarations for gcc
+   or _CRT_SECURE_NO_WARNINGS in Visual for example.
+   You can also define LZ4_DEPRECATE_WARNING_DEFBLOCK. */
+#ifndef LZ4_DEPRECATE_WARNING_DEFBLOCK
+#  define LZ4_DEPRECATE_WARNING_DEFBLOCK
+#  define LZ4_GCC_VERSION (__GNUC__ * 100 + __GNUC_MINOR__)
+#  if (LZ4_GCC_VERSION >= 405) || defined(__clang__)
+#    define LZ4_DEPRECATED(message) __attribute__((deprecated(message)))
+#  elif (LZ4_GCC_VERSION >= 301)
+#    define LZ4_DEPRECATED(message) __attribute__((deprecated))
+#  elif defined(_MSC_VER)
+#    define LZ4_DEPRECATED(message) __declspec(deprecated(message))
+#  else
+#    pragma message("WARNING: You need to implement LZ4_DEPRECATED for this compiler")
+#    define LZ4_DEPRECATED(message)
+#  endif
+#endif /* LZ4_DEPRECATE_WARNING_DEFBLOCK */
+
+/* Obsolete compression functions */
+/* These functions are planned to start generate warnings by r131 approximately */
+int LZ4_compress               (const char* source, char* dest, int sourceSize);
+int LZ4_compress_limitedOutput (const char* source, char* dest, int sourceSize, int maxOutputSize);
+int LZ4_compress_withState               (void* state, const char* source, char* dest, int inputSize);
+int LZ4_compress_limitedOutput_withState (void* state, const char* source, char* dest, int inputSize, int maxOutputSize);
+int LZ4_compress_continue                (LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize);
+int LZ4_compress_limitedOutput_continue  (LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize, int maxOutputSize);
+
+/* Obsolete decompression functions */
+/* These function names are completely deprecated and must no longer be used.
+   They are only provided here for compatibility with older programs.
+    - LZ4_uncompress is the same as LZ4_decompress_fast
+    - LZ4_uncompress_unknownOutputSize is the same as LZ4_decompress_safe
+   These function prototypes are now disabled; uncomment them only if you really need them.
+   It is highly recommended to stop using these prototypes and migrate to maintained ones */
+/* int LZ4_uncompress (const char* source, char* dest, int outputSize); */
+/* int LZ4_uncompress_unknownOutputSize (const char* source, char* dest, int isize, int maxOutputSize); */
+
+/* Obsolete streaming functions; use new streaming interface whenever possible */
+LZ4_DEPRECATED("use LZ4_createStream() instead") void* LZ4_create (char* inputBuffer);
+LZ4_DEPRECATED("use LZ4_createStream() instead") int   LZ4_sizeofStreamState(void);
+LZ4_DEPRECATED("use LZ4_resetStream() instead")  int   LZ4_resetStreamState(void* state, char* inputBuffer);
+LZ4_DEPRECATED("use LZ4_saveDict() instead")     char* LZ4_slideInputBuffer (void* state);
+
+/* Obsolete streaming decoding functions */
+LZ4_DEPRECATED("use LZ4_decompress_safe_usingDict() instead") int LZ4_decompress_safe_withPrefix64k (const char* src, char* dst, int compressedSize, int maxDstSize);
+LZ4_DEPRECATED("use LZ4_decompress_fast_usingDict() instead") int LZ4_decompress_fast_withPrefix64k (const char* src, char* dst, int originalSize);
 
 
 #if defined (__cplusplus)
-- 
2.7.3


