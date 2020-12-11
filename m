From: Arne Schwabe <arne@...1227...>
Date: Fri, 11 Dec 2020 13:59:57 +0100
Message-Id: <20201211125957.7764-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix tls-auth mismatch OCC message when
 tls-cryptv2 is used.
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

A server with tls-cryptv2 and tls-auth produces the warning:

  WARNING: 'tls-auth' is present in local config but missing in remote config, local='tls-auth'"

The tls-auth option has no argument so the strpefix with the space
included does not match it.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d824cbad..d9d492b2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4138,7 +4138,7 @@ options_warning_safe_scan2(const int msglevel,
     if (strprefix(p1, "key-method ")
         || strprefix(p1, "keydir ")
         || strprefix(p1, "proto ")
-        || strprefix(p1, "tls-auth ")
+        || streq(p1, "tls-auth")
         || strprefix(p1, "tun-ipv6")
         || strprefix(p1, "cipher "))
     {
-- 
2.26.2


