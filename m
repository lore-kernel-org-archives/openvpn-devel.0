Message-ID: <52237C62.6070805@...1832...>
Date: Sun, 01 Sep 2013 19:41:54 +0200
From: Max.Muster@...1832...
MIME-Version: 1.0
Subject: [Openvpn-devel] File checking error with "chroot"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Dear list,

may I ask for your attention or feedback on the faulty file checking if
"chroot" option is enabled?

The "check_file_access" in src/openvpn/options.c will check for the
existence of the "client-config-dir".
This fails if used in conjunction with the "chroot" option, because the
path in the config needs to be relative to the chroot directory,  but
file check will always look for it as a full path.

I opened ticket 299 and attatched two possible solutions for this issue
(see below for the one I would prefer).

It would be nice if somone could
- confirm that this is a bug (or show how it is intended to work)
- see, if my patches could be used at least as a starting point (knowing
I am no good coder)

Thanks!

Joerg


The second patch is more general and introducing a new function
"check_file_access_chroot" for checking for files which might reside
inside chroot directory:

--- src/openvpn/options.c
+++ src/openvpn/options.c
@@ -2609,6 +2609,20 @@
   return (errcode != 0 ? true : false);
 }

+/* Filecheck if file might be relative to chroot dir */
+static bool
+check_file_access_chroot(const int type, const char *file, const int
mode, const char *opt, const char *chrootpath)
+{
+  if (chrootpath)
+    {
+      char fullpath [strlen(file) + strlen(chrootpath) +2];
+      sprintf(fullpath, "%s/%s", chrootpath,file);
+      return check_file_access(type, fullpath, mode, opt);
+    }
+  else
+    return check_file_access(type, file, mode, opt);
+}
+
 /*
  * Verifies that the path in the "command" that comes after certain
script options (e.g., --up) is a
  * valid file with appropriate permissions.
@@ -2733,8 +2747,8 @@
                              R_OK|W_OK|X_OK, "--tls-export-cert");
 #endif /* ENABLE_SSL */
 #if P2MP_SERVER
-  errs |= check_file_access (CHKACC_FILE, options->client_config_dir,
-                             R_OK|X_OK, "--client-config-dir");
+  errs |= check_file_access_chroot (CHKACC_FILE,
options->client_config_dir,
+                             R_OK|X_OK, "--client-config-dir",
options->chroot_dir);
   errs |= check_file_access (CHKACC_FILE, options->tmp_dir,
                              R_OK|W_OK|X_OK, "Temporary directory
(--tmp-dir)");



