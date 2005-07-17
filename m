Message-ID: <42DAA4C6.3070301@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
References: <20050405173227.0AEC512120@...436...> <425328AB.7050307@...437...> <Pine.LNX.4.58.0504051824120.19198@...41...> <4253A8DC.1040808@...361...>
In-Reply-To: <4253A8DC.1040808@...361...>
Content-Type: multipart/mixed;
 boundary="------------060809040507090205030901"
Subject: [Openvpn-devel] PATCH: syslog while not running as a daemon
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
Date: Sun Jul 17 11:36:33 2005
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060809040507090205030901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

When not running as a daemon (--daemon option), OpenVPN writes all 
output to stderr. When OpenVPN isn't run interactively, but it actually 
isn't run with the --daemon option as well, it's rather inconvenient 
that syslog isn't used. This is primarily an issue for the development 
of a VPN appliance I'm working on 
(http://adsl-dc-3b681.adsl.wanadoo.nl/vvpn) but if for example OpenVPN 
would be controlled by inittab the same problem is there.

Attached a patch that solves the problem for me, it may be of use to 
others as well.

Cheers!

Rolf

--------------060809040507090205030901
Content-Type: text/x-patch;
 name="openvpn-2.0-syslog.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.0-syslog.patch"

--- openvpn-2.0/options.c.fks	2005-06-05 11:21:14.000000000 +0200
+++ openvpn-2.0/options.c	2005-06-05 11:34:25.000000000 +0200
@@ -232,6 +232,9 @@
   "                  See --daemon above for a description of the 'name' parm.\n"
   "--log file      : Output log to file which is created/truncated on open.\n"
   "--log-append file : Append log to file, or create file if nonexistent.\n"
+  "--syslog [name] : Output log to syslog.\n"
+  "                  The optional 'name' parameter will be passed\n"
+  "                  as the program name to the system logger.\n"
   "--suppress-timestamps : Don't log timestamps to stdout/stderr.\n"
   "--writepid file : Write main process ID to file.\n"
   "--nice n        : Change process priority (>0 = lower, <0 = higher).\n"
@@ -1014,6 +1017,7 @@
   SHOW_BOOL (up_restart);
   SHOW_BOOL (up_delay);
   SHOW_BOOL (daemon);
+  SHOW_BOOL (syslog);
   SHOW_INT (inetd);
   SHOW_BOOL (log);
   SHOW_BOOL (suppress_timestamps);
@@ -2895,12 +2899,32 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->up_restart = true;
     }
+  else if (streq (p[0], "syslog"))
+    {
+      bool didit = false;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (!options->syslog)
+	{
+	  options->syslog = didit = true;
+	  open_syslog (p[1], false);
+	}
+      if (p[1])
+	{
+	  ++i;
+	  if (!didit)
+	    {
+	      msg (M_WARN, "WARNING: Multiple --daemon/syslog directives specified, ignoring --syslog %s. (Note that initscripts sometimes add their own --daemon/syslog directive.)", p[1]);
+	      goto err;
+	    }
+	}
+    }
   else if (streq (p[0], "daemon"))
     {
       bool didit = false;
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      if (!options->daemon)
+      if (!options->syslog)
 	{
+	  options->syslog = didit = true;
 	  options->daemon = didit = true;
 	  open_syslog (p[1], false);
 	}
@@ -2909,7 +2933,7 @@
 	  ++i;
 	  if (!didit)
 	    {
-	      msg (M_WARN, "WARNING: Multiple --daemon directives specified, ignoring --daemon %s. (Note that initscripts sometimes add their own --daemon directive.)", p[1]);
+	      msg (M_WARN, "WARNING: Multiple --daemon/syslog directives specified, ignoring --daemon %s. (Note that initscripts sometimes add their own --daemon/syslog directive.)", p[1]);
 	      goto err;
 	    }
 	}
--- openvpn-2.0/options.h.fks	2005-06-05 11:25:50.000000000 +0200
+++ openvpn-2.0/options.h	2005-06-05 11:26:14.000000000 +0200
@@ -199,6 +199,7 @@
   bool up_delay;
   bool up_restart;
   bool daemon;
+  bool syslog;
 
   int remap_sigusr1;
 

--------------060809040507090205030901--

