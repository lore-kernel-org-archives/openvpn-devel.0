From: Jan Just Keijser <janjust@...1147...>
Date: Fri, 28 Oct 2016 12:27:49 +0200
Message-Id: <1477650469-32431-1-git-send-email-janjust@...1147...>
Subject: [Openvpn-devel] [PATCH] Allow "setenv opt" to be pushed from server
	to client
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

---
 src/openvpn/options.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 281ef0b..dbb926d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5616,7 +5616,14 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "setenv") && p[1] && !p[3])
     {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (streq (p[1], "opt"))
+	{
+          VERIFY_PERMISSION (OPT_P_SETENV);
+	}
+      else
+	{
+          VERIFY_PERMISSION (OPT_P_GENERAL);
+	}
       if (streq (p[1], "REMOTE_RANDOM_HOSTNAME") && !p[2])
 	{
 	  options->sockflags |= SF_HOST_RANDOMIZE;
-- 
1.9.3


