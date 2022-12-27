From: Arne Schwabe <arne@...1227...>
Date: Tue, 27 Dec 2022 15:02:46 +0100
Message-Id: <20221227140249.3524943-3-arne@...1227...>
In-Reply-To: <20221227140249.3524943-1-arne@...1227...>
References: <20221227140249.3524943-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/4] Ensure we do not promote a
 TA_TIMEOUT to a TA_READ event with dco
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

with dco sometimes we end up promoting a timeout event to read event.
For the residual read, this problem is probably not solvable without
changing the kernel DCO API (ie. passing our residual on new_peer to
let the kernel handle assembling the next packet.)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 24 ------------------------
 src/openvpn/forward.h | 30 ++++++++++++++++++++++++++++++
 src/openvpn/mtcp.c    | 12 +++++++++++-
 3 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index af4ed05da..61caf1146 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1676,30 +1676,6 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
     }
 }
 
-/*
- * Linux DCO implementations pass the socket to the kernel and
- * disallow usage of it from userland for TCP, so (control) packets
- * sent and received by OpenVPN need to go through the DCO interface.
- *
- * Windows DCO needs control packets to be sent via the normal
- * standard Overlapped I/O.
- *
- * FreeBSD DCO allows control packets to pass through the socket in both
- * directions.
- *
- * Hide that complexity (...especially if more platforms show up
- * in the future...) in a small inline function.
- */
-static inline bool
-should_use_dco_socket(struct link_socket *ls)
-{
-#if defined(TARGET_LINUX)
-    return ls->dco_installed && proto_is_tcp(ls->info.proto);
-#else
-    return false;
-#endif
-}
-
 /*
  * Input: c->c2.to_link
  */
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index bd2d96010..5cddb5995 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -424,4 +424,34 @@ connection_established(struct context *c)
     }
 }
 
+
+/**
+ * @param ls the link_socket the decision should be made for
+ * @return if we should use the dco kernel api or normal socket APIs for
+ *         write/send
+ *
+ *
+ * Linux DCO implementations pass the socket to the kernel and
+ * disallow usage of it from userland for TCP, so (control) packets
+ * sent and received by OpenVPN need to go through the DCO interface.
+ *
+ * Windows DCO needs control packets to be sent via the normal
+ * standard Overlapped I/O.
+ *
+ * FreeBSD DCO allows control packets to pass through the socket in both
+ * directions.
+ *
+ * Hide that complexity (...especially if more platforms show up
+ * in the future...) in a small inline function.
+ */
+static inline bool
+should_use_dco_socket(const struct link_socket *ls)
+{
+#if defined(TARGET_LINUX)
+    return ls->dco_installed && proto_is_tcp(ls->info.proto);
+#else
+    return false;
+#endif
+}
+
 #endif /* FORWARD_H */
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index ac06ddc64..519630544 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -407,7 +407,7 @@ multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, const in
         /* If we got a socket that has been handed over to the kernel
          * we must not call the normal socket function to figure out
          * if it is readable or writable */
-        /* Assert that we only have the DCO exptected flags */
+        /* Assert that we only have the DCO expected flags */
         ASSERT(action & (TA_SOCKET_READ | TA_SOCKET_WRITE));
 
         /* We are always ready! */
@@ -586,6 +586,16 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
         case MTP_NONE:
             if (mi && socket_read_residual(c->c2.link_socket))
             {
+                if (should_use_dco_socket(c->c2.link_socket))
+                {
+                    struct gc_arena gc = gc_new();
+                    msg(M_INFO, "ovpn-dco installed socket with residual read "
+                        "len=%d, mi=%s. This connection will probably"
+                        " break.",  BLEN(&c->c2.link_socket->stream_buf.residual),
+                        multi_instance_string(mi, false, &gc));
+                    gc_free(&gc);
+                    break;
+                }
                 newaction = TA_SOCKET_READ_RESIDUAL;
             }
             else
-- 
2.37.1 (Apple Git-137.1)


