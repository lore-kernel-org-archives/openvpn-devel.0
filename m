From: Steffan Karger <steffan@...1856...>
Date: Mon, 25 Jul 2016 20:52:46 +0200
Message-Id: <1469472766-25131-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Allow ncp-disable and ncp-ciphers to be
	specified in ccd files
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

This allows the ncp-disable and ncp-ciphers options to be used in 'client
config dir' files, to disable or change the negotiable crypto parameter
settings for specific clients.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 18af179..79dcb79 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6666,12 +6666,12 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "ncp-ciphers") && p[1] && !p[2])
     {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
+      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_INSTANCE);
       options->ncp_ciphers = p[1];
     }
   else if (streq (p[0], "ncp-disable") && !p[1])
     {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
+      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_INSTANCE);
       options->ncp_enabled = false;
     }
   else if (streq (p[0], "prng") && p[1] && !p[3])
-- 
2.7.4


