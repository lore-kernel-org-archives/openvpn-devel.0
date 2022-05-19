From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 19 May 2022 10:54:28 +0200
Message-Id: <20220519085428.6783-3-frank@...2641...>
In-Reply-To: <20220519085428.6783-1-frank@...2641...>
References: <20220519085428.6783-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] uncrustify: add sp_after_comma=add
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

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 dev-tools/uncrustify.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
index 25eb4cdd..27db8dda 100644
--- a/dev-tools/uncrustify.conf
+++ b/dev-tools/uncrustify.conf
@@ -36,6 +36,7 @@ sp_cond_question=add
 sp_bool=add
 sp_else_brace=add
 sp_brace_else=add
+sp_after_comma=add
 pos_arith=Lead
 pos_bool=Lead
 nl_func_type_name=add
-- 
2.30.2


