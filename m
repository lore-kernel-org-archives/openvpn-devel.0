From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 17 Apr 2023 14:54:46 +0200
Message-Id: <20230417125446.27247-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] fix typo in help text:
 --ignore-unknown-option
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
Cc: Michael Nix <mchl.nix@...1030...>

From: Michael Nix <mchl.nix@...1030...>

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3914ab23..f5b09ab7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -248,7 +248,7 @@ static const char usage_message[] =
     "--setenv name value : Set a custom environmental variable to pass to script.\n"
     "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to allow\n"
     "                  directives for future OpenVPN versions to be ignored.\n"
-    "--ignore-unkown-option opt1 opt2 ...: Relax config file syntax. Allow\n"
+    "--ignore-unknown-option opt1 opt2 ...: Relax config file syntax. Allow\n"
     "                  these options to be ignored when unknown\n"
     "--script-security level: Where level can be:\n"
     "                  0 -- strictly no calling of external programs\n"
-- 
2.34.1


