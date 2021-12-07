From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:01:56 +0100
Message-Id: <20211207170211.3275837-7-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 06/21] Remove post_open_mtu code
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

This code is probably from a time when we could not set the MTU on
the Windows tap6 driver. Nowadays we can set the MTU on this device,
so this code is a noop now.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 10 ----------
 src/openvpn/ssl.c  |  2 +-
 src/openvpn/tun.c  |  1 -
 src/openvpn/tun.h  |  4 ----
 4 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0009bcb72..85d664ad6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1809,16 +1809,6 @@ do_open_tun(struct context *c)
                  c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
     }
 
-    /*
-     * Did tun/tap driver give us an MTU?
-     */
-    if (c->c1.tuntap->post_open_mtu)
-    {
-        frame_set_mtu_dynamic(&c->c2.frame,
-                              c->c1.tuntap->post_open_mtu,
-                              SET_MTU_TUN | SET_MTU_UPPER_BOUND);
-    }
-
     ret = true;
     static_context = c;
 #ifndef TARGET_ANDROID
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8cbb129d2..303e3fe8f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1897,7 +1897,7 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
     frame_print(frame, D_MTU_INFO, "Data Channel MTU parms");
 
     /*
-     * mssfix uses data channel framing, which at this point contains
+     * mssfix uses data channel framing, which at this poipnt contains
      * actual overhead. Fragmentation logic uses frame_fragment, which
      * still contains worst case overhead. Replace it with actual overhead
      * to prevent unneeded fragmentation.
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 75d5eaf7b..12bdd2005 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6071,7 +6071,6 @@ tuntap_get_mtu(struct tuntap *tt)
                         &mtu, sizeof(mtu),
                         &mtu, sizeof(mtu), &len, NULL))
     {
-        tt->post_open_mtu = (int)mtu;
         msg(D_MTU_INFO, "TAP-Windows MTU=%d", (int)mtu);
     }
 }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index aa1e47b5a..d4657537c 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -214,10 +214,6 @@ struct tuntap
 #endif
     /* used for printing status info only */
     unsigned int rwflags_debug;
-
-    /* Some TUN/TAP drivers like to be ioctled for mtu
-     * after open */
-    int post_open_mtu;
 };
 
 static inline bool
-- 
2.33.0


