From: Arne Schwabe <arne@...1227...>
Date: Mon, 13 Mar 2023 14:33:23 +0100
Message-Id: <20230313133323.59367-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix memory leaks in HMAC initial packet id
 and dco open tun
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

Change-Id: I3c344af047abe94c0178bde1781eb450f10d157d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco_freebsd.c |  1 -
 src/openvpn/init.c        |  2 ++
 src/openvpn/ssl.c         | 11 +++++++++++
 src/openvpn/ssl.h         |  6 ++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index cbd2ce205..70bf9d61d 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -230,7 +230,6 @@ create_interface(struct tuntap *tt, const char *dev)
     }
 
     snprintf(tt->dco.ifname, IFNAMSIZ, "%s", ifr.ifr_data);
-    tt->actual_name = string_alloc(tt->dco.ifname, NULL);
 
     /* see "Interface Flags" in ifnet(9) */
     int i = IFF_POINTOPOINT | IFF_MULTICAST;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 293031de6..45b1c8b0d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3876,6 +3876,8 @@ do_close_tls(struct context *c)
         md_ctx_cleanup(c->c2.pulled_options_state);
         md_ctx_free(c->c2.pulled_options_state);
     }
+
+    tls_auth_standalone_free(c->c2.tls_auth_standalone);
 }
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index f4aca484f..04205329a 100644
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
index bdcee769b..4ed4cfaa4 100644
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


