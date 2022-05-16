From: Kristof Provost <kprovost@...2661...>
Date: Mon, 16 May 2022 20:56:21 +0200
Message-Id: <20220516185621.6182-5-kprovost@...2661...>
In-Reply-To: <20220516185621.6182-1-kprovost@...2661...>
References: <20220516185621.6182-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] Set (DCO) timeouts as well for p2p mode
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/init.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0d991ba4..701749cd 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2232,6 +2232,21 @@ do_deferred_p2p_ncp(struct context *c)
         msg(D_TLS_ERRORS, "ERROR: failed to set crypto cipher");
         return false;
     }
+
+    if (dco_enabled(&c->options) && (c->options.ping_send_timeout || c->c2.frame.mss_fix))
+    {
+        int ret = dco_set_peer(&c->c1.tuntap->dco,
+                c->c2.tls_multi->peer_id,
+                c->options.ping_send_timeout,
+                c->options.ping_rec_timeout,
+                c->c2.frame.mss_fix);
+        if (ret < 0)
+        {
+            msg(D_DCO, "Cannot set DCO peer: %s", strerror(-ret));
+            return false;
+        }
+    }
+
     return true;
 }
 
-- 
2.36.1


