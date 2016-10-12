From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 Oct 2016 12:47:07 +0200
Message-Id: <1476269227-13290-1-git-send-email-arne@...1227...>
In-Reply-To: <CAKuzo_h+1YqaAYSXtUXiNvcewg74aBS+rTwHBU_QXhVFvZW0Vg@...278...>
References: <CAKuzo_h+1YqaAYSXtUXiNvcewg74aBS+rTwHBU_QXhVFvZW0Vg@...278...>
Subject: [Openvpn-devel] [PATCH v2] Change the hold command to communicate
	the time that OpenVPN would wait to the UI.
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

Before the connect-retry change to do exponential backup this was not necessary
since the time was fixed. With the exponential backoff the UI needs either to
implement its own exponential backoff mechansim or needs a way of knowing the
value of OpenVPN internal mechansim.

Patch V2: Fixed typos noticed by Selva(
---
 doc/management-notes.txt |  7 +++++--
 src/openvpn/init.c       | 15 +++++++++------
 src/openvpn/manage.c     |  8 ++++++--
 src/openvpn/manage.h     |  2 +-
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index f68f3db..dd870eb 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -168,9 +168,12 @@ be reset by restarts.
 
 OpenVPN will indicate that it is in a hold state by
 sending a real-time notification to the management
-client:
+client, the parameter indicates how long OpenVPN would
+wait without UI (as influenced by connect-retry exponential
+backoff). The UI needs to wait for releasing the hold if it
+wants similar behavior:
 
-  >HOLD:Waiting for hold release
+  >HOLD:Waiting for hold release:10
 
 Command examples:
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 7684a96..73f8c6d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1954,16 +1954,17 @@ do_deferred_options (struct context *c, const unsigned int found)
 }
 
 /*
- * Possible hold on initialization
+ * Possible hold on initialization, holdtime is the
+ * time OpenVPN would wait without management
  */
 static bool
-do_hold (void)
+do_hold (int holdtime)
 {
 #ifdef ENABLE_MANAGEMENT
   if (management)
     {
       /* block until management hold is released */
-      if (management_hold (management))
+        if (management_hold (management, holdtime))
 	return true;
     }
 #endif
@@ -2021,8 +2022,10 @@ socket_restart_pause (struct context *c)
   c->persist.restart_sleep_seconds = 0;
 
   /* do managment hold on context restart, i.e. second, third, fourth, etc. initialization */
-  if (do_hold ())
+  if (do_hold (sec))
+  {
     sec = 0;
+  }
 
   if (sec)
     {
@@ -2040,7 +2043,7 @@ do_startup_pause (struct context *c)
   if (!c->first_time)
     socket_restart_pause (c);
   else
-    do_hold (); /* do management hold on first context initialization */
+    do_hold (0); /* do management hold on first context initialization */
 }
 
 /*
@@ -3425,7 +3428,7 @@ open_management (struct context *c)
 	    }
 
 	  /* initial management hold, called early, before first context initialization */
-	  do_hold ();
+	  do_hold (0);
 	  if (IS_SIG (c))
 	    {
 	      msg (M_WARN, "Signal received from management interface, exiting");
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index dcb1bc1..206aaf4 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3332,12 +3332,13 @@ management_should_daemonize (struct management *man)
  * Return true if the caller should not sleep for an additional time interval.
  */
 bool
-management_hold (struct management *man)
+management_hold (struct management *man, int holdtime)
 {
   if (management_would_hold (man))
     {
       volatile int signal_received = 0;
       const bool standalone_disabled_save = man->persist.standalone_disabled;
+      struct gc_arena gc = gc_new ();
 
       man->persist.standalone_disabled = false; /* This is so M_CLIENT messages will be correctly passed through msg() */
       man->persist.special_state_msg = NULL;
@@ -3347,7 +3348,9 @@ management_hold (struct management *man)
 
       if (!signal_received)
 	{
-	  man->persist.special_state_msg = ">HOLD:Waiting for hold release";
+      struct buffer out = alloc_buf_gc (128, &gc);
+      buf_printf (&out, ">HOLD:Waiting for hold release:%d", holdtime);
+	  man->persist.special_state_msg = BSTR (&out);
 	  msg (M_CLIENT, "%s", man->persist.special_state_msg);
 
 	  /* run command processing event loop until we get our username/password */
@@ -3366,6 +3369,7 @@ management_hold (struct management *man)
       man->persist.special_state_msg = NULL;
       man->settings.mansig &= ~MANSIG_IGNORE_USR1_HUP;
 
+      gc_free (&gc);
       return true;
     }
   return false;
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 988600f..50db38c 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -396,7 +396,7 @@ int managment_android_persisttun_action (struct management *man);
 
 bool management_should_daemonize (struct management *man);
 bool management_would_hold (struct management *man);
-bool management_hold (struct management *man);
+bool management_hold (struct management *man, int holdtime);
 
 void management_event_loop_n_seconds (struct management *man, int sec);
 
-- 
2.8.4 (Apple Git-73)


