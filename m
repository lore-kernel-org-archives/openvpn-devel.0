From: Maximilian Wilhelm <max@...1047...>
Date: Mon,  3 Sep 2007 01:14:01 +0200
Message-Id: <1188774843840-git-send-email-max@...1047...>
In-Reply-To: <11887748431930-git-send-email-max@...1047...>
References: <11887748431930-git-send-email-max@...1047...>
Subject: [Openvpn-devel] [PATCH] Push a pointer to the whole options struct
	to wtmp_init()
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

  This change introduces the ability to figure out as which user OpenVPN will
  run after dropping privileges. This is very usefull when creating the wtmp
  file, which by default is owned by root resulting in OpenVPN not being able
  to write to it.

  So now the owner and group can be changed to the names specified in the
  configuration.

Signed-off-by: Maximilian Wilhelm <max@...1047...>
---
 multi.c   |    2 +-
 options.c |    3 ++-
 wtmp.c    |   13 +++++++++----
 wtmp.h    |    2 +-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/multi.c b/multi.c
index 5d8c80e..1453399 100644
--- a/multi.c
+++ b/multi.c
@@ -2306,7 +2306,7 @@ tunnel_server (struct context *top)
 
 #ifdef ENABLE_WTMP
   if (top->options.log_wtmp == 1)
-    wtmp_init(top->options.wtmp_server_id, top->options.wtmp_file);
+    wtmp_init (&top->options);
 #endif
 
   switch (top->options.proto) {
diff --git a/options.c b/options.c
index a8c0073..ed269c6 100644
--- a/options.c
+++ b/options.c
@@ -3500,7 +3500,8 @@ add_option (struct options *options,
       /* User specified wtmp file if set */
       if (p[2])
         options->wtmp_file = p[2];
-      }
+
+    }
 #endif
 
   else if (streq (p[0], "suppress-timestamps"))
diff --git a/wtmp.c b/wtmp.c
index 39822df..3887220 100644
--- a/wtmp.c
+++ b/wtmp.c
@@ -32,28 +32,33 @@
 
 int wtmp_active = 0;
 
-#define HAVE_ENDUTENT 1
-
-#define OVPN_WTMP_DEBUG 1
+// #define OVPN_WTMP_DEBUG 1
 
 /*
  * Initialize wtmp subsystem
  */
 int
-wtmp_init (unsigned int server_id, const char *wtmp_file_path)
+wtmp_init (const struct options *vpn_options)
 {
 #ifdef OVPN_WTMP_DEBUG
 	fprintf (stderr, "%s() called.\n", __FUNCTION__);
 #endif
 
 	struct stat wtmp_stat;
+
+	char *wtmp_file_path;
+
 	char *wtmp_file_dirname;
 	char *wtmp_file_path_copy;
 
+	assert (options);
+
 	/* Only initialize once */
 	if (wtmp_active == 1)
 		return 1;
 
+	wtmp_file_path = vpn_options->wtmp_file;
+
 #ifdef OVPN_WTMP_DEBUG
 	fprintf (stderr, "wtmp_file_path = %s\n", wtmp_file_path);
 #endif
diff --git a/wtmp.h b/wtmp.h
index c43b472..7fd3927 100644
--- a/wtmp.h
+++ b/wtmp.h
@@ -10,7 +10,7 @@
 
 enum local_remote { LOCAL, REMOTE };
 
-int wtmp_init ();
+int wtmp_init (const struct options *vpn_options);
 
 void wtmp_start (const struct multi_instance *mi);
 void wtmp_stop (const struct multi_instance *mi);
-- 
1.5.2.4


