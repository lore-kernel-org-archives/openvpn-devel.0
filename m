From: Charles Duffy <cduffy@...294...>
In-Reply-To: <Pine.LNX.4.58.0410141256541.5469@...269...>
References: <pan.2004.10.14.13.57.18.771723@...294...>
	 <Pine.LNX.4.58.0410141256541.5469@...269...>
Message-Id: <1097856411.3868.17.camel@...23...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_smtp.isgenesis.com-6332-1097856413-0001-2"
Subject: [Openvpn-devel] Re: [Openvpn-users] Feature request: Switch to disable timestamps
 in stdout
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
Date: Fri Oct 15 09:10:35 2004
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_smtp.isgenesis.com-6332-1097856413-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

On Thu, 2004-10-14 at 12:59 -0600, James Yonan wrote:
> On Thu, 14 Oct 2004, Charles Duffy wrote:
> > I'm using OpenVPN under a process supervision framework that (optionally)
> > adds its own timestamps in the form YYYY-MM-DD_HH:MM:SS.xxxxx to the
> > beginning of each line's output when sending said output to a logfile. I'm
> > using this for all my other services, and would like to do it for OpenVPN
> > too (so I can use cat and sort to see combined logs from any arbitrary set
> > of services). However, when doing so, I get both OpenVPN's own timestamps
> > and the framework's timestamps next to each other -- somewhat less than
> > ideal. I don't see anything in the OpenVPN man page describing a way to
> > disable these timestamps. Such an option would be useful, though.
> > 
> > James, would you object to adding such an option? If you like, I'd be glad
> > to try my hand at creating a patch for it, with semantics of your choice.
> 
> I don't have any problem with this -- in fact the timestamp is already 
> removed for output to the system logger, so you can see how this is 
> currently done.

A proposed patch is attached.

--=_smtp.isgenesis.com-6332-1097856413-0001-2
Content-Type: text/x-patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: 
Content-Disposition: inline; filename=openvpn-log-suppression.patch

diff -ru3 openvpn-2.0_beta11/error.c openvpn-2.0_beta11+suppression/error.c
--- openvpn-2.0_beta11/error.c	2004-08-15 07:28:35.000000000 -0500
+++ openvpn-2.0_beta11+suppression/error.c	2004-10-15 10:50:43.000000000 -0500
@@ -72,6 +72,9 @@
 /* Should messages be written to the syslog? */
 static bool use_syslog;     /* GLOBAL */
 
+/* Should timestamps be included on messages to stdout/stderr? */
+static bool suppress_timestamps; /* GLOBAL */
+
 /* The program name passed to syslog */
 static char *pgmname_syslog;  /* GLOBAL */
 
@@ -91,9 +94,16 @@
 }
 
 void
+set_suppress_timestamps (bool suppressed)
+{
+  suppress_timestamps = suppressed;
+}
+
+void
 error_reset ()
 {
   use_syslog = std_redir = false;
+  suppress_timestamps = false;
   x_debug_level = 1;
   mute_cutoff = 0;
   mute_count = 0;
@@ -252,7 +262,7 @@
       FILE *fp = msg_fp();
       const bool show_usec = check_debug_level (DEBUG_LEVEL_USEC_TIME - 1);
 
-      if (flags & M_NOPREFIX)
+      if (flags & M_NOPREFIX || suppress_timestamps)
 	{
 	  fprintf (fp, "%s%s%s\n",
 		   prefix,
diff -ru3 openvpn-2.0_beta11/error.h openvpn-2.0_beta11+suppression/error.h
--- openvpn-2.0_beta11/error.h	2004-08-15 07:28:35.000000000 -0500
+++ openvpn-2.0_beta11+suppression/error.h	2004-10-15 10:53:31.000000000 -0500
@@ -152,6 +152,7 @@
 void error_reset (void);
 void set_debug_level (int level);
 void set_mute_cutoff (int cutoff);
+void set_suppress_timestamps (bool suppressed);
 
 /*
  * File to print messages to before syslog is opened.
diff -ru3 openvpn-2.0_beta11/openvpn.8 openvpn-2.0_beta11+suppression/openvpn.8
--- openvpn-2.0_beta11/openvpn.8	2004-08-18 20:35:06.000000000 -0500
+++ openvpn-2.0_beta11+suppression/openvpn.8	2004-10-15 10:57:47.000000000 -0500
@@ -161,6 +161,7 @@
 [\ \fB\-\-local\fR\ \fIhost\fR\ ]
 [\ \fB\-\-log\-append\fR\ \fIfile\fR\ ]
 [\ \fB\-\-log\fR\ \fIfile\fR\ ]
+[\ \fB\-\-suppress-timestamps\fR\ ]
 [\ \fB\-\-lport\fR\ \fIport\fR\ ]
 [\ \fB\-\-max\-clients\fR\ \fIn\fR\ ]
 [\ \fB\-\-mktun\fR\ ]
@@ -1746,6 +1747,12 @@
 than truncating the log file.
 .\"*********************************************************
 .TP
+.B --suppress-timestamps
+Avoid writing timestamps to log messages, even when they
+otherwise would be prepended. In particular, this applies to
+log messages sent to stdout.
+.\"*********************************************************
+.TP
 .B --writepid file
 Write OpenVPN's main process ID to
 .B file.
diff -ru3 openvpn-2.0_beta11/options.c openvpn-2.0_beta11+suppression/options.c
--- openvpn-2.0_beta11/options.c	2004-08-18 16:32:19.000000000 -0500
+++ openvpn-2.0_beta11+suppression/options.c	2004-10-15 10:45:06.000000000 -0500
@@ -210,6 +210,7 @@
   "                  See --daemon above for a description of the 'name' parm.\n"
   "--log file      : Output log to file which is created/truncated on open.\n"
   "--log-append file : Append log to file, or create file if nonexistent.\n"
+  "--suppress-timestamps : Don't log timestamps to stdout/stderr.\n"
   "--writepid file : Write main process ID to file.\n"
   "--nice n        : Change process priority (>0 = lower, <0 = higher).\n"
 #ifdef USE_PTHREAD
@@ -854,6 +855,7 @@
   SHOW_BOOL (daemon);
   SHOW_INT (inetd);
   SHOW_BOOL (log);
+  SHOW_BOOL (suppress_timestamps);
   SHOW_INT (nice);
   SHOW_INT (verbosity);
   SHOW_INT (mute);
@@ -2293,6 +2295,13 @@
       options->log = true;
       redirect_stdout_stderr (p[1], false);
     }
+  else if (streq (p[0], "suppress-timestamps"))
+    {
+      ++i;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->suppress_timestamps = true;
+      set_suppress_timestamps(true);
+    }
   else if (streq (p[0], "log-append") && p[1])
     {
       ++i;
diff -ru3 openvpn-2.0_beta11/options.h openvpn-2.0_beta11+suppression/options.h
--- openvpn-2.0_beta11/options.h	2004-08-18 16:32:20.000000000 -0500
+++ openvpn-2.0_beta11+suppression/options.h	2004-10-15 08:57:15.000000000 -0500
@@ -183,6 +183,7 @@
   int inetd;
 
   bool log;
+  bool suppress_timestamps;
   int nice;
   int verbosity;
   int mute;

--=_smtp.isgenesis.com-6332-1097856413-0001-2--

