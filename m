From: Arne Schwabe <arne@...1227...>
Date: Wed,  4 Dec 2019 12:09:38 +0100
Message-Id: <20191204110938.6725-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Document tls-ciphersuites also in --help
 output
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
 src/openvpn/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index aec4e01c..e41d3486 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -606,7 +606,8 @@ static const char usage_message[] =
     "                  Windows Certificate System Store.\n"
 #endif
     "--tls-cipher l  : A list l of allowable TLS ciphers separated by : (optional).\n"
-    "                : Use --show-tls to see a list of supported TLS ciphers.\n"
+    "--tls-ciphersuites l: A list of allowed TLS 1.3 cipher suites seperated by : (optional)\n"
+    "                : Use --show-tls to see a list of supported TLS ciphers (suites).\n"
     "--tls-cert-profile p : Set the allowed certificate crypto algorithm profile\n"
     "                  (default=legacy).\n"
     "--tls-timeout n : Packet retransmit timeout on TLS control channel\n"
-- 
2.24.0


