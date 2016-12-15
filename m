From: David Sommerseth <davids@...515...>
Date: Thu, 15 Dec 2016 21:20:45 +0100
Message-Id: <1481833246-32507-2-git-send-email-davids@...515...>
In-Reply-To: <1481833246-32507-1-git-send-email-davids@...515...>
References: <1481833246-32507-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 1/2] lz4: Rebase compat-lz4 against upstream
	v1.7.4.2
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

Rebase process is based on description in commit 46e4b6639a950c56.

The lz4 v1.7.4.2 is based on commit 018ddf799917ee5c68b5 in
git://github.com/lz4/lz4

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/compat/compat-lz4.c | 820 ++++++++++++++++++++++--------------------------
 src/compat/compat-lz4.h | 377 ++++++++++++++--------
 2 files changed, 619 insertions(+), 578 deletions(-)

diff --git a/src/compat/compat-lz4.c b/src/compat/compat-lz4.c
index 5855ca1..319abee 100644
--- a/src/compat/compat-lz4.c
+++ b/src/compat/compat-lz4.c
@@ -1,6 +1,6 @@
 /*
    LZ4 - Fast LZ compression algorithm
-   Copyright (C) 2011-2015, Yann Collet.
+   Copyright (C) 2011-2016, Yann Collet.
 
    BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
 
@@ -28,19 +28,12 @@
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
    You can contact the author at :
-   - LZ4 source repository : https://github.com/Cyan4973/lz4
-   - LZ4 public forum : https://groups.google.com/forum/#!forum/lz4c
+    - LZ4 homepage : http://www.lz4.org
+    - LZ4 source repository : https://github.com/lz4/lz4
 */
 
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
 
-#ifdef NEED_COMPAT_LZ4
-
-/**************************************
+/*-************************************
 *  Tuning parameters
 **************************************/
 /*
@@ -48,7 +41,9 @@
  * Select how default compression functions will allocate memory for their hash table,
  * in memory stack (0:default, fastest), or in memory heap (1:requires malloc()).
  */
-#define HEAPMODE 0
+#ifndef HEAPMODE
+#  define HEAPMODE 0
+#endif
 
 /*
  * ACCELERATION_DEFAULT :
@@ -57,9 +52,31 @@
 #define ACCELERATION_DEFAULT 1
 
 
-/**************************************
+/*-************************************
 *  CPU Feature Detection
 **************************************/
+/* LZ4_FORCE_MEMORY_ACCESS
+ * By default, access to unaligned memory is controlled by `memcpy()`, which is safe and portable.
+ * Unfortunately, on some target/compiler combinations, the generated assembly is sub-optimal.
+ * The below switch allow to select different access method for improved performance.
+ * Method 0 (default) : use `memcpy()`. Safe and portable.
+ * Method 1 : `__packed` statement. It depends on compiler extension (ie, not portable).
+ *            This method is safe if your compiler supports it, and *generally* as fast or faster than `memcpy`.
+ * Method 2 : direct access. This method is portable but violate C standard.
+ *            It can generate buggy code on targets which generate assembly depending on alignment.
+ *            But in some circumstances, it's the only known way to get the most performance (ie GCC + ARMv6)
+ * See https://fastcompression.blogspot.fr/2015/08/accessing-unaligned-memory.html for details.
+ * Prefer these methods in priority order (0 > 1 > 2)
+ */
+#ifndef LZ4_FORCE_MEMORY_ACCESS   /* can be defined externally, on command line for example */
+#  if defined(__GNUC__) && ( defined(__ARM_ARCH_6__) || defined(__ARM_ARCH_6J__) || defined(__ARM_ARCH_6K__) || defined(__ARM_ARCH_6Z__) || defined(__ARM_ARCH_6ZK__) || defined(__ARM_ARCH_6T2__) )
+#    define LZ4_FORCE_MEMORY_ACCESS 2
+#  elif defined(__INTEL_COMPILER) || \
+  (defined(__GNUC__) && ( defined(__ARM_ARCH_7__) || defined(__ARM_ARCH_7A__) || defined(__ARM_ARCH_7R__) || defined(__ARM_ARCH_7M__) || defined(__ARM_ARCH_7S__) ))
+#    define LZ4_FORCE_MEMORY_ACCESS 1
+#  endif
+#endif
+
 /*
  * LZ4_FORCE_SW_BITCOUNT
  * Define this parameter if your target system or compiler does not support hardware bit count
@@ -69,13 +86,14 @@
 #endif
 
 
-/**************************************
-*  Includes
+/*-************************************
+*  Dependency
 **************************************/
 #include "compat-lz4.h"
+/* see also "memory routines" below */
 
 
-/**************************************
+/*-************************************
 *  Compiler Options
 **************************************/
 #ifdef _MSC_VER    /* Visual Studio */
@@ -84,19 +102,16 @@
 #  pragma warning(disable : 4127)        /* disable: C4127: conditional expression is constant */
 #  pragma warning(disable : 4293)        /* disable: C4293: too large shift (32-bits) */
 #else
-#  if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)   /* C99 */
-#    if defined(__GNUC__) || defined(__clang__)
-#      define FORCE_INLINE static inline __attribute__((always_inline))
-#    else
-#      define FORCE_INLINE static inline
-#    endif
+#  if defined(__GNUC__) || defined(__clang__)
+#    define FORCE_INLINE static inline __attribute__((always_inline))
+#  elif defined(__cplusplus) || (defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) /* C99 */)
+#    define FORCE_INLINE static inline
 #  else
 #    define FORCE_INLINE static
-#  endif   /* __STDC_VERSION__ */
+#  endif
 #endif  /* _MSC_VER */
 
-/* LZ4_GCC_VERSION is defined into lz4.h */
-#if (LZ4_GCC_VERSION >= 302) || (__INTEL_COMPILER >= 800) || defined(__clang__)
+#if (defined(__GNUC__) && (__GNUC__ >= 3)) || (defined(__INTEL_COMPILER) && (__INTEL_COMPILER >= 800)) || defined(__clang__)
 #  define expect(expr,value)    (__builtin_expect ((expr),(value)) )
 #else
 #  define expect(expr,value)    (expr)
@@ -106,7 +121,7 @@
 #define unlikely(expr)   expect((expr) != 0, 0)
 
 
-/**************************************
+/*-************************************
 *  Memory routines
 **************************************/
 #include <stdlib.h>   /* malloc, calloc, free */
@@ -116,54 +131,100 @@
 #define MEM_INIT       memset
 
 
-/**************************************
+/*-************************************
 *  Basic Types
 **************************************/
-#if defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)   /* C99 */
+#if defined(__cplusplus) || (defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) /* C99 */)
 # include <stdint.h>
   typedef  uint8_t BYTE;
   typedef uint16_t U16;
   typedef uint32_t U32;
   typedef  int32_t S32;
   typedef uint64_t U64;
+  typedef uintptr_t uptrval;
 #else
   typedef unsigned char       BYTE;
   typedef unsigned short      U16;
   typedef unsigned int        U32;
   typedef   signed int        S32;
   typedef unsigned long long  U64;
+  typedef size_t              uptrval;   /* generally true, except OpenVMS-64 */
 #endif
 
+#if defined(__x86_64__)
+  typedef U64    reg_t;   /* 64-bits in x32 mode */
+#else
+  typedef size_t reg_t;   /* 32-bits in x32 mode */
+#endif
 
-/**************************************
+/*-************************************
 *  Reading and writing into memory
 **************************************/
-#define STEPSIZE sizeof(size_t)
-
-static unsigned LZ4_64bits(void) { return sizeof(void*)==8; }
-
 static unsigned LZ4_isLittleEndian(void)
 {
-    const union { U32 i; BYTE c[4]; } one = { 1 };   /* don't use static : performance detrimental  */
+    const union { U32 u; BYTE c[4]; } one = { 1 };   /* don't use static : performance detrimental */
     return one.c[0];
 }
 
 
+#if defined(LZ4_FORCE_MEMORY_ACCESS) && (LZ4_FORCE_MEMORY_ACCESS==2)
+/* lie to the compiler about data alignment; use with caution */
+
+static U16 LZ4_read16(const void* memPtr) { return *(const U16*) memPtr; }
+static U32 LZ4_read32(const void* memPtr) { return *(const U32*) memPtr; }
+static reg_t LZ4_read_ARCH(const void* memPtr) { return *(const reg_t*) memPtr; }
+
+static void LZ4_write16(void* memPtr, U16 value) { *(U16*)memPtr = value; }
+static void LZ4_write32(void* memPtr, U32 value) { *(U32*)memPtr = value; }
+
+#elif defined(LZ4_FORCE_MEMORY_ACCESS) && (LZ4_FORCE_MEMORY_ACCESS==1)
+
+/* __pack instructions are safer, but compiler specific, hence potentially problematic for some compilers */
+/* currently only defined for gcc and icc */
+typedef union { U16 u16; U32 u32; reg_t uArch; } __attribute__((packed)) unalign;
+
+static U16 LZ4_read16(const void* ptr) { return ((const unalign*)ptr)->u16; }
+static U32 LZ4_read32(const void* ptr) { return ((const unalign*)ptr)->u32; }
+static reg_t LZ4_read_ARCH(const void* ptr) { return ((const unalign*)ptr)->uArch; }
+
+static void LZ4_write16(void* memPtr, U16 value) { ((unalign*)memPtr)->u16 = value; }
+static void LZ4_write32(void* memPtr, U32 value) { ((unalign*)memPtr)->u32 = value; }
+
+#else  /* safe and portable access through memcpy() */
+
 static U16 LZ4_read16(const void* memPtr)
 {
-    U16 val16;
-    memcpy(&val16, memPtr, 2);
-    return val16;
+    U16 val; memcpy(&val, memPtr, sizeof(val)); return val;
 }
 
+static U32 LZ4_read32(const void* memPtr)
+{
+    U32 val; memcpy(&val, memPtr, sizeof(val)); return val;
+}
+
+static reg_t LZ4_read_ARCH(const void* memPtr)
+{
+    reg_t val; memcpy(&val, memPtr, sizeof(val)); return val;
+}
+
+static void LZ4_write16(void* memPtr, U16 value)
+{
+    memcpy(memPtr, &value, sizeof(value));
+}
+
+static void LZ4_write32(void* memPtr, U32 value)
+{
+    memcpy(memPtr, &value, sizeof(value));
+}
+
+#endif /* LZ4_FORCE_MEMORY_ACCESS */
+
+
 static U16 LZ4_readLE16(const void* memPtr)
 {
-    if (LZ4_isLittleEndian())
-    {
+    if (LZ4_isLittleEndian()) {
         return LZ4_read16(memPtr);
-    }
-    else
-    {
+    } else {
         const BYTE* p = (const BYTE*)memPtr;
         return (U16)((U16)p[0] + (p[1]<<8));
     }
@@ -171,63 +232,39 @@ static U16 LZ4_readLE16(const void* memPtr)
 
 static void LZ4_writeLE16(void* memPtr, U16 value)
 {
-    if (LZ4_isLittleEndian())
-    {
-        memcpy(memPtr, &value, 2);
-    }
-    else
-    {
+    if (LZ4_isLittleEndian()) {
+        LZ4_write16(memPtr, value);
+    } else {
         BYTE* p = (BYTE*)memPtr;
         p[0] = (BYTE) value;
         p[1] = (BYTE)(value>>8);
     }
 }
 
-static U32 LZ4_read32(const void* memPtr)
+static void LZ4_copy8(void* dst, const void* src)
 {
-    U32 val32;
-    memcpy(&val32, memPtr, 4);
-    return val32;
+    memcpy(dst,src,8);
 }
 
-static U64 LZ4_read64(const void* memPtr)
-{
-    U64 val64;
-    memcpy(&val64, memPtr, 8);
-    return val64;
-}
-
-static size_t LZ4_read_ARCH(const void* p)
-{
-    if (LZ4_64bits())
-        return (size_t)LZ4_read64(p);
-    else
-        return (size_t)LZ4_read32(p);
-}
-
-
-static void LZ4_copy4(void* dstPtr, const void* srcPtr) { memcpy(dstPtr, srcPtr, 4); }
-
-static void LZ4_copy8(void* dstPtr, const void* srcPtr) { memcpy(dstPtr, srcPtr, 8); }
-
-/* customized version of memcpy, which may overwrite up to 7 bytes beyond dstEnd */
+/* customized variant of memcpy, which can overwrite up to 8 bytes beyond dstEnd */
 static void LZ4_wildCopy(void* dstPtr, const void* srcPtr, void* dstEnd)
 {
     BYTE* d = (BYTE*)dstPtr;
     const BYTE* s = (const BYTE*)srcPtr;
-    BYTE* e = (BYTE*)dstEnd;
+    BYTE* const e = (BYTE*)dstEnd;
+
     do { LZ4_copy8(d,s); d+=8; s+=8; } while (d<e);
 }
 
 
-/**************************************
+/*-************************************
 *  Common Constants
 **************************************/
 #define MINMATCH 4
 
-#define COPYLENGTH 8
+#define WILDCOPYLENGTH 8
 #define LASTLITERALS 5
-#define MFLIMIT (COPYLENGTH+MINMATCH)
+#define MFLIMIT (WILDCOPYLENGTH+MINMATCH)
 static const int LZ4_minLength = (MFLIMIT+1);
 
 #define KB *(1 <<10)
@@ -243,55 +280,48 @@ static const int LZ4_minLength = (MFLIMIT+1);
 #define RUN_MASK ((1U<<RUN_BITS)-1)
 
 
-/**************************************
+/*-************************************
 *  Common Utils
 **************************************/
 #define LZ4_STATIC_ASSERT(c)    { enum { LZ4_static_assert = 1/(int)(!!(c)) }; }   /* use only *after* variable declarations */
 
 
-/**************************************
+/*-************************************
 *  Common functions
 **************************************/
-static unsigned LZ4_NbCommonBytes (register size_t val)
+static unsigned LZ4_NbCommonBytes (register reg_t val)
 {
-    if (LZ4_isLittleEndian())
-    {
-        if (LZ4_64bits())
-        {
+    if (LZ4_isLittleEndian()) {
+        if (sizeof(val)==8) {
 #       if defined(_MSC_VER) && defined(_WIN64) && !defined(LZ4_FORCE_SW_BITCOUNT)
             unsigned long r = 0;
             _BitScanForward64( &r, (U64)val );
             return (int)(r>>3);
-#       elif (defined(__clang__) || (LZ4_GCC_VERSION >= 304)) && !defined(LZ4_FORCE_SW_BITCOUNT)
+#       elif (defined(__clang__) || (defined(__GNUC__) && (__GNUC__>=3))) && !defined(LZ4_FORCE_SW_BITCOUNT)
             return (__builtin_ctzll((U64)val) >> 3);
 #       else
             static const int DeBruijnBytePos[64] = { 0, 0, 0, 0, 0, 1, 1, 2, 0, 3, 1, 3, 1, 4, 2, 7, 0, 2, 3, 6, 1, 5, 3, 5, 1, 3, 4, 4, 2, 5, 6, 7, 7, 0, 1, 2, 3, 3, 4, 6, 2, 6, 5, 5, 3, 4, 5, 6, 7, 1, 2, 4, 6, 4, 4, 5, 7, 2, 6, 5, 7, 6, 7, 7 };
             return DeBruijnBytePos[((U64)((val & -(long long)val) * 0x0218A392CDABBD3FULL)) >> 58];
 #       endif
-        }
-        else /* 32 bits */
-        {
+        } else /* 32 bits */ {
 #       if defined(_MSC_VER) && !defined(LZ4_FORCE_SW_BITCOUNT)
             unsigned long r;
             _BitScanForward( &r, (U32)val );
             return (int)(r>>3);
-#       elif (defined(__clang__) || (LZ4_GCC_VERSION >= 304)) && !defined(LZ4_FORCE_SW_BITCOUNT)
+#       elif (defined(__clang__) || (defined(__GNUC__) && (__GNUC__>=3))) && !defined(LZ4_FORCE_SW_BITCOUNT)
             return (__builtin_ctz((U32)val) >> 3);
 #       else
             static const int DeBruijnBytePos[32] = { 0, 0, 3, 0, 3, 1, 3, 0, 3, 2, 2, 1, 3, 2, 0, 1, 3, 3, 1, 2, 2, 2, 2, 0, 3, 1, 2, 0, 1, 0, 1, 1 };
             return DeBruijnBytePos[((U32)((val & -(S32)val) * 0x077CB531U)) >> 27];
 #       endif
         }
-    }
-    else   /* Big Endian CPU */
-    {
-        if (LZ4_64bits())
-        {
+    } else   /* Big Endian CPU */ {
+        if (sizeof(val)==8) {
 #       if defined(_MSC_VER) && defined(_WIN64) && !defined(LZ4_FORCE_SW_BITCOUNT)
             unsigned long r = 0;
             _BitScanReverse64( &r, val );
             return (unsigned)(r>>3);
-#       elif (defined(__clang__) || (LZ4_GCC_VERSION >= 304)) && !defined(LZ4_FORCE_SW_BITCOUNT)
+#       elif (defined(__clang__) || (defined(__GNUC__) && (__GNUC__>=3))) && !defined(LZ4_FORCE_SW_BITCOUNT)
             return (__builtin_clzll((U64)val) >> 3);
 #       else
             unsigned r;
@@ -300,14 +330,12 @@ static unsigned LZ4_NbCommonBytes (register size_t val)
             r += (!val);
             return r;
 #       endif
-        }
-        else /* 32 bits */
-        {
+        } else /* 32 bits */ {
 #       if defined(_MSC_VER) && !defined(LZ4_FORCE_SW_BITCOUNT)
             unsigned long r = 0;
             _BitScanReverse( &r, (unsigned long)val );
             return (unsigned)(r>>3);
-#       elif (defined(__clang__) || (LZ4_GCC_VERSION >= 304)) && !defined(LZ4_FORCE_SW_BITCOUNT)
+#       elif (defined(__clang__) || (defined(__GNUC__) && (__GNUC__>=3))) && !defined(LZ4_FORCE_SW_BITCOUNT)
             return (__builtin_clz((U32)val) >> 3);
 #       else
             unsigned r;
@@ -319,19 +347,19 @@ static unsigned LZ4_NbCommonBytes (register size_t val)
     }
 }
 
+#define STEPSIZE sizeof(reg_t)
 static unsigned LZ4_count(const BYTE* pIn, const BYTE* pMatch, const BYTE* pInLimit)
 {
     const BYTE* const pStart = pIn;
 
-    while (likely(pIn<pInLimit-(STEPSIZE-1)))
-    {
-        size_t diff = LZ4_read_ARCH(pMatch) ^ LZ4_read_ARCH(pIn);
+    while (likely(pIn<pInLimit-(STEPSIZE-1))) {
+        reg_t const diff = LZ4_read_ARCH(pMatch) ^ LZ4_read_ARCH(pIn);
         if (!diff) { pIn+=STEPSIZE; pMatch+=STEPSIZE; continue; }
         pIn += LZ4_NbCommonBytes(diff);
         return (unsigned)(pIn - pStart);
     }
 
-    if (LZ4_64bits()) if ((pIn<(pInLimit-3)) && (LZ4_read32(pMatch) == LZ4_read32(pIn))) { pIn+=4; pMatch+=4; }
+    if ((STEPSIZE==8) && (pIn<(pInLimit-3)) && (LZ4_read32(pMatch) == LZ4_read32(pIn))) { pIn+=4; pMatch+=4; }
     if ((pIn<(pInLimit-1)) && (LZ4_read16(pMatch) == LZ4_read16(pIn))) { pIn+=2; pMatch+=2; }
     if ((pIn<pInLimit) && (*pMatch == *pIn)) pIn++;
     return (unsigned)(pIn - pStart);
@@ -339,29 +367,16 @@ static unsigned LZ4_count(const BYTE* pIn, const BYTE* pMatch, const BYTE* pInLi
 
 
 #ifndef LZ4_COMMONDEFS_ONLY
-/**************************************
+/*-************************************
 *  Local Constants
 **************************************/
-#define LZ4_HASHLOG   (LZ4_MEMORY_USAGE-2)
-#define HASHTABLESIZE (1 << LZ4_MEMORY_USAGE)
-#define HASH_SIZE_U32 (1 << LZ4_HASHLOG)       /* required as macro for static allocation */
-
 static const int LZ4_64Klimit = ((64 KB) + (MFLIMIT-1));
 static const U32 LZ4_skipTrigger = 6;  /* Increase this value ==> compression run slower on incompressible data */
 
 
-/**************************************
+/*-************************************
 *  Local Structures and types
 **************************************/
-typedef struct {
-    U32 hashTable[HASH_SIZE_U32];
-    U32 currentOffset;
-    U32 initCheck;
-    const BYTE* dictionary;
-    BYTE* bufferStart;   /* obsolete, used for slideInputBuffer */
-    U32 dictSize;
-} LZ4_stream_t_internal;
-
 typedef enum { notLimited = 0, limitedOutput = 1 } limitedOutput_directive;
 typedef enum { byPtr, byU32, byU16 } tableType_t;
 
@@ -372,7 +387,7 @@ typedef enum { endOnOutputSize = 0, endOnInputSize = 1 } endCondition_directive;
 typedef enum { full = 0, partial = 1 } earlyEnd_directive;
 
 
-/**************************************
+/*-************************************
 *  Local Utils
 **************************************/
 int LZ4_versionNumber (void) { return LZ4_VERSION_NUMBER; }
@@ -380,36 +395,34 @@ int LZ4_compressBound(int isize)  { return LZ4_COMPRESSBOUND(isize); }
 int LZ4_sizeofState() { return LZ4_STREAMSIZE; }
 
 
-
-/********************************
+/*-******************************
 *  Compression functions
 ********************************/
-
-static U32 LZ4_hashSequence(U32 sequence, tableType_t const tableType)
+static U32 LZ4_hash4(U32 sequence, tableType_t const tableType)
 {
     if (tableType == byU16)
-        return (((sequence) * 2654435761U) >> ((MINMATCH*8)-(LZ4_HASHLOG+1)));
+        return ((sequence * 2654435761U) >> ((MINMATCH*8)-(LZ4_HASHLOG+1)));
     else
-        return (((sequence) * 2654435761U) >> ((MINMATCH*8)-LZ4_HASHLOG));
+        return ((sequence * 2654435761U) >> ((MINMATCH*8)-LZ4_HASHLOG));
 }
 
-static const U64 prime5bytes = 889523592379ULL;
-static U32 LZ4_hashSequence64(size_t sequence, tableType_t const tableType)
+static U32 LZ4_hash5(U64 sequence, tableType_t const tableType)
 {
+    static const U64 prime5bytes = 889523592379ULL;
+    static const U64 prime8bytes = 11400714785074694791ULL;
     const U32 hashLog = (tableType == byU16) ? LZ4_HASHLOG+1 : LZ4_HASHLOG;
-    const U32 hashMask = (1<<hashLog) - 1;
-    return ((sequence * prime5bytes) >> (40 - hashLog)) & hashMask;
+    if (LZ4_isLittleEndian())
+        return (U32)(((sequence << 24) * prime5bytes) >> (64 - hashLog));
+    else
+        return (U32)(((sequence >> 24) * prime8bytes) >> (64 - hashLog));
 }
 
-static U32 LZ4_hashSequenceT(size_t sequence, tableType_t const tableType)
+FORCE_INLINE U32 LZ4_hashPosition(const void* const p, tableType_t const tableType)
 {
-    if (LZ4_64bits())
-        return LZ4_hashSequence64(sequence, tableType);
-    return LZ4_hashSequence((U32)sequence, tableType);
+    if ((sizeof(reg_t)==8) && (tableType != byU16)) return LZ4_hash5(LZ4_read_ARCH(p), tableType);
+    return LZ4_hash4(LZ4_read32(p), tableType);
 }
 
-static U32 LZ4_hashPosition(const void* p, tableType_t tableType) { return LZ4_hashSequenceT(LZ4_read_ARCH(p), tableType); }
-
 static void LZ4_putPositionOnHash(const BYTE* p, U32 h, void* tableBase, tableType_t const tableType, const BYTE* srcBase)
 {
     switch (tableType)
@@ -420,27 +433,30 @@ static void LZ4_putPositionOnHash(const BYTE* p, U32 h, void* tableBase, tableTy
     }
 }
 
-static void LZ4_putPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
+FORCE_INLINE void LZ4_putPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
 {
-    U32 h = LZ4_hashPosition(p, tableType);
+    U32 const h = LZ4_hashPosition(p, tableType);
     LZ4_putPositionOnHash(p, h, tableBase, tableType, srcBase);
 }
 
 static const BYTE* LZ4_getPositionOnHash(U32 h, void* tableBase, tableType_t tableType, const BYTE* srcBase)
 {
     if (tableType == byPtr) { const BYTE** hashTable = (const BYTE**) tableBase; return hashTable[h]; }
-    if (tableType == byU32) { U32* hashTable = (U32*) tableBase; return hashTable[h] + srcBase; }
-    { U16* hashTable = (U16*) tableBase; return hashTable[h] + srcBase; }   /* default, to ensure a return */
+    if (tableType == byU32) { const U32* const hashTable = (U32*) tableBase; return hashTable[h] + srcBase; }
+    { const U16* const hashTable = (U16*) tableBase; return hashTable[h] + srcBase; }   /* default, to ensure a return */
 }
 
-static const BYTE* LZ4_getPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
+FORCE_INLINE const BYTE* LZ4_getPosition(const BYTE* p, void* tableBase, tableType_t tableType, const BYTE* srcBase)
 {
-    U32 h = LZ4_hashPosition(p, tableType);
+    U32 const h = LZ4_hashPosition(p, tableType);
     return LZ4_getPositionOnHash(h, tableBase, tableType, srcBase);
 }
 
+
+/** LZ4_compress_generic() :
+    inlined, to ensure branches are decided at compilation time */
 FORCE_INLINE int LZ4_compress_generic(
-                 void* const ctx,
+                 LZ4_stream_t_internal* const cctx,
                  const char* const source,
                  char* const dest,
                  const int inputSize,
@@ -451,15 +467,13 @@ FORCE_INLINE int LZ4_compress_generic(
                  const dictIssue_directive dictIssue,
                  const U32 acceleration)
 {
-    LZ4_stream_t_internal* const dictPtr = (LZ4_stream_t_internal*)ctx;
-
     const BYTE* ip = (const BYTE*) source;
     const BYTE* base;
     const BYTE* lowLimit;
-    const BYTE* const lowRefLimit = ip - dictPtr->dictSize;
-    const BYTE* const dictionary = dictPtr->dictionary;
-    const BYTE* const dictEnd = dictionary + dictPtr->dictSize;
-    const size_t dictDelta = dictEnd - (const BYTE*)source;
+    const BYTE* const lowRefLimit = ip - cctx->dictSize;
+    const BYTE* const dictionary = cctx->dictionary;
+    const BYTE* const dictEnd = dictionary + cctx->dictSize;
+    const ptrdiff_t dictDelta = dictEnd - (const BYTE*)source;
     const BYTE* anchor = (const BYTE*) source;
     const BYTE* const iend = ip + inputSize;
     const BYTE* const mflimit = iend - MFLIMIT;
@@ -469,10 +483,9 @@ FORCE_INLINE int LZ4_compress_generic(
     BYTE* const olimit = op + maxOutputSize;
 
     U32 forwardH;
-    size_t refDelta=0;
 
     /* Init conditions */
-    if ((U32)inputSize > (U32)LZ4_MAX_INPUT_SIZE) return 0;   /* Unsupported input size, too large (or negative) */
+    if ((U32)inputSize > (U32)LZ4_MAX_INPUT_SIZE) return 0;   /* Unsupported inputSize, too large (or negative) */
     switch(dict)
     {
     case noDict:
@@ -481,11 +494,11 @@ FORCE_INLINE int LZ4_compress_generic(
         lowLimit = (const BYTE*)source;
         break;
     case withPrefix64k:
-        base = (const BYTE*)source - dictPtr->currentOffset;
-        lowLimit = (const BYTE*)source - dictPtr->dictSize;
+        base = (const BYTE*)source - cctx->currentOffset;
+        lowLimit = (const BYTE*)source - cctx->dictSize;
         break;
     case usingExtDict:
-        base = (const BYTE*)source - dictPtr->currentOffset;
+        base = (const BYTE*)source - cctx->currentOffset;
         lowLimit = (const BYTE*)source;
         break;
     }
@@ -493,44 +506,38 @@ FORCE_INLINE int LZ4_compress_generic(
     if (inputSize<LZ4_minLength) goto _last_literals;                  /* Input too small, no compression (all literals) */
 
     /* First Byte */
-    LZ4_putPosition(ip, ctx, tableType, base);
+    LZ4_putPosition(ip, cctx->hashTable, tableType, base);
     ip++; forwardH = LZ4_hashPosition(ip, tableType);
 
     /* Main Loop */
-    for ( ; ; )
-    {
+    for ( ; ; ) {
+        ptrdiff_t refDelta = 0;
         const BYTE* match;
         BYTE* token;
-        {
-            const BYTE* forwardIp = ip;
+
+        /* Find a match */
+        {   const BYTE* forwardIp = ip;
             unsigned step = 1;
             unsigned searchMatchNb = acceleration << LZ4_skipTrigger;
-
-            /* Find a match */
             do {
-                U32 h = forwardH;
+                U32 const h = forwardH;
                 ip = forwardIp;
                 forwardIp += step;
                 step = (searchMatchNb++ >> LZ4_skipTrigger);
 
                 if (unlikely(forwardIp > mflimit)) goto _last_literals;
 
-                match = LZ4_getPositionOnHash(h, ctx, tableType, base);
-                if (dict==usingExtDict)
-                {
-                    if (match<(const BYTE*)source)
-                    {
+                match = LZ4_getPositionOnHash(h, cctx->hashTable, tableType, base);
+                if (dict==usingExtDict) {
+                    if (match < (const BYTE*)source) {
                         refDelta = dictDelta;
                         lowLimit = dictionary;
-                    }
-                    else
-                    {
+                    } else {
                         refDelta = 0;
                         lowLimit = (const BYTE*)source;
-                    }
-                }
+                }   }
                 forwardH = LZ4_hashPosition(forwardIp, tableType);
-                LZ4_putPositionOnHash(ip, h, ctx, tableType, base);
+                LZ4_putPositionOnHash(ip, h, cctx->hashTable, tableType, base);
 
             } while ( ((dictIssue==dictSmall) ? (match < lowRefLimit) : 0)
                 || ((tableType==byU16) ? 0 : (match + MAX_DISTANCE < ip))
@@ -538,18 +545,17 @@ FORCE_INLINE int LZ4_compress_generic(
         }
 
         /* Catch up */
-        while ((ip>anchor) && (match+refDelta > lowLimit) && (unlikely(ip[-1]==match[refDelta-1]))) { ip--; match--; }
+        while (((ip>anchor) & (match+refDelta > lowLimit)) && (unlikely(ip[-1]==match[refDelta-1]))) { ip--; match--; }
 
-        {
-            /* Encode Literal length */
-            unsigned litLength = (unsigned)(ip - anchor);
+        /* Encode Literals */
+        {   unsigned const litLength = (unsigned)(ip - anchor);
             token = op++;
-            if ((outputLimited) && (unlikely(op + litLength + (2 + 1 + LASTLITERALS) + (litLength/255) > olimit)))
-                return 0;   /* Check output limit */
-            if (litLength>=RUN_MASK)
-            {
+            if ((outputLimited) &&  /* Check output buffer overflow */
+                (unlikely(op + litLength + (2 + 1 + LASTLITERALS) + (litLength/255) > olimit)))
+                return 0;
+            if (litLength >= RUN_MASK) {
                 int len = (int)litLength-RUN_MASK;
-                *token=(RUN_MASK<<ML_BITS);
+                *token = (RUN_MASK<<ML_BITS);
                 for(; len >= 255 ; len-=255) *op++ = 255;
                 *op++ = (BYTE)len;
             }
@@ -565,41 +571,37 @@ _next_match:
         LZ4_writeLE16(op, (U16)(ip-match)); op+=2;
 
         /* Encode MatchLength */
-        {
-            unsigned matchLength;
+        {   unsigned matchCode;
 
-            if ((dict==usingExtDict) && (lowLimit==dictionary))
-            {
+            if ((dict==usingExtDict) && (lowLimit==dictionary)) {
                 const BYTE* limit;
                 match += refDelta;
                 limit = ip + (dictEnd-match);
                 if (limit > matchlimit) limit = matchlimit;
-                matchLength = LZ4_count(ip+MINMATCH, match+MINMATCH, limit);
-                ip += MINMATCH + matchLength;
-                if (ip==limit)
-                {
-                    unsigned more = LZ4_count(ip, (const BYTE*)source, matchlimit);
-                    matchLength += more;
+                matchCode = LZ4_count(ip+MINMATCH, match+MINMATCH, limit);
+                ip += MINMATCH + matchCode;
+                if (ip==limit) {
+                    unsigned const more = LZ4_count(ip, (const BYTE*)source, matchlimit);
+                    matchCode += more;
                     ip += more;
                 }
-            }
-            else
-            {
-                matchLength = LZ4_count(ip+MINMATCH, match+MINMATCH, matchlimit);
-                ip += MINMATCH + matchLength;
+            } else {
+                matchCode = LZ4_count(ip+MINMATCH, match+MINMATCH, matchlimit);
+                ip += MINMATCH + matchCode;
             }
 
-            if ((outputLimited) && (unlikely(op + (1 + LASTLITERALS) + (matchLength>>8) > olimit)))
-                return 0;    /* Check output limit */
-            if (matchLength>=ML_MASK)
-            {
+            if ( outputLimited &&    /* Check output buffer overflow */
+                (unlikely(op + (1 + LASTLITERALS) + (matchCode>>8) > olimit)) )
+                return 0;
+            if (matchCode >= ML_MASK) {
                 *token += ML_MASK;
-                matchLength -= ML_MASK;
-                for (; matchLength >= 510 ; matchLength-=510) { *op++ = 255; *op++ = 255; }
-                if (matchLength >= 255) { matchLength-=255; *op++ = 255; }
-                *op++ = (BYTE)matchLength;
-            }
-            else *token += (BYTE)(matchLength);
+                matchCode -= ML_MASK;
+                LZ4_write32(op, 0xFFFFFFFF);
+                while (matchCode >= 4*255) op+=4, LZ4_write32(op, 0xFFFFFFFF), matchCode -= 4*255;
+                op += matchCode / 255;
+                *op++ = (BYTE)(matchCode % 255);
+            } else
+                *token += (BYTE)(matchCode);
         }
 
         anchor = ip;
@@ -608,24 +610,19 @@ _next_match:
         if (ip > mflimit) break;
 
         /* Fill table */
-        LZ4_putPosition(ip-2, ctx, tableType, base);
+        LZ4_putPosition(ip-2, cctx->hashTable, tableType, base);
 
         /* Test next position */
-        match = LZ4_getPosition(ip, ctx, tableType, base);
-        if (dict==usingExtDict)
-        {
-            if (match<(const BYTE*)source)
-            {
+        match = LZ4_getPosition(ip, cctx->hashTable, tableType, base);
+        if (dict==usingExtDict) {
+            if (match < (const BYTE*)source) {
                 refDelta = dictDelta;
                 lowLimit = dictionary;
-            }
-            else
-            {
+            } else {
                 refDelta = 0;
                 lowLimit = (const BYTE*)source;
-            }
-        }
-        LZ4_putPosition(ip, ctx, tableType, base);
+        }   }
+        LZ4_putPosition(ip, cctx->hashTable, tableType, base);
         if ( ((dictIssue==dictSmall) ? (match>=lowRefLimit) : 1)
             && (match+MAX_DISTANCE>=ip)
             && (LZ4_read32(match+refDelta)==LZ4_read32(ip)) )
@@ -637,19 +634,16 @@ _next_match:
 
 _last_literals:
     /* Encode Last Literals */
-    {
-        const size_t lastRun = (size_t)(iend - anchor);
-        if ((outputLimited) && ((op - (BYTE*)dest) + lastRun + 1 + ((lastRun+255-RUN_MASK)/255) > (U32)maxOutputSize))
-            return 0;   /* Check output limit */
-        if (lastRun >= RUN_MASK)
-        {
+    {   size_t const lastRun = (size_t)(iend - anchor);
+        if ( (outputLimited) &&  /* Check output buffer overflow */
+            ((op - (BYTE*)dest) + lastRun + 1 + ((lastRun+255-RUN_MASK)/255) > (U32)maxOutputSize) )
+            return 0;
+        if (lastRun >= RUN_MASK) {
             size_t accumulator = lastRun - RUN_MASK;
             *op++ = RUN_MASK << ML_BITS;
             for(; accumulator >= 255 ; accumulator-=255) *op++ = 255;
             *op++ = (BYTE) accumulator;
-        }
-        else
-        {
+        } else {
             *op++ = (BYTE)(lastRun<<ML_BITS);
         }
         memcpy(op, anchor, lastRun);
@@ -663,22 +657,20 @@ _last_literals:
 
 int LZ4_compress_fast_extState(void* state, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
 {
+    LZ4_stream_t_internal* ctx = &((LZ4_stream_t*)state)->internal_donotuse;
     LZ4_resetStream((LZ4_stream_t*)state);
     if (acceleration < 1) acceleration = ACCELERATION_DEFAULT;
 
-    if (maxOutputSize >= LZ4_compressBound(inputSize))
-    {
+    if (maxOutputSize >= LZ4_compressBound(inputSize)) {
         if (inputSize < LZ4_64Klimit)
-            return LZ4_compress_generic(state, source, dest, inputSize, 0, notLimited, byU16,                        noDict, noDictIssue, acceleration);
+            return LZ4_compress_generic(ctx, source, dest, inputSize,             0,    notLimited,                        byU16, noDict, noDictIssue, acceleration);
         else
-            return LZ4_compress_generic(state, source, dest, inputSize, 0, notLimited, LZ4_64bits() ? byU32 : byPtr, noDict, noDictIssue, acceleration);
-    }
-    else
-    {
+            return LZ4_compress_generic(ctx, source, dest, inputSize,             0,    notLimited, (sizeof(void*)==8) ? byU32 : byPtr, noDict, noDictIssue, acceleration);
+    } else {
         if (inputSize < LZ4_64Klimit)
-            return LZ4_compress_generic(state, source, dest, inputSize, maxOutputSize, limitedOutput, byU16,                        noDict, noDictIssue, acceleration);
+            return LZ4_compress_generic(ctx, source, dest, inputSize, maxOutputSize, limitedOutput,                        byU16, noDict, noDictIssue, acceleration);
         else
-            return LZ4_compress_generic(state, source, dest, inputSize, maxOutputSize, limitedOutput, LZ4_64bits() ? byU32 : byPtr, noDict, noDictIssue, acceleration);
+            return LZ4_compress_generic(ctx, source, dest, inputSize, maxOutputSize, limitedOutput, (sizeof(void*)==8) ? byU32 : byPtr, noDict, noDictIssue, acceleration);
     }
 }
 
@@ -689,10 +681,10 @@ int LZ4_compress_fast(const char* source, char* dest, int inputSize, int maxOutp
     void* ctxPtr = ALLOCATOR(1, sizeof(LZ4_stream_t));   /* malloc-calloc always properly aligned */
 #else
     LZ4_stream_t ctx;
-    void* ctxPtr = &ctx;
+    void* const ctxPtr = &ctx;
 #endif
 
-    int result = LZ4_compress_fast_extState(ctxPtr, source, dest, inputSize, maxOutputSize, acceleration);
+    int const result = LZ4_compress_fast_extState(ctxPtr, source, dest, inputSize, maxOutputSize, acceleration);
 
 #if (HEAPMODE)
     FREEMEM(ctxPtr);
@@ -712,22 +704,21 @@ int LZ4_compress_default(const char* source, char* dest, int inputSize, int maxO
 int LZ4_compress_fast_force(const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
 {
     LZ4_stream_t ctx;
-
     LZ4_resetStream(&ctx);
 
     if (inputSize < LZ4_64Klimit)
-        return LZ4_compress_generic(&ctx, source, dest, inputSize, maxOutputSize, limitedOutput, byU16,                        noDict, noDictIssue, acceleration);
+        return LZ4_compress_generic(&ctx.internal_donotuse, source, dest, inputSize, maxOutputSize, limitedOutput, byU16,                        noDict, noDictIssue, acceleration);
     else
-        return LZ4_compress_generic(&ctx, source, dest, inputSize, maxOutputSize, limitedOutput, LZ4_64bits() ? byU32 : byPtr, noDict, noDictIssue, acceleration);
+        return LZ4_compress_generic(&ctx.internal_donotuse, source, dest, inputSize, maxOutputSize, limitedOutput, sizeof(void*)==8 ? byU32 : byPtr, noDict, noDictIssue, acceleration);
 }
 
 
-/********************************
-*  destSize variant
+/*-******************************
+*  *_destSize() variant
 ********************************/
 
 static int LZ4_compress_destSize_generic(
-                       void* const ctx,
+                       LZ4_stream_t_internal* const ctx,
                  const char* const src,
                        char* const dst,
                        int*  const srcSizePtr,
@@ -759,32 +750,30 @@ static int LZ4_compress_destSize_generic(
 
     /* First Byte */
     *srcSizePtr = 0;
-    LZ4_putPosition(ip, ctx, tableType, base);
+    LZ4_putPosition(ip, ctx->hashTable, tableType, base);
     ip++; forwardH = LZ4_hashPosition(ip, tableType);
 
     /* Main Loop */
-    for ( ; ; )
-    {
+    for ( ; ; ) {
         const BYTE* match;
         BYTE* token;
-        {
-            const BYTE* forwardIp = ip;
+
+        /* Find a match */
+        {   const BYTE* forwardIp = ip;
             unsigned step = 1;
             unsigned searchMatchNb = 1 << LZ4_skipTrigger;
 
-            /* Find a match */
             do {
                 U32 h = forwardH;
                 ip = forwardIp;
                 forwardIp += step;
                 step = (searchMatchNb++ >> LZ4_skipTrigger);
 
-                if (unlikely(forwardIp > mflimit))
-                    goto _last_literals;
+                if (unlikely(forwardIp > mflimit)) goto _last_literals;
 
-                match = LZ4_getPositionOnHash(h, ctx, tableType, base);
+                match = LZ4_getPositionOnHash(h, ctx->hashTable, tableType, base);
                 forwardH = LZ4_hashPosition(forwardIp, tableType);
-                LZ4_putPositionOnHash(ip, h, ctx, tableType, base);
+                LZ4_putPositionOnHash(ip, h, ctx->hashTable, tableType, base);
 
             } while ( ((tableType==byU16) ? 0 : (match + MAX_DISTANCE < ip))
                 || (LZ4_read32(match) != LZ4_read32(ip)) );
@@ -793,18 +782,15 @@ static int LZ4_compress_destSize_generic(
         /* Catch up */
         while ((ip>anchor) && (match > lowLimit) && (unlikely(ip[-1]==match[-1]))) { ip--; match--; }
 
-        {
-            /* Encode Literal length */
-            unsigned litLength = (unsigned)(ip - anchor);
+        /* Encode Literal length */
+        {   unsigned litLength = (unsigned)(ip - anchor);
             token = op++;
-            if (op + ((litLength+240)/255) + litLength > oMaxLit)
-            {
+            if (op + ((litLength+240)/255) + litLength > oMaxLit) {
                 /* Not enough space for a last match */
                 op--;
                 goto _last_literals;
             }
-            if (litLength>=RUN_MASK)
-            {
+            if (litLength>=RUN_MASK) {
                 unsigned len = litLength - RUN_MASK;
                 *token=(RUN_MASK<<ML_BITS);
                 for(; len >= 255 ; len-=255) *op++ = 255;
@@ -822,21 +808,15 @@ _next_match:
         LZ4_writeLE16(op, (U16)(ip-match)); op+=2;
 
         /* Encode MatchLength */
-        {
-            size_t matchLength;
+        {   size_t matchLength = LZ4_count(ip+MINMATCH, match+MINMATCH, matchlimit);
 
-            matchLength = LZ4_count(ip+MINMATCH, match+MINMATCH, matchlimit);
-
-            if (op + ((matchLength+240)/255) > oMaxMatch)
-            {
+            if (op + ((matchLength+240)/255) > oMaxMatch) {
                 /* Match description too long : reduce it */
                 matchLength = (15-1) + (oMaxMatch-op) * 255;
             }
-            //printf("offset %5i, matchLength%5i \n", (int)(ip-match), matchLength + MINMATCH);
             ip += MINMATCH + matchLength;
 
-            if (matchLength>=ML_MASK)
-            {
+            if (matchLength>=ML_MASK) {
                 *token += ML_MASK;
                 matchLength -= ML_MASK;
                 while (matchLength >= 255) { matchLength-=255; *op++ = 255; }
@@ -852,11 +832,11 @@ _next_match:
         if (op > oMaxSeq) break;
 
         /* Fill table */
-        LZ4_putPosition(ip-2, ctx, tableType, base);
+        LZ4_putPosition(ip-2, ctx->hashTable, tableType, base);
 
         /* Test next position */
-        match = LZ4_getPosition(ip, ctx, tableType, base);
-        LZ4_putPosition(ip, ctx, tableType, base);
+        match = LZ4_getPosition(ip, ctx->hashTable, tableType, base);
+        LZ4_putPosition(ip, ctx->hashTable, tableType, base);
         if ( (match+MAX_DISTANCE>=ip)
             && (LZ4_read32(match)==LZ4_read32(ip)) )
         { token=op++; *token=0; goto _next_match; }
@@ -867,25 +847,20 @@ _next_match:
 
 _last_literals:
     /* Encode Last Literals */
-    {
-        size_t lastRunSize = (size_t)(iend - anchor);
-        if (op + 1 /* token */ + ((lastRunSize+240)/255) /* litLength */ + lastRunSize /* literals */ > oend)
-        {
+    {   size_t lastRunSize = (size_t)(iend - anchor);
+        if (op + 1 /* token */ + ((lastRunSize+240)/255) /* litLength */ + lastRunSize /* literals */ > oend) {
             /* adapt lastRunSize to fill 'dst' */
             lastRunSize  = (oend-op) - 1;
             lastRunSize -= (lastRunSize+240)/255;
         }
         ip = anchor + lastRunSize;
 
-        if (lastRunSize >= RUN_MASK)
-        {
+        if (lastRunSize >= RUN_MASK) {
             size_t accumulator = lastRunSize - RUN_MASK;
             *op++ = RUN_MASK << ML_BITS;
             for(; accumulator >= 255 ; accumulator-=255) *op++ = 255;
             *op++ = (BYTE) accumulator;
-        }
-        else
-        {
+        } else {
             *op++ = (BYTE)(lastRunSize<<ML_BITS);
         }
         memcpy(op, anchor, lastRunSize);
@@ -898,20 +873,17 @@ _last_literals:
 }
 
 
-static int LZ4_compress_destSize_extState (void* state, const char* src, char* dst, int* srcSizePtr, int targetDstSize)
+static int LZ4_compress_destSize_extState (LZ4_stream_t* state, const char* src, char* dst, int* srcSizePtr, int targetDstSize)
 {
-    LZ4_resetStream((LZ4_stream_t*)state);
+    LZ4_resetStream(state);
 
-    if (targetDstSize >= LZ4_compressBound(*srcSizePtr))   /* compression success is guaranteed */
-    {
+    if (targetDstSize >= LZ4_compressBound(*srcSizePtr)) {  /* compression success is guaranteed */
         return LZ4_compress_fast_extState(state, src, dst, *srcSizePtr, targetDstSize, 1);
-    }
-    else
-    {
+    } else {
         if (*srcSizePtr < LZ4_64Klimit)
-            return LZ4_compress_destSize_generic(state, src, dst, srcSizePtr, targetDstSize, byU16);
+            return LZ4_compress_destSize_generic(&state->internal_donotuse, src, dst, srcSizePtr, targetDstSize, byU16);
         else
-            return LZ4_compress_destSize_generic(state, src, dst, srcSizePtr, targetDstSize, LZ4_64bits() ? byU32 : byPtr);
+            return LZ4_compress_destSize_generic(&state->internal_donotuse, src, dst, srcSizePtr, targetDstSize, sizeof(void*)==8 ? byU32 : byPtr);
     }
 }
 
@@ -919,10 +891,10 @@ static int LZ4_compress_destSize_extState (void* state, const char* src, char* d
 int LZ4_compress_destSize(const char* src, char* dst, int* srcSizePtr, int targetDstSize)
 {
 #if (HEAPMODE)
-    void* ctx = ALLOCATOR(1, sizeof(LZ4_stream_t));   /* malloc-calloc always properly aligned */
+    LZ4_stream_t* ctx = (LZ4_stream_t*)ALLOCATOR(1, sizeof(LZ4_stream_t));   /* malloc-calloc always properly aligned */
 #else
     LZ4_stream_t ctxBody;
-    void* ctx = &ctxBody;
+    LZ4_stream_t* ctx = &ctxBody;
 #endif
 
     int result = LZ4_compress_destSize_extState(ctx, src, dst, srcSizePtr, targetDstSize);
@@ -935,7 +907,7 @@ int LZ4_compress_destSize(const char* src, char* dst, int* srcSizePtr, int targe
 
 
 
-/********************************
+/*-******************************
 *  Streaming functions
 ********************************/
 
@@ -959,10 +931,10 @@ int LZ4_freeStream (LZ4_stream_t* LZ4_stream)
 }
 
 
-#define HASH_UNIT sizeof(size_t)
+#define HASH_UNIT sizeof(reg_t)
 int LZ4_loadDict (LZ4_stream_t* LZ4_dict, const char* dictionary, int dictSize)
 {
-    LZ4_stream_t_internal* dict = (LZ4_stream_t_internal*) LZ4_dict;
+    LZ4_stream_t_internal* dict = &LZ4_dict->internal_donotuse;
     const BYTE* p = (const BYTE*)dictionary;
     const BYTE* const dictEnd = p + dictSize;
     const BYTE* base;
@@ -970,8 +942,7 @@ int LZ4_loadDict (LZ4_stream_t* LZ4_dict, const char* dictionary, int dictSize)
     if ((dict->initCheck) || (dict->currentOffset > 1 GB))  /* Uninitialized structure, or reuse overflow */
         LZ4_resetStream(LZ4_dict);
 
-    if (dictSize < (int)HASH_UNIT)
-    {
+    if (dictSize < (int)HASH_UNIT) {
         dict->dictionary = NULL;
         dict->dictSize = 0;
         return 0;
@@ -984,8 +955,7 @@ int LZ4_loadDict (LZ4_stream_t* LZ4_dict, const char* dictionary, int dictSize)
     dict->dictSize = (U32)(dictEnd - p);
     dict->currentOffset += dict->dictSize;
 
-    while (p <= dictEnd-HASH_UNIT)
-    {
+    while (p <= dictEnd-HASH_UNIT) {
         LZ4_putPosition(p, dict->hashTable, byU32, base);
         p+=3;
     }
@@ -997,14 +967,12 @@ int LZ4_loadDict (LZ4_stream_t* LZ4_dict, const char* dictionary, int dictSize)
 static void LZ4_renormDictT(LZ4_stream_t_internal* LZ4_dict, const BYTE* src)
 {
     if ((LZ4_dict->currentOffset > 0x80000000) ||
-        ((size_t)LZ4_dict->currentOffset > (size_t)src))   /* address space overflow */
-    {
+        ((uptrval)LZ4_dict->currentOffset > (uptrval)src)) {   /* address space overflow */
         /* rescale hash table */
-        U32 delta = LZ4_dict->currentOffset - 64 KB;
+        U32 const delta = LZ4_dict->currentOffset - 64 KB;
         const BYTE* dictEnd = LZ4_dict->dictionary + LZ4_dict->dictSize;
         int i;
-        for (i=0; i<HASH_SIZE_U32; i++)
-        {
+        for (i=0; i<LZ4_HASH_SIZE_U32; i++) {
             if (LZ4_dict->hashTable[i] < delta) LZ4_dict->hashTable[i]=0;
             else LZ4_dict->hashTable[i] -= delta;
         }
@@ -1017,7 +985,7 @@ static void LZ4_renormDictT(LZ4_stream_t_internal* LZ4_dict, const BYTE* src)
 
 int LZ4_compress_fast_continue (LZ4_stream_t* LZ4_stream, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
 {
-    LZ4_stream_t_internal* streamPtr = (LZ4_stream_t_internal*)LZ4_stream;
+    LZ4_stream_t_internal* streamPtr = &LZ4_stream->internal_donotuse;
     const BYTE* const dictEnd = streamPtr->dictionary + streamPtr->dictSize;
 
     const BYTE* smallest = (const BYTE*) source;
@@ -1027,10 +995,8 @@ int LZ4_compress_fast_continue (LZ4_stream_t* LZ4_stream, const char* source, ch
     if (acceleration < 1) acceleration = ACCELERATION_DEFAULT;
 
     /* Check overlapping input/dictionary space */
-    {
-        const BYTE* sourceEnd = (const BYTE*) source + inputSize;
-        if ((sourceEnd > streamPtr->dictionary) && (sourceEnd < dictEnd))
-        {
+    {   const BYTE* sourceEnd = (const BYTE*) source + inputSize;
+        if ((sourceEnd > streamPtr->dictionary) && (sourceEnd < dictEnd)) {
             streamPtr->dictSize = (U32)(dictEnd - sourceEnd);
             if (streamPtr->dictSize > 64 KB) streamPtr->dictSize = 64 KB;
             if (streamPtr->dictSize < 4) streamPtr->dictSize = 0;
@@ -1039,25 +1005,23 @@ int LZ4_compress_fast_continue (LZ4_stream_t* LZ4_stream, const char* source, ch
     }
 
     /* prefix mode : source data follows dictionary */
-    if (dictEnd == (const BYTE*)source)
-    {
+    if (dictEnd == (const BYTE*)source) {
         int result;
         if ((streamPtr->dictSize < 64 KB) && (streamPtr->dictSize < streamPtr->currentOffset))
-            result = LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, withPrefix64k, dictSmall, acceleration);
+            result = LZ4_compress_generic(streamPtr, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, withPrefix64k, dictSmall, acceleration);
         else
-            result = LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, withPrefix64k, noDictIssue, acceleration);
+            result = LZ4_compress_generic(streamPtr, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, withPrefix64k, noDictIssue, acceleration);
         streamPtr->dictSize += (U32)inputSize;
         streamPtr->currentOffset += (U32)inputSize;
         return result;
     }
 
     /* external dictionary mode */
-    {
-        int result;
+    {   int result;
         if ((streamPtr->dictSize < 64 KB) && (streamPtr->dictSize < streamPtr->currentOffset))
-            result = LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, usingExtDict, dictSmall, acceleration);
+            result = LZ4_compress_generic(streamPtr, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, usingExtDict, dictSmall, acceleration);
         else
-            result = LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, usingExtDict, noDictIssue, acceleration);
+            result = LZ4_compress_generic(streamPtr, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, usingExtDict, noDictIssue, acceleration);
         streamPtr->dictionary = (const BYTE*)source;
         streamPtr->dictSize = (U32)inputSize;
         streamPtr->currentOffset += (U32)inputSize;
@@ -1069,15 +1033,15 @@ int LZ4_compress_fast_continue (LZ4_stream_t* LZ4_stream, const char* source, ch
 /* Hidden debug function, to force external dictionary mode */
 int LZ4_compress_forceExtDict (LZ4_stream_t* LZ4_dict, const char* source, char* dest, int inputSize)
 {
-    LZ4_stream_t_internal* streamPtr = (LZ4_stream_t_internal*)LZ4_dict;
+    LZ4_stream_t_internal* streamPtr = &LZ4_dict->internal_donotuse;
     int result;
     const BYTE* const dictEnd = streamPtr->dictionary + streamPtr->dictSize;
 
     const BYTE* smallest = dictEnd;
     if (smallest > (const BYTE*) source) smallest = (const BYTE*) source;
-    LZ4_renormDictT((LZ4_stream_t_internal*)LZ4_dict, smallest);
+    LZ4_renormDictT(streamPtr, smallest);
 
-    result = LZ4_compress_generic(LZ4_dict, source, dest, inputSize, 0, notLimited, byU32, usingExtDict, noDictIssue, 1);
+    result = LZ4_compress_generic(streamPtr, source, dest, inputSize, 0, notLimited, byU32, usingExtDict, noDictIssue, 1);
 
     streamPtr->dictionary = (const BYTE*)source;
     streamPtr->dictSize = (U32)inputSize;
@@ -1087,10 +1051,17 @@ int LZ4_compress_forceExtDict (LZ4_stream_t* LZ4_dict, const char* source, char*
 }
 
 
+/*! LZ4_saveDict() :
+ *  If previously compressed data block is not guaranteed to remain available at its memory location,
+ *  save it into a safer place (char* safeBuffer).
+ *  Note : you don't need to call LZ4_loadDict() afterwards,
+ *         dictionary is immediately usable, you can therefore call LZ4_compress_fast_continue().
+ *  Return : saved dictionary size in bytes (necessarily <= dictSize), or 0 if error.
+ */
 int LZ4_saveDict (LZ4_stream_t* LZ4_dict, char* safeBuffer, int dictSize)
 {
-    LZ4_stream_t_internal* dict = (LZ4_stream_t_internal*) LZ4_dict;
-    const BYTE* previousDictEnd = dict->dictionary + dict->dictSize;
+    LZ4_stream_t_internal* const dict = &LZ4_dict->internal_donotuse;
+    const BYTE* const previousDictEnd = dict->dictionary + dict->dictSize;
 
     if ((U32)dictSize > 64 KB) dictSize = 64 KB;   /* useless to define a dictionary > 64 KB */
     if ((U32)dictSize > dict->dictSize) dictSize = dict->dictSize;
@@ -1105,14 +1076,14 @@ int LZ4_saveDict (LZ4_stream_t* LZ4_dict, char* safeBuffer, int dictSize)
 
 
 
-/*******************************
+/*-*****************************
 *  Decompression functions
 *******************************/
-/*
- * This generic decompression function cover all use cases.
- * It shall be instantiated several times, using different sets of directives
- * Note that it is essential this generic function is really inlined,
- * in order to remove useless branches during compilation optimization.
+/*! LZ4_decompress_generic() :
+ *  This generic decompression function cover all use cases.
+ *  It shall be instantiated several times, using different sets of directives
+ *  Note that it is important this generic function is really inlined,
+ *  in order to remove useless branches during compilation optimization.
  */
 FORCE_INLINE int LZ4_decompress_generic(
                  const char* const source,
@@ -1124,7 +1095,7 @@ FORCE_INLINE int LZ4_decompress_generic(
                  int partialDecoding,    /* full, partial */
                  int targetOutputSize,   /* only used if partialDecoding==partial */
                  int dict,               /* noDict, withPrefix64k, usingExtDict */
-                 const BYTE* const lowPrefix,  /* == dest if dict == noDict */
+                 const BYTE* const lowPrefix,  /* == dest when no prefix */
                  const BYTE* const dictStart,  /* only if dict==usingExtDict */
                  const size_t dictSize         /* note : = 0 if noDict */
                  )
@@ -1140,53 +1111,45 @@ FORCE_INLINE int LZ4_decompress_generic(
     const BYTE* const lowLimit = lowPrefix - dictSize;
 
     const BYTE* const dictEnd = (const BYTE*)dictStart + dictSize;
-    const size_t dec32table[] = {4, 1, 2, 1, 4, 4, 4, 4};
-    const size_t dec64table[] = {0, 0, 0, (size_t)-1, 0, 1, 2, 3};
+    const unsigned dec32table[] = {0, 1, 2, 1, 4, 4, 4, 4};
+    const int dec64table[] = {0, 0, 0, -1, 0, 1, 2, 3};
 
     const int safeDecode = (endOnInput==endOnInputSize);
     const int checkOffset = ((safeDecode) && (dictSize < (int)(64 KB)));
 
 
     /* Special cases */
-    if ((partialDecoding) && (oexit> oend-MFLIMIT)) oexit = oend-MFLIMIT;                         /* targetOutputSize too high => decode everything */
+    if ((partialDecoding) && (oexit > oend-MFLIMIT)) oexit = oend-MFLIMIT;                        /* targetOutputSize too high => decode everything */
     if ((endOnInput) && (unlikely(outputSize==0))) return ((inputSize==1) && (*ip==0)) ? 0 : -1;  /* Empty output buffer */
     if ((!endOnInput) && (unlikely(outputSize==0))) return (*ip==0?1:-1);
 
-
-    /* Main Loop */
-    while (1)
-    {
-        unsigned token;
+    /* Main Loop : decode sequences */
+    while (1) {
         size_t length;
         const BYTE* match;
+        size_t offset;
 
         /* get literal length */
-        token = *ip++;
-        if ((length=(token>>ML_BITS)) == RUN_MASK)
-        {
+        unsigned const token = *ip++;
+        if ((length=(token>>ML_BITS)) == RUN_MASK) {
             unsigned s;
-            do
-            {
+            do {
                 s = *ip++;
                 length += s;
-            }
-            while (likely((endOnInput)?ip<iend-RUN_MASK:1) && (s==255));
-            if ((safeDecode) && unlikely((size_t)(op+length)<(size_t)(op))) goto _output_error;   /* overflow detection */
-            if ((safeDecode) && unlikely((size_t)(ip+length)<(size_t)(ip))) goto _output_error;   /* overflow detection */
+            } while ( likely(endOnInput ? ip<iend-RUN_MASK : 1) & (s==255) );
+            if ((safeDecode) && unlikely((uptrval)(op)+length<(uptrval)(op))) goto _output_error;   /* overflow detection */
+            if ((safeDecode) && unlikely((uptrval)(ip)+length<(uptrval)(ip))) goto _output_error;   /* overflow detection */
         }
 
         /* copy literals */
         cpy = op+length;
-        if (((endOnInput) && ((cpy>(partialDecoding?oexit:oend-MFLIMIT)) || (ip+length>iend-(2+1+LASTLITERALS))) )
-            || ((!endOnInput) && (cpy>oend-COPYLENGTH)))
+        if ( ((endOnInput) && ((cpy>(partialDecoding?oexit:oend-MFLIMIT)) || (ip+length>iend-(2+1+LASTLITERALS))) )
+            || ((!endOnInput) && (cpy>oend-WILDCOPYLENGTH)) )
         {
-            if (partialDecoding)
-            {
+            if (partialDecoding) {
                 if (cpy > oend) goto _output_error;                           /* Error : write attempt beyond end of output buffer */
                 if ((endOnInput) && (ip+length > iend)) goto _output_error;   /* Error : read attempt beyond end of input buffer */
-            }
-            else
-            {
+            } else {
                 if ((!endOnInput) && (cpy != oend)) goto _output_error;       /* Error : block decoding must stop exactly there */
                 if ((endOnInput) && ((ip+length != iend) || (cpy > oend))) goto _output_error;   /* Error : input must be consumed */
             }
@@ -1199,84 +1162,76 @@ FORCE_INLINE int LZ4_decompress_generic(
         ip += length; op = cpy;
 
         /* get offset */
-        match = cpy - LZ4_readLE16(ip); ip+=2;
-        if ((checkOffset) && (unlikely(match < lowLimit))) goto _output_error;   /* Error : offset outside destination buffer */
+        offset = LZ4_readLE16(ip); ip+=2;
+        match = op - offset;
+        if ((checkOffset) && (unlikely(match < lowLimit))) goto _output_error;   /* Error : offset outside buffers */
+        LZ4_write32(op, (U32)offset);   /* costs ~1%; silence an msan warning when offset==0 */
 
         /* get matchlength */
         length = token & ML_MASK;
-        if (length == ML_MASK)
-        {
+        if (length == ML_MASK) {
             unsigned s;
-            do
-            {
+            do {
+                s = *ip++;
                 if ((endOnInput) && (ip > iend-LASTLITERALS)) goto _output_error;
-                s = *ip++;
                 length += s;
             } while (s==255);
-            if ((safeDecode) && unlikely((size_t)(op+length)<(size_t)op)) goto _output_error;   /* overflow detection */
+            if ((safeDecode) && unlikely((uptrval)(op)+length<(uptrval)op)) goto _output_error;   /* overflow detection */
         }
         length += MINMATCH;
 
         /* check external dictionary */
-        if ((dict==usingExtDict) && (match < lowPrefix))
-        {
+        if ((dict==usingExtDict) && (match < lowPrefix)) {
             if (unlikely(op+length > oend-LASTLITERALS)) goto _output_error;   /* doesn't respect parsing restriction */
 
-            if (length <= (size_t)(lowPrefix-match))
-            {
+            if (length <= (size_t)(lowPrefix-match)) {
                 /* match can be copied as a single segment from external dictionary */
-                match = dictEnd - (lowPrefix-match);
-                memmove(op, match, length); op += length;
-            }
-            else
-            {
-                /* match encompass external dictionary and current segment */
-                size_t copySize = (size_t)(lowPrefix-match);
+                memmove(op, dictEnd - (lowPrefix-match), length);
+                op += length;
+            } else {
+                /* match encompass external dictionary and current block */
+                size_t const copySize = (size_t)(lowPrefix-match);
+                size_t const restSize = length - copySize;
                 memcpy(op, dictEnd - copySize, copySize);
                 op += copySize;
-                copySize = length - copySize;
-                if (copySize > (size_t)(op-lowPrefix))   /* overlap within current segment */
-                {
-                    BYTE* const endOfMatch = op + copySize;
+                if (restSize > (size_t)(op-lowPrefix)) {  /* overlap copy */
+                    BYTE* const endOfMatch = op + restSize;
                     const BYTE* copyFrom = lowPrefix;
                     while (op < endOfMatch) *op++ = *copyFrom++;
-                }
-                else
-                {
-                    memcpy(op, lowPrefix, copySize);
-                    op += copySize;
-                }
-            }
+                } else {
+                    memcpy(op, lowPrefix, restSize);
+                    op += restSize;
+            }   }
             continue;
         }
 
-        /* copy repeated sequence */
+        /* copy match within block */
         cpy = op + length;
-        if (unlikely((op-match)<8))
-        {
-            const size_t dec64 = dec64table[op-match];
+        if (unlikely(offset<8)) {
+            const int dec64 = dec64table[offset];
             op[0] = match[0];
             op[1] = match[1];
             op[2] = match[2];
             op[3] = match[3];
-            match += dec32table[op-match];
-            LZ4_copy4(op+4, match);
-            op += 8; match -= dec64;
-        } else { LZ4_copy8(op, match); op+=8; match+=8; }
+            match += dec32table[offset];
+            memcpy(op+4, match, 4);
+            match -= dec64;
+        } else { LZ4_copy8(op, match); match+=8; }
+        op += 8;
 
-        if (unlikely(cpy>oend-12))
-        {
-            if (cpy > oend-LASTLITERALS) goto _output_error;    /* Error : last LASTLITERALS bytes must be literals */
-            if (op < oend-8)
-            {
-                LZ4_wildCopy(op, match, oend-8);
-                match += (oend-8) - op;
-                op = oend-8;
+        if (unlikely(cpy>oend-12)) {
+            BYTE* const oCopyLimit = oend-(WILDCOPYLENGTH-1);
+            if (cpy > oend-LASTLITERALS) goto _output_error;    /* Error : last LASTLITERALS bytes must be literals (uncompressed) */
+            if (op < oCopyLimit) {
+                LZ4_wildCopy(op, match, oCopyLimit);
+                match += oCopyLimit - op;
+                op = oCopyLimit;
             }
             while (op<cpy) *op++ = *match++;
+        } else {
+            LZ4_copy8(op, match);
+            if (length>16) LZ4_wildCopy(op+8, match+8, cpy);
         }
-        else
-            LZ4_wildCopy(op, match, cpy);
         op=cpy;   /* correction */
     }
 
@@ -1308,15 +1263,7 @@ int LZ4_decompress_fast(const char* source, char* dest, int originalSize)
 }
 
 
-/* streaming decompression functions */
-
-typedef struct
-{
-    const BYTE* externalDict;
-    size_t extDictSize;
-    const BYTE* prefixEnd;
-    size_t prefixSize;
-} LZ4_streamDecode_t_internal;
+/*===== streaming decompression functions =====*/
 
 /*
  * If you prefer dynamic allocation methods,
@@ -1335,16 +1282,16 @@ int LZ4_freeStreamDecode (LZ4_streamDecode_t* LZ4_stream)
     return 0;
 }
 
-/*
- * LZ4_setStreamDecode
- * Use this function to instruct where to find the dictionary
+/*!
+ * LZ4_setStreamDecode() :
+ * Use this function to instruct where to find the dictionary.
  * This function is not necessary if previous data is still available where it was decoded.
  * Loading a size of 0 is allowed (same effect as no dictionary).
  * Return : 1 if OK, 0 if error
  */
 int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dictionary, int dictSize)
 {
-    LZ4_streamDecode_t_internal* lz4sd = (LZ4_streamDecode_t_internal*) LZ4_streamDecode;
+    LZ4_streamDecode_t_internal* lz4sd = &LZ4_streamDecode->internal_donotuse;
     lz4sd->prefixSize = (size_t) dictSize;
     lz4sd->prefixEnd = (const BYTE*) dictionary + dictSize;
     lz4sd->externalDict = NULL;
@@ -1361,20 +1308,17 @@ int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dicti
 */
 int LZ4_decompress_safe_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int compressedSize, int maxOutputSize)
 {
-    LZ4_streamDecode_t_internal* lz4sd = (LZ4_streamDecode_t_internal*) LZ4_streamDecode;
+    LZ4_streamDecode_t_internal* lz4sd = &LZ4_streamDecode->internal_donotuse;
     int result;
 
-    if (lz4sd->prefixEnd == (BYTE*)dest)
-    {
+    if (lz4sd->prefixEnd == (BYTE*)dest) {
         result = LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize,
                                         endOnInputSize, full, 0,
                                         usingExtDict, lz4sd->prefixEnd - lz4sd->prefixSize, lz4sd->externalDict, lz4sd->extDictSize);
         if (result <= 0) return result;
         lz4sd->prefixSize += result;
         lz4sd->prefixEnd  += result;
-    }
-    else
-    {
+    } else {
         lz4sd->extDictSize = lz4sd->prefixSize;
         lz4sd->externalDict = lz4sd->prefixEnd - lz4sd->extDictSize;
         result = LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize,
@@ -1390,22 +1334,19 @@ int LZ4_decompress_safe_continue (LZ4_streamDecode_t* LZ4_streamDecode, const ch
 
 int LZ4_decompress_fast_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int originalSize)
 {
-    LZ4_streamDecode_t_internal* lz4sd = (LZ4_streamDecode_t_internal*) LZ4_streamDecode;
+    LZ4_streamDecode_t_internal* lz4sd = &LZ4_streamDecode->internal_donotuse;
     int result;
 
-    if (lz4sd->prefixEnd == (BYTE*)dest)
-    {
+    if (lz4sd->prefixEnd == (BYTE*)dest) {
         result = LZ4_decompress_generic(source, dest, 0, originalSize,
                                         endOnOutputSize, full, 0,
                                         usingExtDict, lz4sd->prefixEnd - lz4sd->prefixSize, lz4sd->externalDict, lz4sd->extDictSize);
         if (result <= 0) return result;
         lz4sd->prefixSize += originalSize;
         lz4sd->prefixEnd  += originalSize;
-    }
-    else
-    {
+    } else {
         lz4sd->extDictSize = lz4sd->prefixSize;
-        lz4sd->externalDict = (BYTE*)dest - lz4sd->extDictSize;
+        lz4sd->externalDict = lz4sd->prefixEnd - lz4sd->extDictSize;
         result = LZ4_decompress_generic(source, dest, 0, originalSize,
                                         endOnOutputSize, full, 0,
                                         usingExtDict, (BYTE*)dest, lz4sd->externalDict, lz4sd->extDictSize);
@@ -1429,8 +1370,7 @@ FORCE_INLINE int LZ4_decompress_usingDict_generic(const char* source, char* dest
 {
     if (dictSize==0)
         return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, noDict, (BYTE*)dest, NULL, 0);
-    if (dictStart+dictSize == dest)
-    {
+    if (dictStart+dictSize == dest) {
         if (dictSize >= (int)(64 KB - 1))
             return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, withPrefix64k, (BYTE*)dest-64 KB, NULL, 0);
         return LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, full, 0, noDict, (BYTE*)dest-dictSize, NULL, 0);
@@ -1455,7 +1395,7 @@ int LZ4_decompress_safe_forceExtDict(const char* source, char* dest, int compres
 }
 
 
-/***************************************************
+/*=*************************************************
 *  Obsolete Functions
 ***************************************************/
 /* obsolete compression functions */
@@ -1480,29 +1420,29 @@ int LZ4_uncompress_unknownOutputSize (const char* source, char* dest, int isize,
 
 int LZ4_sizeofStreamState() { return LZ4_STREAMSIZE; }
 
-static void LZ4_init(LZ4_stream_t_internal* lz4ds, BYTE* base)
+static void LZ4_init(LZ4_stream_t* lz4ds, BYTE* base)
 {
-    MEM_INIT(lz4ds, 0, LZ4_STREAMSIZE);
-    lz4ds->bufferStart = base;
+    MEM_INIT(lz4ds, 0, sizeof(LZ4_stream_t));
+    lz4ds->internal_donotuse.bufferStart = base;
 }
 
 int LZ4_resetStreamState(void* state, char* inputBuffer)
 {
-    if ((((size_t)state) & 3) != 0) return 1;   /* Error : pointer is not aligned on 4-bytes boundary */
-    LZ4_init((LZ4_stream_t_internal*)state, (BYTE*)inputBuffer);
+    if ((((uptrval)state) & 3) != 0) return 1;   /* Error : pointer is not aligned on 4-bytes boundary */
+    LZ4_init((LZ4_stream_t*)state, (BYTE*)inputBuffer);
     return 0;
 }
 
 void* LZ4_create (char* inputBuffer)
 {
-    void* lz4ds = ALLOCATOR(8, LZ4_STREAMSIZE_U64);
-    LZ4_init ((LZ4_stream_t_internal*)lz4ds, (BYTE*)inputBuffer);
+    LZ4_stream_t* lz4ds = (LZ4_stream_t*)ALLOCATOR(8, sizeof(LZ4_stream_t));
+    LZ4_init (lz4ds, (BYTE*)inputBuffer);
     return lz4ds;
 }
 
 char* LZ4_slideInputBuffer (void* LZ4_Data)
 {
-    LZ4_stream_t_internal* ctx = (LZ4_stream_t_internal*)LZ4_Data;
+    LZ4_stream_t_internal* ctx = &((LZ4_stream_t*)LZ4_Data)->internal_donotuse;
     int dictSize = LZ4_saveDict((LZ4_stream_t*)LZ4_Data, (char*)ctx->bufferStart, 64 KB);
     return (char*)(ctx->bufferStart + dictSize);
 }
@@ -1520,5 +1460,3 @@ int LZ4_decompress_fast_withPrefix64k(const char* source, char* dest, int origin
 }
 
 #endif   /* LZ4_COMMONDEFS_ONLY */
-
-#endif /* NEED_COMPAT_LZ4 */
diff --git a/src/compat/compat-lz4.h b/src/compat/compat-lz4.h
index 3e74002..7420ad8 100644
--- a/src/compat/compat-lz4.h
+++ b/src/compat/compat-lz4.h
@@ -1,7 +1,7 @@
 /*
-   LZ4 - Fast LZ compression algorithm
-   Header File
-   Copyright (C) 2011-2015, Yann Collet.
+ *  LZ4 - Fast LZ compression algorithm
+ *  Header File
+ *  Copyright (C) 2011-2016, Yann Collet.
 
    BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
 
@@ -29,34 +29,79 @@
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
    You can contact the author at :
-   - LZ4 source repository : https://github.com/Cyan4973/lz4
-   - LZ4 public forum : https://groups.google.com/forum/#!forum/lz4c
+    - LZ4 homepage : http://www.lz4.org
+    - LZ4 source repository : https://github.com/lz4/lz4
 */
-#pragma once
+#ifndef LZ4_H_2983827168210
+#define LZ4_H_2983827168210
 
 #if defined (__cplusplus)
 extern "C" {
 #endif
 
+/* --- Dependency --- */
+#include <stddef.h>   /* size_t */
+
+
+/**
+  Introduction
+
+  LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core,
+  scalable with multi-cores CPU. It features an extremely fast decoder, with speed in
+  multiple GB/s per core, typically reaching RAM speed limits on multi-core systems.
+
+  The LZ4 compression library provides in-memory compression and decompression functions.
+  Compression can be done in:
+    - a single step (described as Simple Functions)
+    - a single step, reusing a context (described in Advanced Functions)
+    - unbounded multiple steps (described as Streaming compression)
+
+  lz4.h provides block compression functions. It gives full buffer control to user.
+  Decompressing an lz4-compressed block also requires metadata (such as compressed size).
+  Each application is free to encode such metadata in whichever way it wants.
+
+  An additional format, called LZ4 frame specification (doc/lz4_Frame_format.md),
+  take care of encoding standard metadata alongside LZ4-compressed blocks.
+  If your application requires interoperability, it's recommended to use it.
+  A library is provided to take care of it, see lz4frame.h.
+*/
+
+/*^***************************************************************
+*  Export parameters
+*****************************************************************/
 /*
- * lz4.h provides block compression functions, and gives full buffer control to programmer.
- * If you need to generate inter-operable compressed data (respecting LZ4 frame specification),
- * and can let the library handle its own memory, please use lz4frame.h instead.
+*  LZ4_DLL_EXPORT :
+*  Enable exporting of functions when building a Windows DLL
 */
+#if defined(LZ4_DLL_EXPORT) && (LZ4_DLL_EXPORT==1)
+#  define LZ4LIB_API __declspec(dllexport)
+#elif defined(LZ4_DLL_IMPORT) && (LZ4_DLL_IMPORT==1)
+#  define LZ4LIB_API __declspec(dllimport) /* It isn't required but allows to generate better code, saving a function pointer load from the IAT and an indirect jump.*/
+#else
+#  define LZ4LIB_API
+#endif
 
-/**************************************
-*  Version
-**************************************/
+
+/*========== Version =========== */
 #define LZ4_VERSION_MAJOR    1    /* for breaking interface changes  */
 #define LZ4_VERSION_MINOR    7    /* for new (non-breaking) interface capabilities */
-#define LZ4_VERSION_RELEASE  1    /* for tweaks, bug-fixes, or development */
+#define LZ4_VERSION_RELEASE  4    /* for tweaks, bug-fixes, or development */
+
 #define LZ4_VERSION_NUMBER (LZ4_VERSION_MAJOR *100*100 + LZ4_VERSION_MINOR *100 + LZ4_VERSION_RELEASE)
-int LZ4_versionNumber (void);
 
-/**************************************
+#define LZ4_LIB_VERSION LZ4_VERSION_MAJOR.LZ4_VERSION_MINOR.LZ4_VERSION_RELEASE
+#define LZ4_QUOTE(str) #str
+#define LZ4_EXPAND_AND_QUOTE(str) LZ4_QUOTE(str)
+#define LZ4_VERSION_STRING LZ4_EXPAND_AND_QUOTE(LZ4_LIB_VERSION)
+
+LZ4LIB_API int LZ4_versionNumber (void);
+LZ4LIB_API const char* LZ4_versionString (void);
+
+
+/*-************************************
 *  Tuning parameter
 **************************************/
-/*
+/*!
  * LZ4_MEMORY_USAGE :
  * Memory usage formula : N->2^N Bytes (examples : 10 -> 1KB; 12 -> 4KB ; 16 -> 64KB; 20 -> 1MB; etc.)
  * Increasing memory usage improves compression ratio
@@ -66,15 +111,10 @@ int LZ4_versionNumber (void);
 #define LZ4_MEMORY_USAGE 14
 
 
-/**************************************
+/*-************************************
 *  Simple Functions
 **************************************/
-
-int LZ4_compress_default(const char* source, char* dest, int sourceSize, int maxDestSize);
-int LZ4_decompress_safe (const char* source, char* dest, int compressedSize, int maxDecompressedSize);
-
-/*
-LZ4_compress_default() :
+/*! LZ4_compress_default() :
     Compresses 'sourceSize' bytes from buffer 'source'
     into already allocated 'dest' buffer of size 'maxDestSize'.
     Compression is guaranteed to succeed if 'maxDestSize' >= LZ4_compressBound(sourceSize).
@@ -86,9 +126,10 @@ LZ4_compress_default() :
         sourceSize  : Max supported value is LZ4_MAX_INPUT_VALUE
         maxDestSize : full or partial size of buffer 'dest' (which must be already allocated)
         return : the number of bytes written into buffer 'dest' (necessarily <= maxOutputSize)
-              or 0 if compression fails
+              or 0 if compression fails */
+LZ4LIB_API int LZ4_compress_default(const char* source, char* dest, int sourceSize, int maxDestSize);
 
-LZ4_decompress_safe() :
+/*! LZ4_decompress_safe() :
     compressedSize : is the precise full size of the compressed block.
     maxDecompressedSize : is the size of destination buffer, which must be already allocated.
     return : the number of bytes decompressed into destination buffer (necessarily <= maxDecompressedSize)
@@ -97,15 +138,16 @@ LZ4_decompress_safe() :
              This function is protected against buffer overflow exploits, including malicious data packets.
              It never writes outside output buffer, nor reads outside input buffer.
 */
+LZ4LIB_API int LZ4_decompress_safe (const char* source, char* dest, int compressedSize, int maxDecompressedSize);
 
 
-/**************************************
+/*-************************************
 *  Advanced Functions
 **************************************/
 #define LZ4_MAX_INPUT_SIZE        0x7E000000   /* 2 113 929 216 bytes */
 #define LZ4_COMPRESSBOUND(isize)  ((unsigned)(isize) > (unsigned)LZ4_MAX_INPUT_SIZE ? 0 : (isize) + ((isize)/255) + 16)
 
-/*
+/*!
 LZ4_compressBound() :
     Provides the maximum size that LZ4 compression may output in a "worst case" scenario (input data not compressible)
     This function is primarily useful for memory allocation purposes (destination buffer size).
@@ -115,9 +157,9 @@ LZ4_compressBound() :
         return : maximum output size in a "worst case" scenario
               or 0, if input size is too large ( > LZ4_MAX_INPUT_SIZE)
 */
-int LZ4_compressBound(int inputSize);
+LZ4LIB_API int LZ4_compressBound(int inputSize);
 
-/*
+/*!
 LZ4_compress_fast() :
     Same as LZ4_compress_default(), but allows to select an "acceleration" factor.
     The larger the acceleration value, the faster the algorithm, but also the lesser the compression.
@@ -125,21 +167,21 @@ LZ4_compress_fast() :
     An acceleration value of "1" is the same as regular LZ4_compress_default()
     Values <= 0 will be replaced by ACCELERATION_DEFAULT (see lz4.c), which is 1.
 */
-int LZ4_compress_fast (const char* source, char* dest, int sourceSize, int maxDestSize, int acceleration);
+LZ4LIB_API int LZ4_compress_fast (const char* source, char* dest, int sourceSize, int maxDestSize, int acceleration);
 
 
-/*
+/*!
 LZ4_compress_fast_extState() :
     Same compression function, just using an externally allocated memory space to store compression state.
     Use LZ4_sizeofState() to know how much memory must be allocated,
     and allocate it on 8-bytes boundaries (using malloc() typically).
     Then, provide it as 'void* state' to compression function.
 */
-int LZ4_sizeofState(void);
-int LZ4_compress_fast_extState (void* state, const char* source, char* dest, int inputSize, int maxDestSize, int acceleration);
+LZ4LIB_API int LZ4_sizeofState(void);
+LZ4LIB_API int LZ4_compress_fast_extState (void* state, const char* source, char* dest, int inputSize, int maxDestSize, int acceleration);
 
 
-/*
+/*!
 LZ4_compress_destSize() :
     Reverse the logic, by compressing as much data as possible from 'source' buffer
     into already allocated buffer 'dest' of size 'targetDestSize'.
@@ -150,10 +192,10 @@ LZ4_compress_destSize() :
         return : Nb bytes written into 'dest' (necessarily <= targetDestSize)
               or 0 if compression fails
 */
-int LZ4_compress_destSize (const char* source, char* dest, int* sourceSizePtr, int targetDestSize);
+LZ4LIB_API int LZ4_compress_destSize (const char* source, char* dest, int* sourceSizePtr, int targetDestSize);
 
 
-/*
+/*!
 LZ4_decompress_fast() :
     originalSize : is the original and therefore uncompressed size
     return : the number of bytes read from the source buffer (in other words, the compressed size)
@@ -164,9 +206,9 @@ LZ4_decompress_fast() :
            However, it does not provide any protection against intentionally modified data stream (malicious input).
            Use this function in trusted environment only (data to decode comes from a trusted source).
 */
-int LZ4_decompress_fast (const char* source, char* dest, int originalSize);
+LZ4LIB_API int LZ4_decompress_fast (const char* source, char* dest, int originalSize);
 
-/*
+/*!
 LZ4_decompress_safe_partial() :
     This function decompress a compressed block of size 'compressedSize' at position 'source'
     into destination buffer 'dest' of size 'maxDecompressedSize'.
@@ -178,98 +220,73 @@ LZ4_decompress_safe_partial() :
              If the source stream is detected malformed, the function will stop decoding and return a negative result.
              This function never writes outside of output buffer, and never reads outside of input buffer. It is therefore protected against malicious data packets
 */
-int LZ4_decompress_safe_partial (const char* source, char* dest, int compressedSize, int targetOutputSize, int maxDecompressedSize);
+LZ4LIB_API int LZ4_decompress_safe_partial (const char* source, char* dest, int compressedSize, int targetOutputSize, int maxDecompressedSize);
 
 
-/***********************************************
+/*-*********************************************
 *  Streaming Compression Functions
 ***********************************************/
-#define LZ4_STREAMSIZE_U64 ((1 << (LZ4_MEMORY_USAGE-3)) + 4)
-#define LZ4_STREAMSIZE     (LZ4_STREAMSIZE_U64 * sizeof(long long))
-/*
- * LZ4_stream_t
- * information structure to track an LZ4 stream.
- * important : init this structure content before first use !
- * note : only allocated directly the structure if you are statically linking LZ4
- *        If you are using liblz4 as a DLL, please use below construction methods instead.
- */
-typedef struct { long long table[LZ4_STREAMSIZE_U64]; } LZ4_stream_t;
+typedef union LZ4_stream_u LZ4_stream_t;   /* incomplete type (defined later) */
 
-/*
- * LZ4_resetStream
- * Use this function to init an allocated LZ4_stream_t structure
+/*! LZ4_createStream() and LZ4_freeStream() :
+ *  LZ4_createStream() will allocate and initialize an `LZ4_stream_t` structure.
+ *  LZ4_freeStream() releases its memory.
  */
-void LZ4_resetStream (LZ4_stream_t* streamPtr);
+LZ4LIB_API LZ4_stream_t* LZ4_createStream(void);
+LZ4LIB_API int           LZ4_freeStream (LZ4_stream_t* streamPtr);
 
-/*
- * LZ4_createStream will allocate and initialize an LZ4_stream_t structure
- * LZ4_freeStream releases its memory.
- * In the context of a DLL (liblz4), please use these methods rather than the static struct.
- * They are more future proof, in case of a change of LZ4_stream_t size.
+/*! LZ4_resetStream() :
+ *  An LZ4_stream_t structure can be allocated once and re-used multiple times.
+ *  Use this function to init an allocated `LZ4_stream_t` structure and start a new compression.
  */
-LZ4_stream_t* LZ4_createStream(void);
-int           LZ4_freeStream (LZ4_stream_t* streamPtr);
+LZ4LIB_API void LZ4_resetStream (LZ4_stream_t* streamPtr);
 
-/*
- * LZ4_loadDict
- * Use this function to load a static dictionary into LZ4_stream.
- * Any previous data will be forgotten, only 'dictionary' will remain in memory.
- * Loading a size of 0 is allowed.
- * Return : dictionary size, in bytes (necessarily <= 64 KB)
+/*! LZ4_loadDict() :
+ *  Use this function to load a static dictionary into LZ4_stream.
+ *  Any previous data will be forgotten, only 'dictionary' will remain in memory.
+ *  Loading a size of 0 is allowed.
+ *  Return : dictionary size, in bytes (necessarily <= 64 KB)
  */
-int LZ4_loadDict (LZ4_stream_t* streamPtr, const char* dictionary, int dictSize);
+LZ4LIB_API int LZ4_loadDict (LZ4_stream_t* streamPtr, const char* dictionary, int dictSize);
 
-/*
- * LZ4_compress_fast_continue
- * Compress buffer content 'src', using data from previously compressed blocks as dictionary to improve compression ratio.
- * Important : Previous data blocks are assumed to still be present and unmodified !
- * 'dst' buffer must be already allocated.
- * If maxDstSize >= LZ4_compressBound(srcSize), compression is guaranteed to succeed, and runs faster.
- * If not, and if compressed data cannot fit into 'dst' buffer size, compression stops, and function returns a zero.
+/*! LZ4_compress_fast_continue() :
+ *  Compress buffer content 'src', using data from previously compressed blocks as dictionary to improve compression ratio.
+ *  Important : Previous data blocks are assumed to still be present and unmodified !
+ *  'dst' buffer must be already allocated.
+ *  If maxDstSize >= LZ4_compressBound(srcSize), compression is guaranteed to succeed, and runs faster.
+ *  If not, and if compressed data cannot fit into 'dst' buffer size, compression stops, and function returns a zero.
  */
-int LZ4_compress_fast_continue (LZ4_stream_t* streamPtr, const char* src, char* dst, int srcSize, int maxDstSize, int acceleration);
+LZ4LIB_API int LZ4_compress_fast_continue (LZ4_stream_t* streamPtr, const char* src, char* dst, int srcSize, int maxDstSize, int acceleration);
 
-/*
- * LZ4_saveDict
- * If previously compressed data block is not guaranteed to remain available at its memory location
- * save it into a safer place (char* safeBuffer)
- * Note : you don't need to call LZ4_loadDict() afterwards,
- *        dictionary is immediately usable, you can therefore call LZ4_compress_fast_continue()
- * Return : saved dictionary size in bytes (necessarily <= dictSize), or 0 if error
+/*! LZ4_saveDict() :
+ *  If previously compressed data block is not guaranteed to remain available at its memory location,
+ *  save it into a safer place (char* safeBuffer).
+ *  Note : you don't need to call LZ4_loadDict() afterwards,
+ *         dictionary is immediately usable, you can therefore call LZ4_compress_fast_continue().
+ *  Return : saved dictionary size in bytes (necessarily <= dictSize), or 0 if error.
  */
-int LZ4_saveDict (LZ4_stream_t* streamPtr, char* safeBuffer, int dictSize);
+LZ4LIB_API int LZ4_saveDict (LZ4_stream_t* streamPtr, char* safeBuffer, int dictSize);
 
 
-/************************************************
+/*-**********************************************
 *  Streaming Decompression Functions
+*  Bufferless synchronous API
 ************************************************/
+typedef union LZ4_streamDecode_u LZ4_streamDecode_t;   /* incomplete type (defined later) */
 
-#define LZ4_STREAMDECODESIZE_U64  4
-#define LZ4_STREAMDECODESIZE     (LZ4_STREAMDECODESIZE_U64 * sizeof(unsigned long long))
-typedef struct { unsigned long long table[LZ4_STREAMDECODESIZE_U64]; } LZ4_streamDecode_t;
-/*
- * LZ4_streamDecode_t
- * information structure to track an LZ4 stream.
- * init this structure content using LZ4_setStreamDecode or memset() before first use !
- *
- * In the context of a DLL (liblz4) please prefer usage of construction methods below.
- * They are more future proof, in case of a change of LZ4_streamDecode_t size in the future.
- * LZ4_createStreamDecode will allocate and initialize an LZ4_streamDecode_t structure
- * LZ4_freeStreamDecode releases its memory.
- */
-LZ4_streamDecode_t* LZ4_createStreamDecode(void);
-int                 LZ4_freeStreamDecode (LZ4_streamDecode_t* LZ4_stream);
+/* creation / destruction of streaming decompression tracking structure */
+LZ4LIB_API LZ4_streamDecode_t* LZ4_createStreamDecode(void);
+LZ4LIB_API int                 LZ4_freeStreamDecode (LZ4_streamDecode_t* LZ4_stream);
 
-/*
- * LZ4_setStreamDecode
- * Use this function to instruct where to find the dictionary.
- * Setting a size of 0 is allowed (same effect as reset).
- * Return : 1 if OK, 0 if error
+/*! LZ4_setStreamDecode() :
+ *  Use this function to instruct where to find the dictionary.
+ *  Setting a size of 0 is allowed (same effect as reset).
+ *  @return : 1 if OK, 0 if error
  */
-int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dictionary, int dictSize);
+LZ4LIB_API int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dictionary, int dictSize);
 
-/*
-*_continue() :
+/*!
+LZ4_decompress_*_continue() :
     These decoding functions allow decompression of multiple blocks in "streaming" mode.
     Previously decoded blocks *must* remain available at the memory position where they were decoded (up to 64 KB)
     In the case of a ring buffers, decoding buffer must be either :
@@ -285,35 +302,120 @@ int LZ4_setStreamDecode (LZ4_streamDecode_t* LZ4_streamDecode, const char* dicti
     Whenever these conditions are not possible, save the last 64KB of decoded data into a safe buffer,
     and indicate where it is saved using LZ4_setStreamDecode()
 */
-int LZ4_decompress_safe_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int compressedSize, int maxDecompressedSize);
-int LZ4_decompress_fast_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int originalSize);
+LZ4LIB_API int LZ4_decompress_safe_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int compressedSize, int maxDecompressedSize);
+LZ4LIB_API int LZ4_decompress_fast_continue (LZ4_streamDecode_t* LZ4_streamDecode, const char* source, char* dest, int originalSize);
 
 
-/*
-Advanced decoding functions :
-*_usingDict() :
-    These decoding functions work the same as
-    a combination of LZ4_setStreamDecode() followed by LZ4_decompress_x_continue()
-    They are stand-alone. They don't need nor update an LZ4_streamDecode_t structure.
-*/
-int LZ4_decompress_safe_usingDict (const char* source, char* dest, int compressedSize, int maxDecompressedSize, const char* dictStart, int dictSize);
-int LZ4_decompress_fast_usingDict (const char* source, char* dest, int originalSize, const char* dictStart, int dictSize);
+/*! LZ4_decompress_*_usingDict() :
+ *  These decoding functions work the same as
+ *  a combination of LZ4_setStreamDecode() followed by LZ4_decompress_*_continue()
+ *  They are stand-alone, and don't need an LZ4_streamDecode_t structure.
+ */
+LZ4LIB_API int LZ4_decompress_safe_usingDict (const char* source, char* dest, int compressedSize, int maxDecompressedSize, const char* dictStart, int dictSize);
+LZ4LIB_API int LZ4_decompress_fast_usingDict (const char* source, char* dest, int originalSize, const char* dictStart, int dictSize);
 
 
+/*^**********************************************
+ * !!!!!!   STATIC LINKING ONLY   !!!!!!
+ ***********************************************/
+/*-************************************
+ *  Private definitions
+ **************************************
+ * Do not use these definitions.
+ * They are exposed to allow static allocation of `LZ4_stream_t` and `LZ4_streamDecode_t`.
+ * Using these definitions will expose code to API and/or ABI break in future versions of the library.
+ **************************************/
+#define LZ4_HASHLOG   (LZ4_MEMORY_USAGE-2)
+#define LZ4_HASHTABLESIZE (1 << LZ4_MEMORY_USAGE)
+#define LZ4_HASH_SIZE_U32 (1 << LZ4_HASHLOG)       /* required as macro for static allocation */
 
-/**************************************
+#if defined(__cplusplus) || (defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) /* C99 */)
+#include <stdint.h>
+
+typedef struct {
+    uint32_t hashTable[LZ4_HASH_SIZE_U32];
+    uint32_t currentOffset;
+    uint32_t initCheck;
+    const uint8_t* dictionary;
+    uint8_t* bufferStart;   /* obsolete, used for slideInputBuffer */
+    uint32_t dictSize;
+} LZ4_stream_t_internal;
+
+typedef struct {
+    const uint8_t* externalDict;
+    size_t extDictSize;
+    const uint8_t* prefixEnd;
+    size_t prefixSize;
+} LZ4_streamDecode_t_internal;
+
+#else
+
+typedef struct {
+    unsigned int hashTable[LZ4_HASH_SIZE_U32];
+    unsigned int currentOffset;
+    unsigned int initCheck;
+    const unsigned char* dictionary;
+    unsigned char* bufferStart;   /* obsolete, used for slideInputBuffer */
+    unsigned int dictSize;
+} LZ4_stream_t_internal;
+
+typedef struct {
+    const unsigned char* externalDict;
+    size_t extDictSize;
+    const unsigned char* prefixEnd;
+    size_t prefixSize;
+} LZ4_streamDecode_t_internal;
+
+#endif
+
+/*!
+ * LZ4_stream_t :
+ * information structure to track an LZ4 stream.
+ * init this structure before first use.
+ * note : only use in association with static linking !
+ *        this definition is not API/ABI safe,
+ *        and may change in a future version !
+ */
+#define LZ4_STREAMSIZE_U64 ((1 << (LZ4_MEMORY_USAGE-3)) + 4)
+#define LZ4_STREAMSIZE     (LZ4_STREAMSIZE_U64 * sizeof(unsigned long long))
+union LZ4_stream_u {
+    unsigned long long table[LZ4_STREAMSIZE_U64];
+    LZ4_stream_t_internal internal_donotuse;
+} ;  /* previously typedef'd to LZ4_stream_t */
+
+
+/*!
+ * LZ4_streamDecode_t :
+ * information structure to track an LZ4 stream during decompression.
+ * init this structure  using LZ4_setStreamDecode (or memset()) before first use
+ * note : only use in association with static linking !
+ *        this definition is not API/ABI safe,
+ *        and may change in a future version !
+ */
+#define LZ4_STREAMDECODESIZE_U64  4
+#define LZ4_STREAMDECODESIZE     (LZ4_STREAMDECODESIZE_U64 * sizeof(unsigned long long))
+union LZ4_streamDecode_u {
+    unsigned long long table[LZ4_STREAMDECODESIZE_U64];
+    LZ4_streamDecode_t_internal internal_donotuse;
+} ;   /* previously typedef'd to LZ4_streamDecode_t */
+
+
+/*=************************************
 *  Obsolete Functions
 **************************************/
-/* Deprecate Warnings */
-/* Should these warnings messages be a problem,
+/* Deprecation warnings */
+/* Should these warnings be a problem,
    it is generally possible to disable them,
-   with -Wno-deprecated-declarations for gcc
-   or _CRT_SECURE_NO_WARNINGS in Visual for example.
-   You can also define LZ4_DEPRECATE_WARNING_DEFBLOCK. */
-#ifndef LZ4_DEPRECATE_WARNING_DEFBLOCK
-#  define LZ4_DEPRECATE_WARNING_DEFBLOCK
+   typically with -Wno-deprecated-declarations for gcc
+   or _CRT_SECURE_NO_WARNINGS in Visual.
+   Otherwise, it's also possible to define LZ4_DISABLE_DEPRECATE_WARNINGS */
+#ifdef LZ4_DISABLE_DEPRECATE_WARNINGS
+#  define LZ4_DEPRECATED(message)   /* disable deprecation warnings */
+#else
 #  define LZ4_GCC_VERSION (__GNUC__ * 100 + __GNUC_MINOR__)
-#  if (LZ4_GCC_VERSION >= 405) || defined(__clang__)
+#  if defined (__cplusplus) && (__cplusplus >= 201402) /* C++14 or greater */
+#    define LZ4_DEPRECATED(message) [[deprecated(message)]]
+#  elif (LZ4_GCC_VERSION >= 405) || defined(__clang__)
 #    define LZ4_DEPRECATED(message) __attribute__((deprecated(message)))
 #  elif (LZ4_GCC_VERSION >= 301)
 #    define LZ4_DEPRECATED(message) __attribute__((deprecated))
@@ -323,20 +425,19 @@ int LZ4_decompress_fast_usingDict (const char* source, char* dest, int originalS
 #    pragma message("WARNING: You need to implement LZ4_DEPRECATED for this compiler")
 #    define LZ4_DEPRECATED(message)
 #  endif
-#endif /* LZ4_DEPRECATE_WARNING_DEFBLOCK */
+#endif /* LZ4_DISABLE_DEPRECATE_WARNINGS */
 
 /* Obsolete compression functions */
-/* These functions are planned to start generate warnings by r131 approximately */
-int LZ4_compress               (const char* source, char* dest, int sourceSize);
-int LZ4_compress_limitedOutput (const char* source, char* dest, int sourceSize, int maxOutputSize);
-int LZ4_compress_withState               (void* state, const char* source, char* dest, int inputSize);
-int LZ4_compress_limitedOutput_withState (void* state, const char* source, char* dest, int inputSize, int maxOutputSize);
-int LZ4_compress_continue                (LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize);
-int LZ4_compress_limitedOutput_continue  (LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize, int maxOutputSize);
+LZ4_DEPRECATED("use LZ4_compress_default() instead") int LZ4_compress               (const char* source, char* dest, int sourceSize);
+LZ4_DEPRECATED("use LZ4_compress_default() instead") int LZ4_compress_limitedOutput (const char* source, char* dest, int sourceSize, int maxOutputSize);
+LZ4_DEPRECATED("use LZ4_compress_fast_extState() instead") int LZ4_compress_withState               (void* state, const char* source, char* dest, int inputSize);
+LZ4_DEPRECATED("use LZ4_compress_fast_extState() instead") int LZ4_compress_limitedOutput_withState (void* state, const char* source, char* dest, int inputSize, int maxOutputSize);
+LZ4_DEPRECATED("use LZ4_compress_fast_continue() instead") int LZ4_compress_continue                (LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize);
+LZ4_DEPRECATED("use LZ4_compress_fast_continue() instead") int LZ4_compress_limitedOutput_continue  (LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize, int maxOutputSize);
 
 /* Obsolete decompression functions */
 /* These function names are completely deprecated and must no longer be used.
-   They are only provided here for compatibility with older programs.
+   They are only provided in lz4.c for compatibility with older programs.
     - LZ4_uncompress is the same as LZ4_decompress_fast
     - LZ4_uncompress_unknownOutputSize is the same as LZ4_decompress_safe
    These function prototypes are now disabled; uncomment them only if you really need them.
@@ -358,3 +459,5 @@ LZ4_DEPRECATED("use LZ4_decompress_fast_usingDict() instead") int LZ4_decompress
 #if defined (__cplusplus)
 }
 #endif
+
+#endif /* LZ4_H_2983827168210 */
-- 
1.8.3.1




