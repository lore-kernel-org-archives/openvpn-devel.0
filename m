From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 18 Dec 2020 00:48:34 +0200
Message-Id: <20201217224834.160-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] ssl_common.h: fix "not all control paths
 return a value" msvc warning
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Commit cc5a71637 ("Replace key_scan array of static pointers with inline function")
has introduced get_key_scan() routine with switch statement which calls ASSERT
in certain case. Even though "this should never happen", this code triggers Level 1
warning "not all control paths return a value" in msvc.

Fix by adding "return NULL; /* NOTREACHED */"" after ASSERT.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/ssl_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f435089a..a826e37f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -596,6 +596,7 @@ get_key_scan(struct tls_multi *multi, int index)
             return &multi->session[TM_LAME_DUCK].key[KS_LAME_DUCK];
         default:
             ASSERT(false);
+            return NULL; /* NOTREACHED */
     }
 }
 
-- 
2.17.1


