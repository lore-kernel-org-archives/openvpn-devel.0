From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:37 +0100
Message-Id: <1395407925-25518-5-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 04/12] Implement an easy parsable log output
	that allows access to flags of the log message
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

---
 doc/openvpn.8         |  6 ++++++
 src/openvpn/error.c   | 28 +++++++++++++++++++++++++++-
 src/openvpn/error.h   |  2 ++
 src/openvpn/options.c |  8 ++++++++
 src/openvpn/options.h |  1 +
 5 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d01c935..3a58317 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2283,6 +2283,12 @@ otherwise would be prepended. In particular, this applies to
 log messages sent to stdout.
 .\"*********************************************************
 .TP
+.B \-\-machine-readable-output
+Always write timestamps and message flags to log messages, even when they
+otherwise would not be prefixed. In particular, this applies to
+log messages sent to stdout.
+.\"*********************************************************
+.TP
 .B \-\-writepid file
 Write OpenVPN's main process ID to
 .B file.
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index ebe9a52..fd9f19d 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -82,6 +82,10 @@ static bool std_redir;      /* GLOBAL */
 /* Should messages be written to the syslog? */
 static bool use_syslog;     /* GLOBAL */
 
+/* Should stdout/stderr be be parsable and always be prefixed with time
+ * and message flags */
+static bool machine_readable_output;   /* GLOBAL */
+
 /* Should timestamps be included on messages to stdout/stderr? */
 static bool suppress_timestamps; /* GLOBAL */
 
@@ -155,10 +159,17 @@ set_suppress_timestamps (bool suppressed)
 }
 
 void
+set_machine_readable_output (bool parsable)
+{
+  machine_readable_output = parsable;
+}
+
+void
 error_reset ()
 {
   use_syslog = std_redir = false;
   suppress_timestamps = false;
+  machine_readable_output = false;
   x_debug_level = 1;
   mute_cutoff = 0;
   mute_count = 0;
@@ -330,7 +341,22 @@ void x_msg_va (const unsigned int flags, const char *format, va_list arglist)
 	  FILE *fp = msg_fp(flags);
 	  const bool show_usec = check_debug_level (DEBUG_LEVEL_USEC_TIME);
 
-	  if ((flags & M_NOPREFIX) || suppress_timestamps)
+	  if (machine_readable_output)
+	    {
+	      struct timeval tv;
+	      gettimeofday (&tv, NULL);
+
+	      fprintf (fp, "%lu.%06lu %x %s%s%s%s",
+		       tv.tv_sec,
+		       tv.tv_usec,
+		       flags,
+		       prefix,
+		       prefix_sep,
+		       m1,
+		       "\n");
+
+	    }
+	  else if ((flags & M_NOPREFIX) || suppress_timestamps)
 	    {
 	      fprintf (fp, "%s%s%s%s",
 		       prefix,
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 27c48b6..1e1f2ac 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -194,6 +194,8 @@ void error_reset (void);
 void errors_to_stderr (void);
 
 void set_suppress_timestamps (bool suppressed);
+void set_machine_readable_output (bool parsable);
+
 
 #define SDL_CONSTRAIN (1<<0)
 bool set_debug_level (const int level, const unsigned int flags);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c4d9e51..e7259f7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -343,6 +343,7 @@ static const char usage_message[] =
   "--log file      : Output log to file which is created/truncated on open.\n"
   "--log-append file : Append log to file, or create file if nonexistent.\n"
   "--suppress-timestamps : Don't log timestamps to stdout/stderr.\n"
+  "--machine-readable-output : Always log timestamp, message flags to stdout/stderr.\n"
   "--writepid file : Write main process ID to file.\n"
   "--nice n        : Change process priority (>0 = lower, <0 = higher).\n"
   "--echo [parms ...] : Echo parameters to log output.\n"
@@ -1511,6 +1512,7 @@ show_settings (const struct options *o)
   SHOW_INT (inetd);
   SHOW_BOOL (log);
   SHOW_BOOL (suppress_timestamps);
+  SHOW_BOOL (machine_readable_output);
   SHOW_INT (nice);
   SHOW_INT (verbosity);
   SHOW_INT (mute);
@@ -4722,6 +4724,12 @@ add_option (struct options *options,
       options->suppress_timestamps = true;
       set_suppress_timestamps(true);
     }
+  else if (streq (p[0], "machine-readable-output"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->machine_readable_output = true;
+      set_machine_readable_output(true);
+    }
   else if (streq (p[0], "log-append") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 27bbc14..175918e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -305,6 +305,7 @@ struct options
 
   bool log;
   bool suppress_timestamps;
+  bool machine_readable_output;
   int nice;
   int verbosity;
   int mute;
-- 
1.8.5.2 (Apple Git-48)


