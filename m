From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 18 Aug 2022 22:15:05 +0200
Message-Id: <20220818201505.656149-2-frank@...2641...>
In-Reply-To: <20220818201505.656149-1-frank@...2641...>
References: <20220818201505.656149-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] uncrustify: remove newlines after
 return type of function prototype
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
index 325f3108..c73fba0c 100644
--- a/dev-tools/uncrustify.conf
+++ b/dev-tools/uncrustify.conf
@@ -40,6 +40,7 @@ sp_after_comma=add
 pos_arith=Lead
 pos_bool=Lead
 nl_func_type_name=add
+nl_func_proto_type_name=remove
 nl_before_case=true
 nl_assign_leave_one_liners=true
 nl_enum_leave_one_liners=true
-- 
2.34.1


