From: David Sommerseth <openvpn.list@...1114...>
Date: Tue,  9 Sep 2014 19:26:12 +0200
Message-Id: <1410283573-17933-2-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1410283573-17933-1-git-send-email-openvpn.list@...1114...>
References: <1410283573-17933-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH v2 1/2] Don't try to use
	systemd-ask-password if it is not available
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

If the SYSTEMD_ASK_PASSWORD_PATH executable cannot be found, we
don't consider systemd as running.

[v2 - Don't clean up white-space]

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/console.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 059b6f0..337b1bb 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -143,14 +143,16 @@ close_tty (FILE *fp)
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
 	  && (lstat("/sys/fs/cgroup/systemd", &b) == 0)
-	  && (a.st_dev != b.st_dev);
+	  && (a.st_dev != b.st_dev)
+	  && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) == 0);
 
 }
 
-- 
1.8.3.1


