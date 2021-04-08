From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Apr 2021 16:02:26 +0200
Message-Id: <20210408140229.31824-2-arne@...1227...>
In-Reply-To: <20210408140229.31824-1-arne@...1227...>
References: <20210408140229.31824-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/3] Change options->data_channel_use_ekm to
 flags
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

Instead maintaining two different representation of the data channel
options in struct options and struct tls_options, use the same
flags variable that tls_options uses.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c   | 5 ++++-
 src/openvpn/options.c | 4 ++--
 src/openvpn/options.h | 4 ++--
 src/openvpn/push.c    | 2 +-
 src/openvpn/ssl.c     | 6 ++----
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d5f34c349..e6eb34bfb 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1783,7 +1783,10 @@ multi_client_set_protocol_options(struct context *c)
     }
 
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
-    o->data_channel_use_ekm = (proto & IV_PROTO_TLS_KEY_EXPORT);
+    if (proto & IV_PROTO_TLS_KEY_EXPORT)
+    {
+        o->data_channel_crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
+    }
 #endif
 
     /* Select cipher if client supports Negotiable Crypto Parameters */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9e61b1e05..24d722fd5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3651,7 +3651,7 @@ pre_pull_restore(struct options *o, struct gc_arena *gc)
 
     o->push_continuation = 0;
     o->push_option_types_found = 0;
-    o->data_channel_use_ekm = false;
+    o->data_channel_crypto_flags = 0;
 }
 
 /**
@@ -7949,7 +7949,7 @@ add_option(struct options *options,
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
         if (streq(p[1], "tls-ekm"))
         {
-            options->data_channel_use_ekm = true;
+            options->data_channel_crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
         }
         else
 #endif
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 65e5ffccf..b80cd3d1b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -651,8 +651,8 @@ struct options
      * to the routing tables that would move packets into the tunnel. */
     bool allow_recursive_routing;
 
-    /* Use RFC5705 key export to generate data channel keys */
-    bool data_channel_use_ekm;
+    /* data channel crypto flags set by push/pull. Reuses the CO_* crypto_flags */
+    unsigned int data_channel_crypto_flags;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 15a9141ee..2e92d8ee2 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -595,7 +595,7 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
     {
         push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
     }
-    if (o->data_channel_use_ekm)
+    if (o->data_channel_crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT)
     {
         push_option_fmt(gc, push_list, M_USAGE, "key-derivation tls-ekm");
     }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d8662d000..5d65c3da5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1860,10 +1860,8 @@ tls_session_update_crypto_params(struct tls_session *session,
         return false;
     }
 
-    if (options->data_channel_use_ekm)
-    {
-        session->opt->crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
-    }
+    /* Import crypto settings that might be set by pull/push */
+    session->opt->crypto_flags |= options->data_channel_crypto_flags;
 
     if (strcmp(options->ciphername, session->opt->config_ciphername))
     {
-- 
2.31.1


