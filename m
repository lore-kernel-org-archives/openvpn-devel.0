From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 7 Dec 2011 18:59:21 +0100
Message-ID: <1323280761-26152-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1323280731-26083-1-git-send-email-heiko.hund@...1489...>
References: <1323280731-26083-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] set Windows environment variables as UCS-2
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

Windows uses 16 bit wide characters to represent Unicode in the
process environment. Convert UTF-8 to UCS-2 and use the wide
character API to set environment variables.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 misc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc.c b/misc.c
index ad74357..ddd5fdf 100644
--- a/misc.c
+++ b/misc.c
@@ -1030,8 +1030,8 @@ setenv_str_ex (struct env_set *es,
     {
 #if defined(WIN32)
       {
-	/*msg (M_INFO, "SetEnvironmentVariable '%s' '%s'", name_tmp, val_tmp ? val_tmp : "NULL");*/
-	if (!SetEnvironmentVariable (name_tmp, val_tmp))
+        if (!SetEnvironmentVariableW (wide_string (name_tmp, &gc),
+                                      wide_string (val_tmp, &gc)))
 	  msg (M_WARN | M_ERRNO, "SetEnvironmentVariable failed, name='%s', value='%s'",
 	       name_tmp,
 	       val_tmp ? val_tmp : "NULL");
-- 
1.7.5.4


