Message-ID: <68c5481e04092204386eee69af@...278...>
From: Kisero <kisero@...277...>
Reply-To: Kisero <kisero@...277...>
Mime-Version: 1.0
Subject: [Openvpn-devel] patch for error.c/error.h syslog facility
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Sep 22 04:39:09 2004
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

its a shitty patch as i am a shitty programmer :)
just define wich facility you want on SYSLOG_FACILITY in error.h

obviusly, if you dont tough nothing will work as ussual...ill try
patching to see the remote ip address upon
disconnection.....somewho..sometime :)

lmnukssl:/usr/local/src/openvpn-2.0_beta11# cat patch_syslog.diff 
--- error.c.ori Wed Sep 22 12:28:39 2004
+++ error.c     Wed Sep 22 12:26:22 2004
@@ -240,11 +240,22 @@
 
   if (use_syslog && !std_redir)
     {
+
 #if SYSLOG_CAPABILITY
-      syslog (level, "%s%s%s",
+
+      # if SYSLOG_FACILITY
+      syslog (SYSLOG_FACILITY, "%s%s%s",
              prefix,
              prefix_sep,
              m1);
+      #else
+      syslog (SYSLOG_FACILITY, "%s%s%s",
+             prefix,
+             prefix_sep,
+             m1);
+      
+      #endif
+
 #endif
     }
   else


--- error.h.ori Wed Sep 22 12:28:52 2004
+++ error.h     Wed Sep 22 12:26:21 2004
@@ -43,6 +43,12 @@
  * Exit status codes
  */
 
+
+/*
+ * patch for loging in the facility i want or choose
+ */
+#define SYSLOG_FACILITY                            LOG_LOCAL2
+
 #define OPENVPN_EXIT_STATUS_GOOD                    0
 #define OPENVPN_EXIT_STATUS_ERROR                   1
 #define OPENVPN_EXIT_STATUS_USAGE                   1

