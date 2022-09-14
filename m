From: Antonio Quartulli <a@...2181...>
Date: Wed, 14 Sep 2022 20:59:37 +0200
Message-Id: <20220914185937.31423-2-a@...2181...>
In-Reply-To: <20220914185937.31423-1-a@...2181...>
References: <20220914185937.31423-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] get_user_pass_cr: get password from
 stdin if missing inline
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
Cc: Antonio Quartulli <a@...2181...>

Until now, when HTTP proxy user and password were specified inline,
it was assumed that both creds were specified. A missing password would
result in an empty password being stored.

This behaviour is not ideal, as we want to allow the user to store the
username, but let the password be entered via stdin.

This affects both http proxy and authentication inline'd creds.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 Changes.rst        | 4 +++-
 src/openvpn/misc.c | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 2967533a..2daa97fb 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -89,7 +89,9 @@ Data channel offloading with ovpn-dco
 
 Inline auth username and password
     Username and password can now be specified inline in the configuration file
-    within the <auth-user-pass></auth-user-pass> tags.
+    within the <auth-user-pass></auth-user-pass> tags. If the password is
+    missing OpenVPN will prompt for input via stdin. This applies to inline'd
+    http-proxy-user-pass too.
 
 
 Deprecated features
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 07f6e202..50f7f975 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -197,6 +197,11 @@ get_user_pass_cr(struct user_pass *up,
                 buf_parse(&buf, '\n', up->username, USER_PASS_LEN);
             }
             buf_parse(&buf, '\n', up->password, USER_PASS_LEN);
+
+            if (strlen(up->password) == 0)
+            {
+                password_from_stdin = 1;
+            }
         }
         /*
          * Read from auth file unless this is a dynamic challenge request.
-- 
2.35.1


