From: Steffan Karger <steffan@...1856...>
Date: Fri, 23 Dec 2016 21:26:31 +0100
Message-Id: <1482524791-5788-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add nl_for_brace=add to uncrustify.conf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

We want { and } aligned, which means also adding a newline between each
for() and {.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 dev-tools/uncrustify.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
index 95e0b2a..3745ed0 100644
--- a/dev-tools/uncrustify.conf
+++ b/dev-tools/uncrustify.conf
@@ -9,6 +9,7 @@ nl_brace_else=add
 nl_elseif_brace=add
 nl_else_brace=add
 nl_else_if=remove
+nl_for_brace=add
 sp_func_proto_paren=Remove
 sp_func_def_paren=Remove
 sp_func_call_paren=Remove
-- 
2.7.4


