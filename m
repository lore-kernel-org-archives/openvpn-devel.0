From: davids@...1347...
Date: Fri,  5 Sep 2014 17:25:29 +0200
Message-Id: <1409930731-15263-3-git-send-email-davids@...1347...>
In-Reply-To: <1409930731-15263-1-git-send-email-davids@...1347...>
References: <1409930731-15263-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH 2/4] Don't try to use systemd-ask-password
	if it is not available
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
Cc: fcrozat@...1519...

From: David Sommerseth <davids@...1347...>

If the SYSTEMD_ASK_PASSWORD_PATH executable cannot be found, we
don't consider systemd as running.

Also cleaned up some white-space issues here while at it.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/console.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 059b6f0..e35b6bd 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -143,15 +143,16 @@ close_tty (FILE *fp)
 static bool
 check_systemd_running ()
 {
-  struct stat a, b;
+  struct stat a, b, c;
 
   /* We simply test whether the systemd cgroup hierarchy is
-   * mounted */
+   * mounted, as well as the systemd-ask-password executable
+   * being available */
 
   return (lstat("/sys/fs/cgroup", &a) == 0)
-	  && (lstat("/sys/fs/cgroup/systemd", &b) == 0)
-	  && (a.st_dev != b.st_dev);
-
+    && (lstat("/sys/fs/cgroup/systemd", &b) == 0)
+    && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) == 0)
+    && (a.st_dev != b.st_dev);
 }
 
 static bool
-- 
1.8.3.1


