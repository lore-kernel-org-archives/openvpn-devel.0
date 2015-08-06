From: Arne Schwabe <arne@...1227...>
Date: Thu,  6 Aug 2015 13:17:15 +0200
Message-Id: <1438859835-3977-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Show extra-certs in current parameters,
	fix clang warning and logic error in preresolve
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

Closes ticket #591
---
 src/openvpn/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 737d9a2..8a9d2d1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1582,6 +1582,7 @@ show_settings (const struct options *o)
   else
 #endif
   SHOW_STR (cert_file);
+  SHOW_STR (extra_certs_file);
 
 #ifdef MANAGMENT_EXTERNAL_KEY
   if((o->management_flags & MF_EXTERNAL_KEY))
@@ -4575,7 +4576,7 @@ add_option (struct options *options,
       else
 	options->resolve_retry_seconds = positive_atoi (p[1]);
     }
-  else if (streq (p[0], "preresolve") || streq (p[0], "ip-remote-hint") && !p[2])
+  else if ((streq (p[0], "preresolve") || streq (p[0], "ip-remote-hint")) && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->resolve_in_advance = true;
-- 
2.3.2 (Apple Git-55)


