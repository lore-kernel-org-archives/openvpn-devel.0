Message-ID: <1320075008.29689.31.camel@...1520...>
From: Frederic Crozat <fcrozat@...1519...>
Date: Mon, 31 Oct 2011 16:30:08 +0100
Content-Type: multipart/mixed; boundary="=-3dnKs9tSk7ec2REPCRsE"
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] adding support for systemd tty console
	wrapper
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-3dnKs9tSk7ec2REPCRsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

as part of openSUSE switching to systemd by default, openVPN was made
compatible with the systemd way of querying passphrase during boot
(directly opening tty isn't supported).

-- 
Frederic Crozat <fcrozat@...1519...>
SUSE


--=-3dnKs9tSk7ec2REPCRsE
Content-Disposition: inline;
	filename="0001-Add-support-to-forward-console-query-to-systemd.patch"
Content-Type: text/x-patch;
	name="0001-Add-support-to-forward-console-query-to-systemd.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 02a9e6b213eba6dbb90b92b4d51e907718e46a56 Mon Sep 17 00:00:00 2001
From: Frederic Crozat <fcrozat@...1519...>
Date: Mon, 31 Oct 2011 15:51:53 +0100
Subject: [PATCH] Add support to forward console query to systemd

Systemd requires console query to be forwarded using its own
tool.

Signed-off-by: Frederic Crozat <fcrozat@...1519...>
---
 misc.c |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/misc.c b/misc.c
index 99e5bc5..c074abe 100644
--- a/misc.c
+++ b/misc.c
@@ -1338,26 +1338,49 @@ get_console_input (const char *prompt, const bool echo, char *input, const int c
   ASSERT (input);
   ASSERT (capacity > 0);
   input[0] = '\0';
+  bool is_systemd_running;
+  struct stat a, b;
+
+  /* We simply test whether the systemd cgroup hierarchy is
+   * mounted */
+
+  is_systemd_running = (lstat("/sys/fs/cgroup", &a) == 0)
+	  && (lstat("/sys/fs/cgroup/systemd", &b) == 0)
+	  && (a.st_dev != b.st_dev);
 
 #if defined(WIN32)
   return get_console_input_win32 (prompt, echo, input, capacity);
 #elif defined(HAVE_GETPASS)
-  if (echo)
+  if (echo || is_systemd_running)
     {
       FILE *fp;
 
-      fp = open_tty (true);
-      fprintf (fp, "%s", prompt);
-      fflush (fp);
-      close_tty (fp);
+      if (is_systemd_running)
+        {
+	 char *cmd;
 
-      fp = open_tty (false);
+	 asprintf(&cmd, "/bin/systemd-ask-password \"%s\"", prompt);
+         fp = popen (cmd, "re");
+	 free (cmd);
+        }
+      else
+        {
+          fp = open_tty (true);
+          fprintf (fp, "%s", prompt);
+          fflush (fp);
+          close_tty (fp);
+
+          fp = open_tty (false);
+        }
       if (fgets (input, capacity, fp) != NULL)
 	{
 	  chomp (input);
 	  ret = true;
 	}
-      close_tty (fp);
+      if (is_systemd_running)
+	fclose (fp);
+      else
+	close_tty (fp);
     }
   else
     {
-- 
1.7.7


--=-3dnKs9tSk7ec2REPCRsE--


