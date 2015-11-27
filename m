From: Selva Nair <selva.nair@...277...>
Date: Thu, 26 Nov 2015 21:20:53 -0500
Message-Id: <1448590853-26862-1-git-send-email-selva.nair@...277...>
In-Reply-To: <20151126125313.GX24952@...1296...>
References: <20151126125313.GX24952@...1296...>
Subject: [Openvpn-devel] [PATCH take3] Unbreak read username password from
	management
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Commit 6e9373c846.. introduced a bug by which auth-user-pass
or need-ok input falls back to read-from-stdin after successfully
reading from management or console. Fix by treating stdin as the last
option for input.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
  Changes: Delay the setting of "xx_from_stdin" flags
  Tested: user/pass from management, file, stdin and a simulated NEED_OK
          to stdin and management.

 src/openvpn/misc.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index b6c8854..ea9e3d2 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1004,8 +1004,8 @@ get_user_pass_cr (struct user_pass *up,
   if (!up->defined)
     {
       bool from_authfile = (auth_file && !streq (auth_file, "stdin"));
-      bool username_from_stdin = !from_authfile;
-      bool password_from_stdin = !from_authfile;
+      bool username_from_stdin = false;
+      bool password_from_stdin = false;
 
       if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	msg (M_WARN, "Note: previous '%s' credentials failed", prefix);
@@ -1102,6 +1102,11 @@ get_user_pass_cr (struct user_pass *up,
           if (!(flags & GET_USER_PASS_PASSWORD_ONLY) && strlen (up->username) == 0)
             msg (M_FATAL, "ERROR: username from %s authfile '%s' is empty", prefix, auth_file);
         }
+      else
+        {
+          username_from_stdin = true;
+          password_from_stdin = true;
+        }
 
       /*
        * Get username/password from standard input?
-- 
1.7.10.4


