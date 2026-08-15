Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A215C5AD5A
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WTDbc1WnYUg7W98Ty4TKmhPcMy9nXqsed/2oM+sACuA=; b=FIEf5F1CO6eO8JZDCgUclHT1Rq
	EuZ/beMqVqU0G/NWuZCtG9pwuDaE/Ja//dtVvpNRX2ZM6W4l7CQdlMB1dpHUucbvujkzYlxmZ5QQt
	geom97nfoyPkPaLOVN+ZVZt1W37RkdshxSD9k/E4nrPicq2jbUDjKki0UNKlM5VNqpEQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvE1E-0007yW-La;
	Sat, 15 Aug 2026 13:01:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wvE1C-0007yP-RU
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 13:01:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iWTLI0AbG8lYCmS0BGLWkWPr8Ug49TKffukUO2uZHNY=; b=I/fbA43zGGqlCUgAT+DVEPdyai
 0ZHbjaMitmFDmkvX+yYZTBBSMCw7/tWL/iLKQzI8f2jesOoB5lcF/dPjbnydV3w6f7IUjmI62pvnR
 ChnhccR3CLSiYI8qFHZhXcE5xcMEWVu9yNEfKrEKBDHVmyskB7C2j0C8cBJqbs25vb0E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iWTLI0AbG8lYCmS0BGLWkWPr8Ug49TKffukUO2uZHNY=; b=L9h5mtvlnlAZ5hSwUL6QNGH0a0
 uOJ/FqLU1d+cDdvkaw7836cb7YTmlqvqw9/n9GLnCvf+B/h4Ipzq6DxoaSZ5zwRWhgn/ScnShqVvi
 qYsWUg61C/UB77nIK39fTQaUZJ7hDkUNMkRtXRKlhrauteza/ceqW6ML5/wbFgQxX+GQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvE1B-0000DU-QT for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 13:01:47 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67FD1dVb019857
 for <openvpn-devel@lists.sourceforge.net>; Sat, 15 Aug 2026 15:01:39 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67FD1dpS019856
 for openvpn-devel@lists.sourceforge.net; Sat, 15 Aug 2026 15:01:39 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 15 Aug 2026 15:01:30 +0200
Message-ID: <20260815130138.19838-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wvE1B-0000DU-QT
Subject: [Openvpn-devel] [PATCH v27] Replace custom hash_func with siphash
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Arne Schwabe <arne@rfc2549.org>

Benchmarking the two functions gives a bit better
performance to the custom hash function but also it is
difficult to get a good measurement since the order of
magnitude that these function use is similar to the
test framework itself.

However siphash24 is a modern and better suited
function for the hash tables that we are using
because the inputs are controlled by the
peers (e.g. source IP address).

Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1573
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1573
This mail reflects revision 27 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index ad7de6e..789c0d4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -571,6 +571,7 @@
     src/openvpn/shaper.h
     src/openvpn/sig.c
     src/openvpn/sig.h
+    src/openvpn/siphash.c
     src/openvpn/siphash.h
     src/openvpn/siphash_reference.c
     src/openvpn/socket.c
@@ -838,6 +839,9 @@
         src/openvpn/list.c
         src/openvpn/session_id.c
         src/openvpn/schedule.c
+        src/openvpn/siphash.h
+        src/openvpn/siphash.c
+        src/openvpn/siphash_reference.c
     )
 
     target_sources(test_ncp PRIVATE
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 1f77384..f5a7621 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -128,7 +128,8 @@
 	session_id.c session_id.h \
 	shaper.c shaper.h \
 	sig.c sig.h \
-	siphash_reference.c siphash.h \
+	siphash_reference.c \
+	siphash.c siphash.h \
 	socket.c socket.h \
 	socket_util.c socket_util.h \
 	socks.c socks.h \
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index e52c778..9e80761 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -31,9 +31,6 @@
 #include "list.h"
 
 #include "crypto.h"
-#include "misc.h"
-
-#include "memdbg.h"
 
 struct hash *
 hash_init(const uint32_t n_buckets,
@@ -316,178 +313,3 @@
     hi->last->key = NULL;
     hi->bucket_marked = true;
 }
-
-
-/*
- * --------------------------------------------------------------------
- * hash() -- hash a variable-length key into a 32-bit value
- * k     : the key (the unaligned variable-length array of bytes)
- * len   : the length of the key, counting by bytes
- * level : can be any 4-byte value
- * Returns a 32-bit value.  Every bit of the key affects every bit of
- * the return value.  Every 1-bit and 2-bit delta achieves avalanche.
- * About 36+6len instructions.
- *
- * #define hashsize(n) ((uint32_t)1<<(n))
- * #define hashmask(n) (hashsize(n)-1)
- *
- * The best hash table sizes are powers of 2.  There is no need to do
- * mod a prime (mod is sooo slow!).  If you need less than 32 bits,
- * use a bitmask.  For example, if you need only 10 bits, do
- * h = (h & hashmask(10));
- * In which case, the hash table should have hashsize(10) elements.
- *
- * If you are hashing n strings (uint8_t **)k, do it like this:
- * for (i=0, h=0; i<n; ++i) h = hash( k[i], len[i], h);
- *
- * By Bob Jenkins, 1996.  bob_jenkins@burtleburtle.net.  You may use this
- * code any way you wish, private, educational, or commercial.  It's free.
- *
- * See https://burtleburtle.net/bob/hash/evahash.html
- * Use for hash table lookup, or anything where one collision in 2^32 is
- * acceptable.  Do NOT use for cryptographic purposes.
- *
- * --------------------------------------------------------------------
- *
- * mix -- mix 3 32-bit values reversibly.
- * For every delta with one or two bit set, and the deltas of all three
- * high bits or all three low bits, whether the original value of a,b,c
- * is almost all zero or is uniformly distributed,
- * If mix() is run forward or backward, at least 32 bits in a,b,c
- * have at least 1/4 probability of changing.
- * If mix() is run forward, every bit of c will change between 1/3 and
- * 2/3 of the time.  (Well, 22/100 and 78/100 for some 2-bit deltas.)
- * mix() was built out of 36 single-cycle latency instructions in a
- * structure that could supported 2x parallelism, like so:
- *    a -= b;
- *    a -= c; x = (c>>13);
- *    b -= c; a ^= x;
- *    b -= a; x = (a<<8);
- *    c -= a; b ^= x;
- *    c -= b; x = (b>>13);
- *    ...
- * Unfortunately, superscalar Pentiums and Sparcs can't take advantage
- * of that parallelism.  They've also turned some of those single-cycle
- * latency instructions into multi-cycle latency instructions.  Still,
- * this is the fastest good hash I could find.  There were about 2^^68
- * to choose from.  I only looked at a billion or so.
- *
- * James Yonan Notes:
- *
- * This function is faster than it looks, and appears to be
- * appropriate for our usage in OpenVPN which is primarily
- * for hash-table based address lookup (IPv4, IPv6, and Ethernet MAC).
- * NOTE: This function is never used for cryptographic purposes, only
- * to produce evenly-distributed indexes into hash tables.
- *
- * Benchmark results: 11.39 machine cycles per byte on a P2 266Mhz,
- *                   and 12.1 machine cycles per byte on a
- *                   2.2 Ghz P4 when hashing a 6 byte string.
- * --------------------------------------------------------------------
- */
-
-#define mix(a, b, c)    \
-    {                   \
-        a -= b;         \
-        a -= c;         \
-        a ^= (c >> 13); \
-        b -= c;         \
-        b -= a;         \
-        b ^= (a << 8);  \
-        c -= a;         \
-        c -= b;         \
-        c ^= (b >> 13); \
-        a -= b;         \
-        a -= c;         \
-        a ^= (c >> 12); \
-        b -= c;         \
-        b -= a;         \
-        b ^= (a << 16); \
-        c -= a;         \
-        c -= b;         \
-        c ^= (b >> 5);  \
-        a -= b;         \
-        a -= c;         \
-        a ^= (c >> 3);  \
-        b -= c;         \
-        b -= a;         \
-        b ^= (a << 10); \
-        c -= a;         \
-        c -= b;         \
-        c ^= (b >> 15); \
-    }
-
-uint64_t
-hash_func(const uint8_t *k, uint32_t length, uint32_t initval)
-{
-    uint32_t a, b, c, len;
-
-    /* Set up the internal state */
-    len = length;
-    a = b = 0x9e3779b9; /* the golden ratio; an arbitrary value */
-    c = initval;        /* the previous hash value */
-
-    /*---------------------------------------- handle most of the key */
-    while (len >= 12)
-    {
-        a += (k[0] + ((uint32_t)k[1] << 8) + ((uint32_t)k[2] << 16) + ((uint32_t)k[3] << 24));
-        b += (k[4] + ((uint32_t)k[5] << 8) + ((uint32_t)k[6] << 16) + ((uint32_t)k[7] << 24));
-        c += (k[8] + ((uint32_t)k[9] << 8) + ((uint32_t)k[10] << 16) + ((uint32_t)k[11] << 24));
-        mix(a, b, c);
-        k += 12;
-        len -= 12;
-    }
-
-    /*------------------------------------- handle the last 11 bytes */
-    c += length;
-    switch (len) /* all the case statements fall through */
-    {
-        case 11:
-            c += ((uint32_t)k[10] << 24);
-            /* Intentional [[fallthrough]]; */
-
-        case 10:
-            c += ((uint32_t)k[9] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        case 9:
-            c += ((uint32_t)k[8] << 8);
-        /* Intentional [[fallthrough]]; */
-
-        /* the first byte of c is reserved for the length */
-        case 8:
-            b += ((uint32_t)k[7] << 24);
-            /* Intentional [[fallthrough]]; */
-
-        case 7:
-            b += ((uint32_t)k[6] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        case 6:
-            b += ((uint32_t)k[5] << 8);
-            /* Intentional [[fallthrough]]; */
-
-        case 5:
-            b += k[4];
-            /* Intentional [[fallthrough]]; */
-
-        case 4:
-            a += ((uint32_t)k[3] << 24);
-            /* Intentional [[fallthrough]]; */
-
-        case 3:
-            a += ((uint32_t)k[2] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        case 2:
-            a += ((uint32_t)k[1] << 8);
-            /* Intentional [[fallthrough]]; */
-
-        case 1:
-            a += k[0];
-            /* case 0: nothing left to add */
-    }
-    mix(a, b, c);
-    /*-------------------------------------- report the result */
-    return c;
-}
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index cbf1abf..55bc3c8 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -50,7 +50,7 @@
 };
 
 
-#define HASH_KEY_LEN 4
+#define HASH_KEY_LEN 16
 
 struct hash
 {
@@ -103,8 +103,6 @@
 
 void hash_iterator_free(struct hash_iterator *hi);
 
-uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
-
 static inline uint64_t
 hash_value(const struct hash *hash, const void *key)
 {
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index a5179d0..edf8239 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -33,6 +33,7 @@
 #include "socket_util.h"
 
 #include "memdbg.h"
+#include "siphash.h"
 
 void
 mroute_addr_init(struct mroute_addr *addr)
@@ -357,8 +358,8 @@
 uint64_t
 mroute_addr_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
-    return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
-                     mroute_addr_hash_len((const struct mroute_addr *)key), *(uint32_t *)hash_key);
+    return siphash_hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
+                             mroute_addr_hash_len((const struct mroute_addr *)key), hash_key);
 }
 
 bool
diff --git a/src/openvpn/siphash.c b/src/openvpn/siphash.c
new file mode 100644
index 0000000..e31b708
--- /dev/null
+++ b/src/openvpn/siphash.c
@@ -0,0 +1,49 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include <stdlib.h>
+#include "syshead.h"
+#include "siphash.h"
+#include "buffer.h"
+#include "crypto.h"
+#include "list.h"
+
+static_assert(SIPHASH_KEY_SIZE <= HASH_KEY_LEN, "hash map key size must be at least the same as siphash key size");
+
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, const uint8_t hash_key[SIPHASH_KEY_SIZE])
+{
+    /* This is not endian-safe but we only care about local hashes here
+     * and reversing the byte does not make the hash functions any
+     * weaker or less usable */
+    union
+    {
+        uint8_t out[8];
+        uint64_t hash;
+    } ret;
+    siphash(k, length, hash_key, ret.out, sizeof(ret.out));
+    return ret.hash;
+}
\ No newline at end of file
diff --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h
index 462175c..26516e1 100644
--- a/src/openvpn/siphash.h
+++ b/src/openvpn/siphash.h
@@ -87,4 +87,15 @@
     prng_bytes(key, SIPHASH_KEY_SIZE);
 }
 
+/**
+ * Wrapper of the siphash function to be able to use it in the
+ * hash map.
+ *
+ * @param k the data to hash
+ * @param length length of the data to hash
+ * @param hash_key   the siphash key
+ * @return a uint64_t containing the result of the hashing
+ */
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, const uint8_t hash_key[SIPHASH_KEY_SIZE]);
 #endif /* ifndef SIPHASH_H */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index f2c7a0d..6db611e 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -86,6 +86,7 @@
 	$(top_srcdir)/src/openvpn/mtu.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/mss.c \
+	$(top_srcdir)/src/openvpn/siphash.c \
 	$(top_srcdir)/src/openvpn/siphash_reference.c
 
 dhcp_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
@@ -383,7 +384,9 @@
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/list.c \
 	$(top_srcdir)/src/openvpn/otime.c \
-	$(top_srcdir)/src/openvpn/schedule.c
+	$(top_srcdir)/src/openvpn/schedule.c \
+	$(top_srcdir)/src/openvpn/siphash.c \
+	$(top_srcdir)/src/openvpn/siphash_reference.c
 
 push_update_msg_testdriver_CFLAGS = -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 3ebbfc1..5f03860 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <setjmp.h>
 #include <cmocka.h>
+#include <siphash.h>
 
 #include "ssl_util.h"
 #include "options_util.h"
@@ -135,7 +136,7 @@
 {
     const char *str = (const char *)key;
     const uint32_t len = (uint32_t)strlen(str);
-    return hash_func((const uint8_t *)str, len, *(uint32_t *)(hash_key));
+    return siphash_hash_func((const uint8_t *)str, len, hash_key);
 }
 
 static bool


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
