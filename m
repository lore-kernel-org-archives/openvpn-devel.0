From: Antonio Quartulli <a@...2181...>
Date: Sat,  4 Sep 2021 11:56:26 +0200
Message-Id: <20210904095629.6273-5-a@...2181...>
In-Reply-To: <20210904095629.6273-1-a@...2181...>
References: <20210904095629.6273-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/7] do not include --cipher value in
 data-ciphers
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

The --cipher option has been there since a while, but it became more and
more confusing since the introduction of NCP (data cipher negotiation).

The fallback cipher can now be specified via --data-cipher-fallback,
while the list of accepted ciphers is specified via --data-ciphers.

--cipher can still be used for compatibility reasons, but won't affect
the cipher negotiation.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 Changes.rst                          |  5 ++++
 doc/man-sections/generic-options.rst |  2 ++
 src/openvpn/options.c                | 38 ++++++++++++++++------------
 src/openvpn/ssl_ncp.c                | 13 ++++++++++
 src/openvpn/ssl_ncp.h                |  8 ++++++
 5 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 65b838b9..f803b760 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -71,6 +71,11 @@ Deprecated features
     This option mainly served a role as debug option when NCP was first
     introduced. It should now no longer be necessary.
 
+``--cipher`` argument is no longer included in ``--data-ciphers`` by default
+    Data cipher negotiation has been introduced in 2.4.0 and been significantly
+    improved in 2.5.0. The implicit fallback to the cipher specified in
+    ``--cipher`` has been removed.
+
 Compression no longer enabled by default
     Unless an explicit compression option is specified in the configuration,
     ``--allow-compression`` defaults to ``no`` in OpeNVPN 2.6.0.
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index a8d24572..8b26cd1a 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -66,6 +66,8 @@ which mode OpenVPN is configured as.
 
   - 2.5.x or lower: ``--allow-compression asym`` is automatically added
     to the configuration if no other compression options are present.
+  - 2.4.x or lower: The cipher in ``--cipher`` is appended to
+    ``--data-ciphers``
 
 --config file
   Load additional config options from ``file`` where each line corresponds
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 21c76a69..88ac5bed 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3102,26 +3102,20 @@ options_postprocess_cipher(struct options *o)
         /* We still need to set the ciphername to BF-CBC since various other
          * parts of OpenVPN assert that the ciphername is set */
         o->ciphername = "BF-CBC";
+
+        msg(M_INFO, "Note: --cipher is not set. OpenVPN versions before 2.6 "
+                    "defaulted to BF-CBC as fallback when cipher negotiation "
+                    "failed in this case. If you need this fallback please add "
+                    "'--data-ciphers-fallback 'BF-CBC' to your configuration "
+                    "and/or add BF-CBC to --data-ciphers.");
     }
     else if (!o->enable_ncp_fallback
              && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
     {
-        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing in"
-            " --data-ciphers (%s). Future OpenVPN version will "
-            "ignore --cipher for cipher negotiations. "
-            "Add '%s' to --data-ciphers or change --cipher '%s' to "
-            "--data-ciphers-fallback '%s' to silence this warning.",
-            o->ciphername, o->ncp_ciphers, o->ciphername,
-            o->ciphername, o->ciphername);
-        o->enable_ncp_fallback = true;
-
-        /* Append the --cipher to ncp_ciphers to allow it in NCP */
-        size_t newlen = strlen(o->ncp_ciphers) + 1 + strlen(o->ciphername) + 1;
-        char *ncp_ciphers = gc_malloc(newlen, false, &o->gc);
-
-        ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
-                                o->ciphername));
-        o->ncp_ciphers = ncp_ciphers;
+        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing in "
+            "--data-ciphers (%s). OpenVPN ignores --cipher for cipher "
+            "negotiations. ",
+            o->ciphername, o->ncp_ciphers);
     }
 }
 
@@ -3146,6 +3140,18 @@ need_compatibility_before(const struct options *o, int version)
 static void
 options_set_backwards_compatible_options(struct options *o)
 {
+    /* Versions < 2.5.0 do need --cipher in the list of accepted ciphers.
+     * Version 2.4 might probably does not need it but NCP was not so
+     * good with 2.4 and ncp-disable might be more common on 2.4 peers.
+     * Only do this iif --cipher is not explicitly (BF-CBC). This is not
+     * 100% correct backwards compatible behaviour but 2.5 already behaved like
+     * this */
+    if (o->ciphername && need_compatibility_before(o, 20500)
+        && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
+    {
+        append_cipher_to_ncp_list(o, o->ciphername);
+    }
+
     /* Compression is deprecated and we do not want to announce support for it
      * by default anymore, additionally DCO breaks with compression.
      *
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 6967e2bb..022a9dc3 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -172,6 +172,19 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
     return ret;
 }
 
+
+void
+append_cipher_to_ncp_list(struct options *o, const char *ciphername)
+{
+    /* Append the --cipher to ncp_ciphers to allow it in NCP */
+    size_t newlen = strlen(o->ncp_ciphers) + 1 + strlen(ciphername) + 1;
+    char *ncp_ciphers = gc_malloc(newlen, false, &o->gc);
+
+    ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
+                            ciphername));
+    o->ncp_ciphers = ncp_ciphers;
+}
+
 bool
 tls_item_in_cipher_list(const char *item, const char *list)
 {
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 4a2601a2..09ddeb28 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -102,6 +102,14 @@ tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc);
 char *
 mutate_ncp_cipher_list(const char *list, struct gc_arena *gc);
 
+/**
+ * Appends the cipher specified by the ciphernamer parameter to to
+ * the o->ncp_ciphers list.
+ * @param o             options struct to modify. Its gc is also used
+ * @param ciphername    the ciphername to add
+ */
+void append_cipher_to_ncp_list(struct options *o, const char *ciphername);
+
 /**
  * Return true iff item is present in the colon-separated zero-terminated
  * cipher list.
-- 
2.32.0


