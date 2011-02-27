Message-ID: <4D6ABF00.8070309@...1449...>
Date: Sun, 27 Feb 2011 22:15:44 +0100
From: Stefan Hellermann <stefan@...1449...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] plugin.h: update prototype of plugin_call
 dummy in !ENABLE_PLUGIN case
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

plugin.h: update prototype of plugin_call dummy in !ENABLE_PLUGIN case

Commit 2db5a0ac3e053857d97e468de53e70a605f54561 adds two arguments to
plugin_call(...), but missed the !ENABLE_PLUGIN case. With
!ENABLE_PLUGIN, plugin_call(...) is only a dummy, so add these two
parameters there too.

---
 plugin.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

This is my first patch with git, is everything correct? This patch is
against the allmerged branch.

Regards,
Stefan


diff --git a/plugin.h b/plugin.h
index 846973f..9d48651 100644
--- a/plugin.h
+++ b/plugin.h
@@ -174,7 +174,9 @@ plugin_call (const struct plugin_list *pl,
 	     const int type,
 	     const struct argv *av,
 	     struct plugin_return *pr,
-	     struct env_set *es)
+	     struct env_set *es,
+	     int current_cert_depth,
+	     X509 *current_cert);
 {
   return 0;
 }
-- 
1.7.4


