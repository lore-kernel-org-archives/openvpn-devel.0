From: Antonio Quartulli <a@...2181...>
Date: Wed,  1 Jul 2020 16:05:17 +0200
Message-Id: <20200701140517.11176-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] multi.c: use mi->cc_config instead of
 config variable
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
Cc: Antonio Quartulli <a@...2181...>

Commit ("Remove parameter config from multi_client_connect_mda") has
removed the config variable in favour of mi->cc_config, however one
occurence was not changed.

Fix it now by properly using mi->cc_config.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/multi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 19261c37..0e9e0db3 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1729,7 +1729,7 @@ multi_client_connect_mda(struct multi_context *m,
     {
         struct buffer_entry *be;
 
-        for (be = config->head; be != NULL; be = be->next)
+        for (be = mi->cc_config->head; be != NULL; be = be->next)
         {
             const char *opt = BSTR(&be->buf);
             options_string_import(&mi->context.options,
-- 
2.27.0


