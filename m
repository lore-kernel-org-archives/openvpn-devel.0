From: Gert Doering <gert@...1296...>
Date: Wed,  4 Mar 2026 17:44:55 +0100
Message-ID: <20260304164502.15449-1-gert@...1296...>
In-Reply-To: <gerrit.1769512571000.I525a5b1b9b6f173cdf12341aefc44d58f0d43aed@...2715...>
References: <gerrit.1769512571000.I525a5b1b9b6f173cdf12341aefc44d58f0d43aed@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] cryptoapi: Change signature of
 parse_hexstring to match code
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

From: Frank Lichtenheld <frank@...2641...>

parse_hexdigest is a function that is used in
exactly one place (not counting tests). So
change the types in a way that they match what
the caller actually wants (DWORD) and so we
do not have any unnecessary conversions.

Change-Id: I525a5b1b9b6f173cdf12341aefc44d58f0d43aed
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1492
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1492
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index b74320d..e17936a 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -61,7 +61,7 @@
     return 0;
 }
 
-#else /* HAVE_XKEY_PROVIDER */
+#else  /* HAVE_XKEY_PROVIDER */
 
 static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;
 
@@ -145,11 +145,6 @@
     free(cd);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /**
  * Parse a hex string with optional embedded spaces into
  * a byte array.
@@ -158,10 +153,10 @@
  * @param capacity  capacity of the byte array arr
  * @returns the number of bytes parsed or 0 on error
  */
-int
-parse_hexstring(const char *p, unsigned char *arr, size_t capacity)
+static DWORD
+parse_hexstring(const char *p, unsigned char *arr, DWORD capacity)
 {
-    int i = 0;
+    DWORD i = 0;
     for (; *p && i < capacity; p += 2)
     {
         /* skip spaces */
@@ -182,10 +177,6 @@
     return i;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void *
 decode_object(struct gc_arena *gc, LPCSTR struct_type, const CRYPT_OBJID_BLOB *val, DWORD flags,
               DWORD *cb)
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index ce527d7..59a356d 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -469,7 +469,7 @@
 
     for (size_t i = 0; i < _countof(valid_str); i++)
     {
-        int len = parse_hexstring(valid_str[i], hash, _countof(hash));
+        DWORD len = parse_hexstring(valid_str[i], hash, _countof(hash));
         assert_int_equal(len, sizeof(test_hash));
         assert_memory_equal(hash, test_hash, sizeof(test_hash));
         memset(hash, 0, _countof(hash));
@@ -477,7 +477,7 @@
 
     for (size_t i = 0; i < _countof(invalid_str); i++)
     {
-        int len = parse_hexstring(invalid_str[i], hash, _countof(hash));
+        DWORD len = parse_hexstring(invalid_str[i], hash, _countof(hash));
         assert_int_equal(len, 0);
     }
 }

