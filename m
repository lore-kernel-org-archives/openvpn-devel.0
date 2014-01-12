From: Steffan Karger <steffan@...1856...>
Date: Sun, 12 Jan 2014 20:39:30 +0100
Message-Id: <1389555572-6210-2-git-send-email-steffan@...1856...>
In-Reply-To: <1389555572-6210-1-git-send-email-steffan@...1856...>
References: <1389555572-6210-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/3] Fix compiler warning for unused result
	of write()
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

Issue a warning instead of ignoring a failed write() completely.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index b22653b..901a094 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -340,7 +340,8 @@ journal_add (const char *journal_dir, struct proxy_connection *pc, struct proxy_
       fd = platform_open (jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);
       if (fd != -1)
 	{
-	  write(fd, f, strlen(f));
+	  if (write(fd, f, strlen(f)) != strlen(f))
+	    msg(M_WARN, "PORT SHARE: writing to journal file (%s) failed", jfn);
 	  close (fd);
 	  cp->jfn = jfn;
 	}
-- 
1.8.3.2


