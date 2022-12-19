From: selva.nair@...277...
Date: Mon, 19 Dec 2022 09:04:05 -0500
Message-Id: <20221219140405.1221341-1-selva.nair@...277...>
In-Reply-To: <20221218192203.1214943-1-selva.nair@...277...>
References: <20221218192203.1214943-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Do not include auth-token in pulled
 option digest
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

As change in auth-token is common on restart and does not
require tun-reopen, exclude it from the "pulled options digest"
calculation. Without this tun is always re-opened on SIGUSR1
if auth-token is in use which breaks persist-tun.

Fixes #200

v2: explcitly filter auth-token and auth-token-user

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/push.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ad2f3c65..e765d2a9 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -989,8 +989,10 @@ push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
     char line[OPTION_PARM_SIZE];
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
-        /* peer-id might change on restart and this should not trigger reopening tun */
-        if (strprefix(line, "peer-id "))
+        /* peer-id and auth-token might change on restart and this should not trigger reopening tun */
+        if (strprefix(line, "peer-id ")
+            || strprefix(line, "auth-token ")
+            || strprefix(line, "auth-token-user "))
         {
             continue;
         }
-- 
2.34.1


