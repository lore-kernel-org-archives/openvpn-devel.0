From: Kristof Provost <kprovost@...2661...>
Date: Fri, 11 Nov 2022 11:20:31 +0100
Message-Id: <20221111102031.8402-2-kprovost@...2661...>
In-Reply-To: <20221111102031.8402-1-kprovost@...2661...>
References: <20221111102031.8402-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] FreeBSD DCO: support AES-192-GCM
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

As of 2c58d0cb3bb3e3a5b714ffac940500efbe5303ca FreeBSD also allows
AES-192-GCM in DCO. Announce this support.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/dco_freebsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index c8361028..8e5ee436 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -667,7 +667,7 @@ dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 const char *
 dco_get_supported_ciphers()
 {
-    return "none:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+    return "none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY1305";
 }
 
 #endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
-- 
2.38.1


