From: selva.nair@...277...
Date: Tue,  7 Aug 2018 22:44:31 -0400
Message-Id: <1533696271-21799-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1533696271-21799-1-git-send-email-selva.nair@...277...>
References: <1533696271-21799-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] Accept empty password and/or response
 in auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

In the auth-pam plugin correctly parse the static challenge string
even when password or challenge response is empty.

Whether an empty user input is an error is determined by the PAM
conversation function depending on whether the PAM module queries
for it or not.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/plugins/auth-pam/auth-pam.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 1324307..88b5320 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -310,11 +310,11 @@ split_scrv1_password(struct user_pass *up)
     *resp++ = '\0';
 
     int n = plugin_base64_decode(pass, up->password, sizeof(up->password)-1);
-    if (n > 0)
+    if (n >= 0)
     {
         up->password[n] = '\0';
         n = plugin_base64_decode(resp, up->response, sizeof(up->response)-1);
-        if (n > 0)
+        if (n >= 0)
         {
             up->response[n] = '\0';
             if (DEBUG(up->verb))
-- 
2.6.2


