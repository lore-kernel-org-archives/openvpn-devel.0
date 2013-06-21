From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Jun 2013 14:43:30 +0200
Message-Id: <1371818610-4599-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add support to ignore specific options.
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
 doc/openvpn.8         |   24 ++++++++++++++++++++-
 src/openvpn/options.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/options.h |    2 ++
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 949577b..d384252 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1888,9 +1888,31 @@ in future OpenVPN versions.
 
 This option should be used with caution, as there are good security
 reasons for having OpenVPN fail if it detects problems in a
-config file.  Having said that, there are valid reasons for wanting
+config file. Having said that, there are valid reasons for wanting
 new software features to gracefully degrade when encountered by
 older software versions.
+
+See also 
+.B \-\-ignore-unknown-option
+.\"*********************************************************
+.TP
+.B \-\-ignore-unknown-option opt1 opt2 opt3 ... optN
+When one of options 
+.B opt1 ... optN
+is encountered in the configuration file the configuration 
+file parsing does not fail if this OpenVPN version does not 
+support the option. Multiple 
+.B \-\-ignore-unknown-option
+options can be given to support a larger number of options to ignore. 
+
+This option should be used with caution, as there are good security
+reasons for having OpenVPN fail if it detects problems in a
+config file. Having said that, there are valid reasons for wanting
+new software features to gracefully degrade when encountered by
+older software versions.
+
+.B \-\-ignore-unknown-option
+is available since OpenVPN 2.3.3.
 .\"*********************************************************
 .TP
 .B \-\-setenv-safe name value
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 883136f..2f31a62 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -255,6 +255,8 @@ static const char usage_message[] =
   "--setenv name value : Set a custom environmental variable to pass to script.\n"
   "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to allow\n"
   "                  directives for future OpenVPN versions to be ignored.\n"
+  "--ignore-unkown-option opt1 opt2 ...: Relax config file syntax. Allow\n"
+  "                  these options to be ignored when unknown\n"
   "--script-security level: Where level can be:\n"
   "                  0 -- strictly no calling of external programs\n"
   "                  1 -- (default) only call built-ins such as ifconfig\n"
@@ -4405,6 +4407,44 @@ add_option (struct options *options,
 	  uninit_options (&sub);
 	}
     }
+  else if (streq (p[0], "ignore-unknown-option") && p[1]) 
+    {
+      int i;
+      int j;
+      int numignored=0;
+      const char **ignore;
+
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      /* Find out how many options to be ignored */
+      for (i=1;p[i];i++)
+        numignored++;
+
+      numignored=i;
+      /* add number of options already ignored */
+      for (i=0;options->ignore_unknown_option &&
+             options->ignore_unknown_option[i]; i++)
+        numignored++;
+
+      /* Allocate array */
+      ALLOC_ARRAY_GC (ignore, const char*, numignored+1, &options->gc);
+      for (i=0;options->ignore_unknown_option &&
+             options->ignore_unknown_option[i]; i++)
+        ignore[i]=options->ignore_unknown_option[i];
+
+      options->ignore_unknown_option=ignore;
+
+      for (j=1;p[j];j++)
+        {
+          /* Allow the user to specify ignore-unknown-option --opt too */
+          if (p[j][0]=='-' && p[j][1]=='-')
+            options->ignore_unknown_option[i] = p[j]+2;
+          else
+            options->ignore_unknown_option[i] = p[j];
+          i++;
+        }
+
+      options->ignore_unknown_option[i] = NULL;
+    }
   else if (streq (p[0], "remote-ip-hint") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6891,10 +6931,22 @@ add_option (struct options *options,
 #endif
   else
     {
+      int msglevel= msglevel_fc;
+      int i;
+      for(i=0; options->ignore_unknown_option && options->ignore_unknown_option[i]; i++)
+        {
+          const char* opt = options->ignore_unknown_option[i];
+
+          if (streq(p[0], opt))
+            {
+              msglevel = M_WARN;
+              break;
+            }
+        }
       if (file)
-	msg (msglevel_fc, "Unrecognized option or missing parameter(s) in %s:%d: %s (%s)", file, line, p[0], PACKAGE_VERSION);
+	msg (msglevel, "Unrecognized option or missing parameter(s) in %s:%d: %s (%s)", file, line, p[0], PACKAGE_VERSION);
       else
-	msg (msglevel_fc, "Unrecognized option or missing parameter(s): --%s (%s)", p[0], PACKAGE_VERSION);
+	msg (msglevel, "Unrecognized option or missing parameter(s): --%s (%s)", p[0], PACKAGE_VERSION);
     }
  err:
   gc_free (&gc);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 6a132a6..8e0e367 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -186,6 +186,8 @@ struct options
 
   /* enable forward compatibility for post-2.1 features */
   bool forward_compatible;
+  /* list of options that should be ignored even if unkown */
+  const char **  ignore_unknown_option;
 
   /* persist parms */
   bool persist_config;
-- 
1.7.9.5


