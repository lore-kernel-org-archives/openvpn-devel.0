From: Maximilian Wilhelm <max@...1047...>
Date: Mon,  3 Sep 2007 01:13:57 +0200
Message-Id: <1188774843936-git-send-email-max@...1047...>
In-Reply-To: <11887748431930-git-send-email-max@...1047...>
References: <11887748431930-git-send-email-max@...1047...>
Subject: [Openvpn-devel] [PATCH] Added the ability to configure wtmp logging:
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

  --log-wtmp server_id [file] : Enable logging to wtmp file using the two digit
                    server_id a prefix for the utmp line. Optionally you can write
                    to an own wtmp file. (Default is /var/log/ovpnwtmp.
---
 options.c |   31 +++++++++++++++++++++++++++++++
 options.h |    6 ++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/options.c b/options.c
index 46aad6d..a8c0073 100644
--- a/options.c
+++ b/options.c
@@ -266,6 +266,11 @@ static const char usage_message[] =
   "--suppress-timestamps : Don't log timestamps to stdout/stderr.\n"
   "--writepid file : Write main process ID to file.\n"
   "--nice n        : Change process priority (>0 = lower, <0 = higher).\n"
+#ifdef ENABLE_WTMP
+  "--log-wtmp server_id [file] : Enable logging to wtmp file using the two digit\n"
+  "                  server_id a prefix for the utmp line. Optionally you can write\n"
+  "                  to an own wtmp file. (Default is /var/log/ovpnwtmp.\n"
+#endif
 #if 0
 #ifdef USE_PTHREAD
   "--nice-work n   : Change thread priority of work thread.  The work\n"
@@ -697,6 +702,12 @@ init_options (struct options *o)
 #ifdef ENABLE_PKCS11
   o->pkcs11_pin_cache_period = -1;
 #endif			/* ENABLE_PKCS11 */
+
+#ifdef ENABLE_WTMP
+  o->log_wtmp = 0;
+  o->wtmp_server_id = 1;
+  o->wtmp_file = "/var/log/ovpnwtmp";
+#endif
 }
 
 void
@@ -3473,6 +3484,25 @@ add_option (struct options *options,
       options->log = true;
       redirect_stdout_stderr (p[1], false);
     }
+
+#ifdef ENABLE_WTMP
+  else if (streq (p[0], "log-wtmp") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+
+      /* Activate WTMP logging */
+      options->log_wtmp = 1;
+
+      /* Use server_id if set */
+      if (p[1])
+        options->wtmp_server_id = atoi (p[1]);
+
+      /* User specified wtmp file if set */
+      if (p[2])
+        options->wtmp_file = p[2];
+      }
+#endif
+
   else if (streq (p[0], "suppress-timestamps"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -3773,6 +3803,7 @@ add_option (struct options *options,
       openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
 #endif /* GENERAL_PROXY_SUPPORT */
+
 #ifdef ENABLE_HTTP_PROXY
   else if (streq (p[0], "http-proxy") && p[1])
     {
diff --git a/options.h b/options.h
index 21d131e..e7a49b9 100644
--- a/options.h
+++ b/options.h
@@ -214,6 +214,12 @@ struct options
   /* inetd modes defined in socket.h */
   int inetd;
 
+#ifdef ENABLE_WTMP
+  int log_wtmp;
+  int wtmp_server_id;
+  char *wtmp_file;
+#endif
+
   bool log;
   bool suppress_timestamps;
   int nice;
-- 
1.5.2.4


