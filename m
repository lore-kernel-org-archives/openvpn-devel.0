From: Maximilian Wilhelm <max@...1047...>
Date: Mon,  3 Sep 2007 01:14:03 +0200
Message-Id: <11887748432956-git-send-email-max@...1047...>
In-Reply-To: <11887748431930-git-send-email-max@...1047...>
References: <11887748431930-git-send-email-max@...1047...>
Subject: [Openvpn-devel] [PATCH] wtmp_init() does not honor
	username/groupname config options and chown()s wtmp file
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

  Now wtmp_init() does try to lookup the uid for "username" and the gid for
  "groupname" if configured and - if successfull - chown the wtmp file to this
  combination.

  (The lookup of uid/gid is neccessary here as 'context->c0' is no yet
   initialized at the point wtmp_init() is called.)

Signed-off-by: Maximilian Wilhelm <max@...1047...>
---
 wtmp.c |   47 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/wtmp.c b/wtmp.c
index 50dd5f9..374cf53 100644
--- a/wtmp.c
+++ b/wtmp.c
@@ -12,14 +12,16 @@
 
 #define _GNU_SOURCE
 
-#include <assert.h>
+#include <assert.h>	/* assert() */
 #include <dirent.h>	/* opendir() */
+#include <pwd.h>	/* struct passwd */
 #include <stdio.h>	/* fopen() */
 #include <stdlib.h>	/* *alloc(), free() */
 #include <string.h>	/* strncpy(), strlen() */
 #include <sys/stat.h>	/* stat() */
 #include <sys/time.h>	/* struct timeval */
-#include <sys/types.h>	/* opendir() */
+#include <sys/types.h>	/* opendir() chown()  */
+#include <unistd.h>	/* chown() */
 #include <utmp.h>	/* utmp foo */
 
 #include "openvpn.h"	/* struct context* */
@@ -46,12 +48,20 @@ wtmp_init (const struct options *vpn_options)
 
 	struct stat wtmp_stat;
 
+	/* These will be used when getting the uid/gid to chown the wtmp file */
+	struct passwd *pw;
+	struct group *grp;
+	unsigned short do_chmod = 2;
+	uid_t uid = -1;
+	gid_t gid = -1;
+
+	/* The wtmp file we're going to write to */
 	char *wtmp_file_path;
 
 	char *wtmp_file_dirname;
 	char *wtmp_file_path_copy;
 
-	assert (options);
+	assert (vpn_options);
 
 	/* Only initialize once */
 	if (wtmp_active == 1)
@@ -66,6 +76,24 @@ wtmp_init (const struct options *vpn_options)
 	wtmp_file_path_copy = strdup (wtmp_file_path);
 	wtmp_file_dirname = dirname (wtmp_file_path_copy);
 
+	/* Get UID and GID of the configured user and group */
+	if (vpn_options->username) {
+		pw = getpwnam (vpn_options->username);
+		if (pw)
+			uid = pw->pw_uid;
+		else
+			do_chmod -= 1;
+	}
+
+	if (vpn_options->groupname) {
+		grp = getgrnam (vpn_options->groupname);
+		if (grp)
+			gid = grp->gr_gid;
+		else
+			do_chmod -= 1;
+
+	}
+
 	/* Check if WTMP_DIR exists and try to create it if not */
 	if (! opendir (wtmp_file_dirname)) {
 		fprintf (stderr, "%s: wtmp_file_dirname %s does not exist. Trying to create it.\n",
@@ -99,6 +127,17 @@ wtmp_init (const struct options *vpn_options)
 			__FUNCTION__, wtmp_file_path);
 	} /* [ ! -f wtmp_file ] */
 
+	/* Maybe one changed "username" and "group" config options */
+	if (do_chmod == 2) {
+		if (chown (wtmp_file_path, uid, gid)) {
+			fprintf (stderr, "%s: Could not set owner/group of wtmp file %s.\n",
+				__FUNCTION__, wtmp_file_path);
+				wtmp_active = 0;
+				goto out;
+		}
+	}
+
+
 	/* OK wtmp_file is (now) there, use it */
 	utmpname (wtmp_file_path);
 
@@ -223,7 +262,7 @@ set_utmp_line (const struct multi_instance *mi, struct utmp *entry)
 	struct gc_arena gc = gc_new ();
 
 	char *temp;
-	unsigned int server_id
+	unsigned int server_id;
 
 	assert (mi);
 	assert (entry);
-- 
1.5.2.4


