From: Arne Schwabe <arne@...1227...>
Date: Mon, 13 Mar 2023 14:42:33 +0100
Message-Id: <20230313134233.60335-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix memory leaks in HMAC initial packet
 id and dco open tun
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

The open_tun_dco_generic already allocates the actual_name string, this
shadows the allocation in the FreeBSD/Linux specific methods.

The HMAC leaks are just forgotten frees/deinitialisations.

Found-By: clang with asan

Patch v2: rebase. Include linux bits accidentially forgotten.

Change-Id: I3c344af047abe94c0178bde1781eb450f10d157d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco_freebsd.c |  1 -
 src/openvpn/dco_linux.c   |  1 -
 src/openvpn/init.c        |  2 ++
 src/openvpn/mudp.c        |  1 +
 src/openvpn/ssl.c         | 11 +++++++++++
 src/openvpn/ssl.h         |  6 ++++++
 6 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 92de5f04b..e605f2a9d 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -230,7 +230,6 @@ create_interface(struct tuntap *tt, const char *dev)
     }
 
     snprintf(tt->dco.ifname, IFNAMSIZ, "%s", ifr.ifr_data);
-    tt->actual_name = string_alloc(tt->dco.ifname, NULL);
 
     /* see "Interface Flags" in ifnet(9) */
     int i = IFF_POINTOPOINT | IFF_MULTICAST;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 2b349529f..0f5fc48d9 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -457,7 +457,6 @@ open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
         msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);
     }
 
-    tt->actual_name = string_alloc(dev, NULL);
     tt->dco.dco_message_peer_id = -1;
 
     ovpn_dco_register(&tt->dco);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 124ac76bd..e59edd742 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3881,6 +3881,8 @@ do_close_tls(struct context *c)
         md_ctx_cleanup(c->c2.pulled_options_state);
         md_ctx_free(c->c2.pulled_options_state);
     }
+
+    tls_auth_standalone_free(c->c2.tls_auth_standalone);
 }
 
 /*
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 8698aefc8..813160639 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -61,6 +61,7 @@ send_hmac_reset_packet(struct multi_context *m,
     m->hmac_reply = c->c2.buffers->aux_buf;
     m->hmac_reply_dest = &m->top.c2.from;
     msg(D_MULTI_DEBUG, "Reset packet from client, sending HMAC based reset challenge");
+    free_buf(&buf);
 }
 
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 78cec90a1..fe6390fad 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1361,6 +1361,17 @@ tls_auth_standalone_init(struct tls_options *tls_options,
     return tas;
 }
 
+void
+tls_auth_standalone_free(struct tls_auth_standalone *tas)
+{
+    if (!tas)
+    {
+        return;
+    }
+
+    packet_id_free(&tas->tls_wrap.opt.packet_id);
+}
+
 /*
  * Set local and remote option compatibility strings.
  * Used to verify compatibility of local and remote option
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 58ff4b9b4..a050cd5c9 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -180,6 +180,12 @@ void tls_multi_init_finalize(struct tls_multi *multi, int tls_mtu);
 struct tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_options,
                                                      struct gc_arena *gc);
 
+/**
+ * Frees a standalone tls-auth verification object.
+ * @param tas   the object to free. May be NULL.
+ */
+void tls_auth_standalone_free(struct tls_auth_standalone *tas);
+
 /*
  * Setups the control channel frame size parameters from the data channel
  * parameters
-- 
2.37.1 (Apple Git-137.1)


