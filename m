From: Arne Schwabe <arne@...1227...>
Date: Sun, 14 Nov 2021 14:03:11 +0100
Message-Id: <20211114130311.4043536-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Move IV_TCPNL from
 comp_generate_peer_info_string to push_peer_info
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

This IV variable has nothing to do with compression and should not
depend if OpenVPN is compiled with USE_COMP. So move it to the
other generic IV variables.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/comp.c | 1 -
 src/openvpn/ssl.c  | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 72b1511ea..ad49b00b9 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -169,7 +169,6 @@ comp_generate_peer_info_string(const struct compress_options *opt, struct buffer
         }
         buf_printf(out, "IV_COMP_STUB=1\n");
         buf_printf(out, "IV_COMP_STUBv2=1\n");
-        buf_printf(out, "IV_TCPNL=1\n");
     }
 }
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7a09272c8..4d107016a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2184,6 +2184,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 #elif defined(_WIN32)
         buf_printf(&out, "IV_PLAT=win\n");
 #endif
+        /* Announce that we do not require strict sequence numbers with
+         * TCP. (TCP non-linear) */
+        buf_printf(&out, "IV_TCPNL=1\n");
     }
 
     /* These are the IV variable that are sent to peers in p2p mode */
-- 
2.33.0


