From: selva.nair@...277...
Date: Mon,  5 Mar 2018 10:28:00 -0500
Message-Id: <1520263680-1260-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Management: warn about password only when
 the option is in use
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

From: Selva Nair <selva.nair@...277...>

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f7995c6..c5bce9f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2171,7 +2171,8 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "--management-client-(user|group) can only be used on unix domain sockets");
     }
 
-    if (!(options->management_flags & MF_UNIX_SOCK)
+    if (options->management_addr
+        && !(options->management_flags & MF_UNIX_SOCK)
         && (!options->management_user_pass))
     {
         msg(M_WARN, "WARNING: Using --management on a TCP port WITHOUT "
-- 
2.1.4


