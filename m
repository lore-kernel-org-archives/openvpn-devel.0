From: David Sommerseth <openvpn.list@...1114...>
Date: Tue, 10 Mar 2015 14:57:54 +0100
Message-Id: <1425995874-2956-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Create directory on-the-fly for pid file if
	it does not exist
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

From: David Sommerseth <davids@...1347...>

Some distros, like RHEL7, have placed the directory it uses to
track pid files (/run) on a tmpfs file system.  This results in
the /run directory to be wiped on each boot.  As the systemd unit
file may expect OpenVPN pid-files (one for each openvpn connection)
to reside inside a sub-directory, OpenVPN will then fail to start.

This patch enhanches the check_file_access() function to support
a CHKACC_MKDIR type flag, which will tell it to create a directory
if it is missing.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/options.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index df9a641..6a0fbf6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2545,6 +2545,7 @@ options_postprocess_mutate (struct options *o)
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
 #define CHKACC_INLINE (1<<3)     /** File is present if it's an inline file */
 #define CHKACC_ACPTSTDIN (1<<4)  /** If filename is stdin, it's allowed and "exists" */
+#define CHKACC_MKDIR (1<<5)      /** If directory is missing, create it on-the-fly */
 
 static bool
 check_file_access(const int type, const char *file, const int mode, const char *opt)
@@ -2571,8 +2572,14 @@ check_file_access(const int type, const char *file, const int mode, const char *
       char *fullpath = strdup(file);  /* POSIX dirname() implementaion may modify its arguments */
       char *dirpath = dirname(fullpath);
 
-      if (platform_access (dirpath, mode|X_OK) != 0)
+      if (platform_access (dirpath, mode|X_OK) != 0) {
+          /* If the directory does not exist, we might have been told to create it */
+          if (errno == ENOENT && (type & CHKACC_MKDIR)) {
+            mode_t dirmask =  (R_OK ? S_IRUSR : 0) | (W_OK ? S_IWUSR : 0 ) | S_IXUSR;
+            errno = (mkdir(dirpath, dirmask) == 0) ? 0 : errno;
+          }
           errcode = errno;
+      }
       free(fullpath);
     }
 
@@ -2738,7 +2745,7 @@ options_postprocess_filechecks (struct options *options)
   /* ** System related ** */
   errs |= check_file_access (CHKACC_FILE, options->chroot_dir,
                              R_OK|X_OK, "--chroot directory");
-  errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->writepid,
+  errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR|CHKACC_MKDIR, options->writepid,
                              R_OK|W_OK, "--writepid");
 
   /* ** Log related ** */
-- 
1.8.3.1


