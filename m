From: bertrandbc@...277...
Date: Tue,  2 Jan 2018 15:09:38 +0100
Message-Id: <20180102140938.16467-1-bertrandbc@...277...>
Subject: [Openvpn-devel] [PATCH] Fix typo in error message: "optione" ->
 "option"
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

From: Bertrand Bonnefoy-Claudet <bertrandbc@...277...>

---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7be5f383..b240e2ef 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4523,7 +4523,7 @@ read_config_file(struct options *options,
                 ++line_num;
                 if (strlen(line) == OPTION_LINE_SIZE)
                 {
-                    msg(msglevel, "In %s:%d: Maximum optione line length (%d) exceeded, line starts with %s",
+                    msg(msglevel, "In %s:%d: Maximum option line length (%d) exceeded, line starts with %s",
                         file, line_num, OPTION_LINE_SIZE, line);
                 }
 
-- 
2.15.1


