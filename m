From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 22 Feb 2013 10:44:20 +0100
Message-ID: <1361526263-1740-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
References: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] reintroduce --no-name-remapping option
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

The option is just an alias for --compat-names no-remapping and is
introduced so pre-2.3 server configurations don't break.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 doc/openvpn.8         |   32 +++++++++++++++++++++++---------
 src/openvpn/options.c |   21 ++++++++++++++-------
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 829bbd2..998f7ab 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3462,19 +3462,16 @@ characters in the usernames, X.509 Subject fields and Common Name variables and
 it complies to the RFC 2253, UTF\-8 String Representation of Distinguished
 Names.
 
-As a backwards compatibility for the removed \-\-no\-name\-remapping feature in
-older OpenVPN versions, the
+The
 .B no\-remapping
 mode flag can be used with the
 .B
 \-\-compat\-names
-option.
-When this mode flag is used, the Common Name, Subject, and username strings are
-allowed to include any printable character including space, but excluding
-control characters such as tab, newline, and carriage-return. It ensures
-compatibility with the
-.B \-\-no\-name\-remapping
-option of OpenVPN versions before v2.3.
+option to be compatible with the now deprecated \-\-no\-name\-remapping feature
+present in older OpenVPN versions. When this mode flag is used, the Common Name,
+Subject, and username strings are allowed to include any printable character
+including space, but excluding control characters such as tab, newline, and
+carriage-return.
 
 .B Please note:
 This option will not be around for a long time.  It is only implemented
@@ -3483,6 +3480,23 @@ removed either in OpenVPN v2.4 or v2.5.  So please make sure you start
 the process to support the new formatting as soon as possible.
 .\"*********************************************************
 .TP
+.B \-\-no\-name\-remapping (DEPRECATED)
+The
+.B \-\-no\-name\-remapping
+option is an alias for
+.B \-\-compat\-names\ no\-remapping.
+It ensures compatibility with configurations using the
+.B \-\-no\-name\-remapping
+option.
+
+.B Please note:
+This option is now deprecated.  It will be removed either in OpenVPN v2.4
+or v2.5.  So please make sure you support the new X.509 name formatting
+described with the
+.B \-\-compat\-names
+option as soon as possible.
+.\"*********************************************************
+.TP
 .B \-\-port-share host port [dir]
 When run in TCP server mode, share the OpenVPN port with
 another application, such as an HTTPS server.  If OpenVPN
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3b5f1e7..dd38bc9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5561,13 +5561,6 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->ssl_flags |= SSLF_AUTH_USER_PASS_OPTIONAL;
     }
-  else if (streq (p[0], "compat-names"))
-    {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
-      if (p[1] && streq (p[1], "no-remapping"))
-        compat_flag (COMPAT_FLAG_SET | COMPAT_NO_NAME_REMAPPING);
-    }
   else if (streq (p[0], "opt-verify"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6518,6 +6511,20 @@ add_option (struct options *options,
       options->tls_export_cert = p[1];
     }
 #endif
+  else if (streq (p[0], "compat-names"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
+      if (p[1] && streq (p[1], "no-remapping"))
+        compat_flag (COMPAT_FLAG_SET | COMPAT_NO_NAME_REMAPPING);
+    }
+  else if (streq (p[0], "no-name-remapping"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      msg (M_WARN, "DEPRECATED OPTION: --no-name-remapping, please update your configuration");
+      compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
+      compat_flag (COMPAT_FLAG_SET | COMPAT_NO_NAME_REMAPPING);
+    }
   else if (streq (p[0], "tls-remote") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-- 
1.7.9.5


