From: David Sommerseth <davids@...1347...>
Date: Mon, 13 Dec 2010 12:56:16 +0100
Message-Id: <1292241376-18056-1-git-send-email-davids@...1347...>
In-Reply-To: <AANLkTi=NP1rL9m4PM1G0B4nZ853cig2Eh5ETFiUP6fod@...278...>
References: <AANLkTi=NP1rL9m4PM1G0B4nZ853cig2Eh5ETFiUP6fod@...278...>
Subject: [Openvpn-devel] [PATCH] Open log files as text files on Windows
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
Cc: David Sommerseth <davids@...1347...>

By giving the "t" flag to _fdopen() on Windows, the file will be
opened in a "translate mode", where it will take care of converting
\n to \r\n, and also look for the CTRL-Z mark when opening the log
file in append mode.

Reference:
<http://msdn.microsoft.com/en-us/library/dye30d82%28VS.80%29.aspx>

Thanks to Alon Bar-Lev for pointing out this solution.

Reported-by: Thomas Reifferscheid
Signed-off-by: David Sommerseth <davids@...1347...>
---
 error.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/error.c b/error.c
index 873718c..887f2d0 100644
--- a/error.c
+++ b/error.c
@@ -521,7 +521,7 @@ redirect_stdout_stderr (const char *file, bool append)
       
       /* open log_handle as FILE stream */
       ASSERT (msgfp == NULL);
-      msgfp = _fdopen (log_fd, "w");
+      msgfp = _fdopen (log_fd, "wt");
       if (msgfp == NULL)
 	msg (M_ERR, "Error: --log redirect failed due to _fdopen");
 
-- 
1.7.2.3


