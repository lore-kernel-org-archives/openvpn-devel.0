From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:36 +0100
Message-Id: <1395407925-25518-4-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 03/12] Workaround broken Android 4.4
	VpnService API for persist-tun mode
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

In Android 4.4 it is not possible to open a new tun device and then close the
old tun device without breaking the whole VPNService stack until the device
is reported. This management method ask the UI what method should be taken to
ensure the optimal solution for the situation.
---
 src/openvpn/init.c   | 19 +++++++++++--------
 src/openvpn/manage.c | 28 ++++++++++++++++++++++++++++
 src/openvpn/manage.h |  5 +++++
 src/openvpn/tun.c    | 29 ++++++++++++++++++++++++-----
 4 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c50b5c2..21e3052 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1426,10 +1426,10 @@ do_open_tun (struct context *c)
 
 #ifdef TARGET_ANDROID
       /* If we emulate persist-tun on android we still have to open a new tun and
-         then close the old */
+       * then close the old */
       int oldtunfd=-1;
       if (c->c1.tuntap)
-          oldtunfd = c->c1.tuntap->fd;
+	oldtunfd = c->c1.tuntap->fd;
 #endif
 
       /* initialize (but do not open) tun/tap object */
@@ -1463,14 +1463,14 @@ do_open_tun (struct context *c)
         do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
                   c->c1.tuntap, c->plugins, c->c2.es);
       }
-
+#ifdef TARGET_ANDROID
+	/* Store the old fd inside the fd so open_tun can use it */
+	c->c1.tuntap->fd = oldtunfd;
+#endif
       /* open the tun device */
       open_tun (c->options.dev, c->options.dev_type, c->options.dev_node,
 		c->c1.tuntap);
-#ifdef TARGET_ANDROID
-      if (oldtunfd>=0)
-        close(oldtunfd);
-#endif
+
       /* set the hardware address */
       if (c->options.lladdr)
 	  set_lladdr(c->c1.tuntap->actual_name, c->options.lladdr, c->c2.es);
@@ -3767,7 +3767,10 @@ close_context (struct context *c, int sig, unsigned int flags)
     {
       if ((flags & CC_USR1_TO_HUP)
 	  || (c->sig->source == SIG_SOURCE_HARD && (flags & CC_HARD_USR1_TO_HUP)))
-	c->sig->signal_received = SIGHUP;
+        {
+          c->sig->signal_received = SIGHUP;
+          c->sig->signal_text = "close_context usr1 to hup";
+        }
     }
 
   if (!(flags & CC_NO_CLOSE))
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 22dbe13..68ee37f 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1864,6 +1864,34 @@ bool management_android_control (struct management *man, const char *command, co
   management_query_user_pass(management, &up , command, GET_USER_PASS_NEED_OK,(void*) 0);
   return strcmp ("ok", up.password)==0;
 }
+
+/*
+ * In Android 4.4 it is not possible to open a new tun device and then close the
+ * old tun device without breaking the whole VPNService stack until the device
+ * is rebooted. This management method ask the UI what method should be taken to
+ * ensure the optimal solution for the situation
+ */
+int managment_android_persisttun_action (struct management *man)
+{
+  struct user_pass up;
+  CLEAR(up);
+  strcpy(up.username,"tunmethod");
+  management_query_user_pass(management, &up , "PERSIST_TUN_ACTION",
+			     GET_USER_PASS_NEED_OK,(void*) 0);
+  if (!strcmp("NOACTION", up.password))
+    return ANDROID_KEEP_OLD_TUN;
+  else if (!strcmp ("OPEN_AFTER_CLOSE", up.password))
+    return ANDROID_OPEN_AFTER_CLOSE;
+  else if (!strcmp ("OPEN_BEFORE_CLOSE", up.password))
+    return ANDROID_OPEN_BEFORE_CLOSE;
+  else
+    msg (M_ERR, "Got unrecognised '%s' from management for PERSIST_TUN_ACTION query", up.password);
+  
+  ASSERT(0);
+  return ANDROID_OPEN_AFTER_CLOSE;
+}
+
+
 #endif
 
 static int
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 962b5bc..1c8dda6 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -378,6 +378,11 @@ bool management_query_user_pass (struct management *man,
 
 #ifdef TARGET_ANDROID
 bool management_android_control (struct management *man, const char *command, const char *msg);
+
+#define ANDROID_KEEP_OLD_TUN 1
+#define ANDROID_OPEN_AFTER_CLOSE 2
+#define ANDROID_OPEN_BEFORE_CLOSE 3
+int managment_android_persisttun_action (struct management *man);
 #endif
 
 bool management_should_daemonize (struct management *man);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 672486e..4df271d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1501,19 +1501,38 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
   struct gc_arena gc = gc_new ();
   bool opentun;
 
+  int oldtunfd = tt->fd;
+
   for (i = 0; i < tt->options.dns_len; ++i) {
     management_android_control (management, "DNSSERVER",
-                                print_in_addr_t(tt->options.dns[i], 0, &gc));
+				print_in_addr_t(tt->options.dns[i], 0, &gc));
   }
 
   if(tt->options.domain)
     management_android_control (management, "DNSDOMAIN", tt->options.domain);
 
-  opentun = management_android_control (management, "OPENTUN", dev);
+  int android_method = managment_android_persisttun_action (management);
+
+  /* Android 4.4 workaround */
+  if (oldtunfd >=0 && android_method == ANDROID_OPEN_AFTER_CLOSE)
+    {
+      close(oldtunfd);
+      openvpn_sleep(2);
+    }
+
+  if (oldtunfd >=0  && android_method == ANDROID_KEEP_OLD_TUN) {
+    /* keep the old fd */
+    opentun = true;
+  } else {
+    opentun = management_android_control (management, "OPENTUN", dev);
+    /* Pick up the fd from management interface after calling the
+     * OPENTUN command */
+    tt->fd = management->connection.lastfdreceived;
+    management->connection.lastfdreceived=-1;
+  }
 
-  /* Pick up the fd from management interface after calling the OPENTUN command */
-  tt->fd = management->connection.lastfdreceived;
-  management->connection.lastfdreceived=-1;
+  if (oldtunfd>=0 && android_method == ANDROID_OPEN_BEFORE_CLOSE)
+    close(oldtunfd);
 
   /* Set the actual name to a dummy name */
   tt->actual_name = string_alloc (ANDROID_TUNNAME, NULL);
-- 
1.8.5.2 (Apple Git-48)


