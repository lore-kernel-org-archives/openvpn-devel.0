From: Gert Doering <gert@...1296...>
Date: Fri, 19 Apr 2013 19:41:04 +0200
Message-Id: <1366393268-27392-2-git-send-email-gert@...1296...>
In-Reply-To: <1366393268-27392-1-git-send-email-gert@...1296...>
References: <1366393268-27392-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 1/5] Added remote-override option.
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

From: James Yonan <james@...515...>

OpenVPN SVN r8126 (2.1.20)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 7 ++++++-
 src/openvpn/options.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ec39212..88ed88a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4410,6 +4410,11 @@ add_option (struct options *options,
       options->force_connection_list = true;
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
@@ -4417,7 +4422,7 @@ add_option (struct options *options,
       re.remote_port = re.proto = -1;
 
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      re.remote = p[1];
+      re.remote = options->remote_override ? options->remote_override : p[1];
       if (p[2])
 	{
 	  const int port = atoi (p[2]);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d2ad94c..db1d3f7 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -215,6 +215,8 @@ struct options
 
   struct remote_host_store *rh_store;
 
+  const char *remote_override;
+
   bool remote_random;
   const char *ipchange;
   const char *dev;
-- 
1.8.1.5


