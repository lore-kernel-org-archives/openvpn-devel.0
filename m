From: Antonio Quartulli <a@...2181...>
Date: Tue, 27 Jun 2017 20:00:47 +0800
Message-Id: <20170627120047.12304-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH trivial] crypto: correct typ0 in error
 message
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

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 191fee8e..9f2828a4 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1261,7 +1261,7 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
         fd = platform_open(file, O_RDONLY, 0);
         if (fd == -1)
         {
-            msg(M_ERR, "Cannot open file key file '%s'", file);
+            msg(M_ERR, "Cannot open key file '%s'", file);
         }
         size = read(fd, in.data, in.capacity);
         if (size < 0)
-- 
2.13.2


