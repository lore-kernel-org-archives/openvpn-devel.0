From: James Yonan <james@...515...>
Date: Mon, 21 Apr 2014 01:10:01 -0600
Message-Id: <1398064204-26476-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 1/4] Added "remote-override" config
	directive.
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
Cc: James Yonan <james@...515...>

remote-override <alt-remote> -- replace the hostname in all remote
directives with alt-remote.

Merged from OpenVPN 2.1

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/options.c | 7 ++++++-
 src/openvpn/options.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4af2974..1739460 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4512,6 +4512,11 @@ add_option (struct options *options,
 	goto err;
     }
 #endif
+  else if (streq (p[0], "remote-override") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->remote_override = p[1];
+    }
   else if (streq (p[0], "remote") && p[1])
     {
       struct remote_entry re;
@@ -4520,7 +4525,7 @@ add_option (struct options *options,
       re.af=0;
 
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      re.remote = p[1];
+      re.remote = options->remote_override ? options->remote_override : p[1];
       if (p[2])
 	{
 	  re.remote_port = p[2];
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index ec1d091..1775c02 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -222,6 +222,8 @@ struct options
 
   struct remote_host_store *rh_store;
 
+  const char *remote_override;
+
   bool remote_random;
   const char *ipchange;
   const char *dev;
-- 
1.8.5.5


