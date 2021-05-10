From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 May 2021 15:13:56 +0200
Message-Id: <20210510131356.968965-1-arne@...1227...>
In-Reply-To: <20210422151724.2132573-1-arne@...1227...>
References: <20210422151724.2132573-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Use exponential backoff for caching in
 tls_authentication_status
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

The caching in tls_authentication_status broke the quick reaction to
authentication status in the code paths that did not do caching like
PUSH_REQUEST reply code path.

This patch introduces exponential backoff for the caching so we still
retain the quick reaction while still keeping the benefit of caching.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c      |  3 +--
 src/openvpn/push.c       |  2 +-
 src/openvpn/ssl.c        |  2 +-
 src/openvpn/ssl.h        |  3 ---
 src/openvpn/ssl_common.h |  5 ++++-
 src/openvpn/ssl_verify.c | 25 +++++++++++++++++++++++--
 src/openvpn/ssl_verify.h |  8 +++-----
 7 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ab2270a58..3f9710134 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2596,8 +2596,7 @@ static const multi_client_connect_handler client_connect_handlers[] = {
 static void
 multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 {
-    if (tls_authentication_status(mi->context.c2.tls_multi, TLS_MULTI_AUTH_STATUS_INTERVAL)
-        != TLS_AUTHENTICATION_SUCCEEDED)
+    if (tls_authentication_status(mi->context.c2.tls_multi) != TLS_AUTHENTICATION_SUCCEEDED)
     {
         return;
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 671220c3f..5c6528b05 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -864,7 +864,7 @@ process_incoming_push_request(struct context *c)
     int ret = PUSH_MSG_ERROR;
 
 
-    if (tls_authentication_status(c->c2.tls_multi, TLS_MULTI_AUTH_STATUS_INTERVAL) == TLS_AUTHENTICATION_FAILED
+    if (tls_authentication_status(c->c2.tls_multi) == TLS_AUTHENTICATION_FAILED
         || c->c2.tls_multi->multi_state == CAS_FAILED)
     {
         const char *client_reason = tls_client_reason(c->c2.tls_multi);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7d66cf565..4ddb02cb0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3133,7 +3133,7 @@ tls_multi_process(struct tls_multi *multi,
 
     update_time();
 
-    enum tls_auth_status tas = tls_authentication_status(multi, TLS_MULTI_AUTH_STATUS_INTERVAL);
+    enum tls_auth_status tas = tls_authentication_status(multi);
 
     /*
      * If lame duck session expires, kill it.
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 2791143f6..81cc22131 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -91,9 +91,6 @@
 #define TLS_MULTI_HORIZON 2     /* call tls_multi_process frequently for n seconds after
                                  * every packet sent/received action */
 
-/* Interval that tls_multi_process should call tls_authentication_status */
-#define TLS_MULTI_AUTH_STATUS_INTERVAL 10
-
 /*
  * Buffer sizes (also see mtu.h).
  */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 52488a163..93b01a587 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -570,10 +570,13 @@ struct tls_multi
     char *locked_username;
     struct cert_hash_set *locked_cert_hash_set;
 
-    /* Time of last when we updated the cached state of
+    /** Time of last when we updated the cached state of
      * tls_authentication_status deferred files */
     time_t tas_cache_last_update;
 
+    /** The number of times we updated the cache */
+    unsigned int tas_cache_num_updates;
+
     /*
      * An error message to send to client on AUTH_FAILED
      */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index b1b01f777..5473ce6a4 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1073,8 +1073,28 @@ key_state_test_auth_control_file(struct auth_deferred_status *ads, bool cached)
     return ACF_DISABLED;
 }
 
+/**
+ * The minimum times to have passed to update the cache. Older versions
+ * of OpenVPN had code path that did not do any caching, so we start
+ * with no caching (0) here as well to have the same super quick initial
+ * reaction.
+ */
+static time_t cache_intervals[] = {0, 0, 0, 0, 0, 1, 1, 2, 2, 4, 8};
+
+/**
+ * uses cache_intervals times to determine if we should update the
+ * cache.
+ */
+static bool
+tls_authentication_status_use_cache(struct tls_multi *multi)
+{
+    unsigned int idx = min_uint(multi->tas_cache_num_updates, SIZE(cache_intervals) - 1);
+    time_t latency = cache_intervals[idx];
+    return multi->tas_cache_last_update + latency >= now;
+}
+
 enum tls_auth_status
-tls_authentication_status(struct tls_multi *multi, const int latency)
+tls_authentication_status(struct tls_multi *multi)
 {
     bool deferred = false;
 
@@ -1087,7 +1107,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
     /* at least one key already failed authentication */
     bool failed_auth = false;
 
-    bool cached = multi->tas_cache_last_update + latency >= now;
+    bool cached = tls_authentication_status_use_cache(multi);
 
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
@@ -1143,6 +1163,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
     if (!cached)
     {
         multi->tas_cache_last_update = now;
+        multi->tas_cache_num_updates++;
     }
 
 #if 0
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 06b88b568..4f18660fd 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -75,7 +75,7 @@ enum tls_auth_status
 /**
  * Return current session authentication state of the tls_multi structure
  * This will return TLS_AUTHENTICATION_SUCCEEDED only if the session is
- * fully authenicated, i.e. VPN traffic is allowed over it.
+ * fully authenticated, i.e. VPN traffic is allowed over it.
  *
  * Checks the status of all active keys and checks if the deferred
  * authentication has succeeded.
@@ -84,15 +84,13 @@ enum tls_auth_status
  * from KS_AUTH_DEFERRED to KS_AUTH_FALSE/KS_AUTH_TRUE if the deferred
  * authentication has succeeded after last call.
  *
- * @param   latency     if not null,  return TLS_AUTHENTICATION_UNDEFINED if
- *                      the last call for this multi struct has been less
- *                      than latency seconds ago
+ *
  * @param   multi       the tls_multi struct to operate on
  *
  * @return              Current authentication status of the tls_multi
  */
 enum tls_auth_status
-tls_authentication_status(struct tls_multi *multi, const int latency);
+tls_authentication_status(struct tls_multi *multi);
 
 /** Check whether the \a ks \c key_state has finished the key exchange part
  *  of the OpenVPN hand shake. This is that the key_method_2read/write
-- 
2.31.1


