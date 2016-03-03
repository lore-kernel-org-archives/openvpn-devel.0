From: James Yonan <james@...515...>
Date: Thu,  3 Mar 2016 01:18:57 -0700
Message-Id: <1456993146-63968-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 01/10] Added "remote-override" config
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
 doc/openvpn.8         | 5 +++++
 src/openvpn/options.c | 8 +++++++-
 src/openvpn/options.h | 2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 628d877..249100d 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -281,6 +281,11 @@ DNS caching.  For example, "foo.bar.gov" would be modified to
 "<random-chars>.foo.bar.gov".
 .\"*********************************************************
 .TP
+.B \-\-remote-override [alt-remote]
+Replace the hostname in all remote directives with
+.B alt-remote.
+.\"*********************************************************
+.TP
 .B <connection>
 Define a client connection
 profile.  Client connection profiles are groups of OpenVPN options that
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 02def3a..0942a4d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -118,6 +118,7 @@ static const char usage_message[] =
   "--remote host [port] : Remote host name or ip address.\n"
   "--remote-random : If multiple --remote options specified, choose one randomly.\n"
   "--remote-random-hostname : Add a random string to remote DNS name.\n"
+  "--remote-override a : Replace the hostname in all remote directives with a.\n"
   "--mode m        : Major mode, m = 'p2p' (default, point-to-point) or 'server'.\n"
   "--proto p       : Use protocol p for communicating with peer.\n"
   "                  p = udp (default), tcp-server, or tcp-client\n"
@@ -4565,6 +4566,11 @@ add_option (struct options *options,
 	goto err;
     }
 #endif
+  else if (streq (p[0], "remote-override") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->remote_override = p[1];
+    }
   else if (streq (p[0], "remote") && p[1] && !p[4])
     {
       struct remote_entry re;
@@ -4573,7 +4579,7 @@ add_option (struct options *options,
       re.af=0;
 
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      re.remote = p[1];
+      re.remote = options->remote_override ? options->remote_override : p[1];
       if (p[2])
 	{
 	  re.remote_port = p[2];
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 23d3992..e281069 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -213,6 +213,8 @@ struct options
 
   struct remote_host_store *rh_store;
 
+  const char *remote_override;
+
   bool remote_random;
   const char *ipchange;
   const char *dev;
-- 
1.9.1


