From: selva.nair@...277...
Date: Thu, 27 Oct 2022 12:06:19 -0400
Message-Id: <20221027160619.11894-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Do not copy auth_token username to itself
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

- Fixes a potential mis-behaviour (strncpy with
dest == src) introduced by commits ecad4839c (2.6)
and 3d792ae955 (2.5).
Reported by: Gert Doering <gert@...1296...>

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/ssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3106c738..24e8ba63 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2180,7 +2180,7 @@ key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_sessi
             goto error;
         }
         /* save username for auth-token which may get pushed later */
-        if (session->opt->pull)
+        if (session->opt->pull && up != &auth_token)
         {
             strncpynt(auth_token.username, up->username, USER_PASS_LEN);
         }
-- 
2.30.2


