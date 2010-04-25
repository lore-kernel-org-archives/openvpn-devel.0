From: David Sommerseth <openvpn.list@...1114...>
Date: Mon, 26 Apr 2010 00:42:55 +0200
Message-Id: <1272235375-20327-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Avoid repetition of "this config may cache
	passwords in memory"
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
To: Openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

For OpenVPN clients with long living connections, this message is repeated
everytime the connection is renegotiated.  This patch removes this behaviour
and will only show this warning once.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 misc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/misc.c b/misc.c
index 643ffad..7052584 100644
--- a/misc.c
+++ b/misc.c
@@ -1588,14 +1588,16 @@ void
 purge_user_pass (struct user_pass *up, const bool force)
 {
   const bool nocache = up->nocache;
+  static warn_shown = false;
   if (nocache || force)
     {
       CLEAR (*up);
       up->nocache = nocache;
     }
-  else
+  else if (!warn_shown)
     {
       msg (M_WARN, "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this");
+      warn_shown = true;
     }
 }
 
-- 
1.6.6.1


