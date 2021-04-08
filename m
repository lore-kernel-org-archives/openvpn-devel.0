From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Apr 2021 14:00:28 +0200
Message-Id: <20210408120029.19438-2-arne@...1227...>
In-Reply-To: <20210408120029.19438-1-arne@...1227...>
References: <20210408120029.19438-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/3] Also restore/save compress related
 options in reconnects
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 11 +++++++++++
 src/openvpn/options.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a72e1b9ae..00ad98f15 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3595,9 +3595,15 @@ pre_connect_save(struct options *o)
     o->pre_connect->authname = o->authname;
 
     /* Ping related options should be reset to the config values on reconnect */
+
     o->pre_connect->ping_rec_timeout = o->ping_rec_timeout;
     o->pre_connect->ping_rec_timeout_action = o->ping_rec_timeout_action;
     o->pre_connect->ping_send_timeout = o->ping_send_timeout;
+
+    /* Miscellaneous Options */
+#ifdef USE_COMP
+    o->pre_connect->comp = o->comp;
+#endif
 }
 
 void
@@ -3650,6 +3656,11 @@ pre_connect_restore(struct options *o, struct gc_arena *gc)
         o->ping_rec_timeout = pp->ping_rec_timeout;
         o->ping_rec_timeout_action = pp->ping_rec_timeout_action;
         o->ping_send_timeout = pp->ping_send_timeout;
+
+        /* Miscellaneous Options */
+#ifdef USE_COMP
+        o->comp = pp->comp;
+#endif
     }
 
     o->push_continuation = 0;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 078bed75b..f52768680 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -81,6 +81,9 @@ struct options_pre_connect
     int ping_rec_timeout_action;
 
     int foreign_option_index;
+#ifdef USE_COMP
+    struct compress_options comp;
+#endif
 };
 
 #if !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_MBEDTLS)
-- 
2.31.1


