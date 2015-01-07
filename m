From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  7 Jan 2015 21:26:38 +0200
Message-Id: <1420658798-29943-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Disallow lameduck's float to an address
	taken by another client
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

Existing check didn't take into account the case when floated client is
lame duck (CN for lame duck is NULL), which allowed lame duck to float
to an address taken by another client.

As a fix we use cert_hash_compare function which, besides fixing
mentioned case, also allows lame duck to float to an address already
taken by the same client.
---
 src/openvpn/multi.c      | 13 ++++++++-----
 src/openvpn/ssl_verify.c |  2 +-
 src/openvpn/ssl_verify.h |  8 ++++++++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6ddfbb5..4412491 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2127,17 +2127,20 @@ void multi_process_float (struct multi_context* m, struct multi_instance* mi)
   const uint32_t hv = hash_value (hash, &real);
   struct hash_bucket *bucket = hash_bucket (hash, hv);
 
+  /* make sure that we don't float to an address taken by another client */
   struct hash_element *he = hash_lookup_fast (hash, bucket, &real, hv);
   if (he)
     {
       struct multi_instance *ex_mi = (struct multi_instance *) he->value;
 
-      const char *cn = tls_common_name (mi->context.c2.tls_multi, true);
-      const char *ex_cn = tls_common_name (ex_mi->context.c2.tls_multi, true);
-      if (cn && ex_cn && strcmp (cn, ex_cn))
+      struct tls_multi *m1 = mi->context.c2.tls_multi;
+      struct tls_multi *m2 = ex_mi->context.c2.tls_multi;
+
+      /* do not float if target address is taken by client with another cert */
+      if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
 	{
-	  msg (D_MULTI_MEDIUM, "prevent float to %s",
-		multi_instance_string (ex_mi, false, &gc));
+	  msg (D_MULTI_MEDIUM, "Disallow float to an address taken by another client %s",
+	       multi_instance_string (ex_mi, false, &gc));
 
 	  mi->context.c2.buf.len = 0;
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index cec5f02..ad50458 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -238,7 +238,7 @@ cert_hash_free (struct cert_hash_set *chs)
     }
 }
 
-static bool
+bool
 cert_hash_compare (const struct cert_hash_set *chs1, const struct cert_hash_set *chs2)
 {
   if (chs1 && chs2)
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 5f23431..d5bf22e 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -137,6 +137,14 @@ const char *tls_common_name (const struct tls_multi* multi, const bool null);
  */
 const char *tls_username (const struct tls_multi *multi, const bool null);
 
+/**
+ * Compares certificates hashes, returns true if hashes are equal.
+ *
+ * @param chs1 cert 1 hash set
+ * @param chs2 cert 2 hash set
+ */
+bool cert_hash_compare (const struct cert_hash_set *chs1, const struct cert_hash_set *chs2);
+
 #ifdef ENABLE_PF
 
 /**
-- 
1.9.1


