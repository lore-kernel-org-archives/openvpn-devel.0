From: Arne Schwabe <arne@...1227...>
Date: Sat,  2 Feb 2013 15:36:37 +0100
Message-Id: <1359815797-23262-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix assertion if environment es is null
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

The construct_name_value eventually call gc_malloc with NULL as gc which will trigger an assertion
---
 src/openvpn/misc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index fcc8552..1e9a7fc 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -804,7 +804,7 @@ setenv_str_ex (struct env_set *es,
     }
   else
     {
-      char *str = construct_name_value (name_tmp, val_tmp, NULL);
+      char *str = construct_name_value (name_tmp, val_tmp, &gc);
       if (platform_putenv(str))
       {
         msg (M_WARN | M_ERRNO, "putenv('%s') failed", str);
-- 
1.7.9.5


