From: Arne Schwabe <arne@...1227...>
Date: Tue,  8 Jun 2021 21:43:30 +0200
Message-Id: <20210608194330.1431202-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Silence warning about format string in
 check_ca_required
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

clang does not like if the format argument of printf like function
is not a string literal:

warning: format string is not a string literal (potentially insecure)

Use "%s" as string literal to silence the warning.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8978955c3..5ecb7b7db 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2077,7 +2077,7 @@ check_ca_required(const struct options *options)
         " or CA path (--capath)"
 #endif
         " and/or peer fingerprint verification (--peer-fingerprint)";
-    msg(M_USAGE, str);
+    msg(M_USAGE, "%s", str);
 }
 
 static void
-- 
2.32.0


