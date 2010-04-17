From: David Sommerseth <openvpn.list@...1114...>
Date: Sat, 17 Apr 2010 21:06:09 +0200
Message-Id: <1271531169-10293-2-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1271531169-10293-1-git-send-email-openvpn.list@...1114...>
References: <1271531169-10293-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH 2/2] Fixed potential NULL pointer issue
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
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

If create_temp_file() returns NULL, this strlen() check would cause
a SEGV.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 ssl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ssl.c b/ssl.c
index 552bcbe..171a1d7 100644
--- a/ssl.c
+++ b/ssl.c
@@ -3194,7 +3194,7 @@ verify_user_pass_script (struct tls_session *session, const struct user_pass *up
     }
 
  done:
-  if (strlen (tmp_file) > 0)
+  if (tmp_file && strlen (tmp_file) > 0)
     delete_file (tmp_file);
 
   argv_reset (&argv);
-- 
1.6.6.1


