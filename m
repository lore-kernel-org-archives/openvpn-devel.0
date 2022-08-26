From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 26 Aug 2022 10:54:24 +0200
Message-Id: <20220826085427.25302-4-frank@...2641...>
In-Reply-To: <20220826085427.25302-1-frank@...2641...>
References: <20220826085427.25302-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/6] uncrustify: add space around "additive"
 operators
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

Only '+' and '-' since sp_arith=add would be very
intrusive.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 dev-tools/uncrustify.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
index 25d85ecd..3c721396 100644
--- a/dev-tools/uncrustify.conf
+++ b/dev-tools/uncrustify.conf
@@ -35,7 +35,7 @@ sp_cond_colon=add
 sp_cond_question=add
 sp_bool=add
 sp_arith=ignore
-sp_arith_additive=ignore
+sp_arith_additive=add
 sp_compare=add
 sp_else_brace=add
 sp_brace_else=add
-- 
2.34.1


