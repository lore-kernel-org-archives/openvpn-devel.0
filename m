From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 21 Jan 2025 17:12:47 +0100
Message-Id: <20250121161247.37883-1-frank@...2641...>
In-Reply-To: <gerrit.1737375148000.Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20@...2715...>
References: <gerrit.1737375148000.Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove comparing username to NULL in
 tls_lock_username
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

From: Arne Schwabe <arne@...1227...>

tls_lock_username is only called in a single place and that place
calls this is function with up->username, which is always defined.

Change-Id: Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/871
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 4c4b58d..e7d7ed6 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -153,11 +153,11 @@
 {
     if (multi->locked_username)
     {
-        if (!username || strcmp(username, multi->locked_username))
+        if (strcmp(username, multi->locked_username) != 0)
         {
             msg(D_TLS_ERRORS, "TLS Auth Error: username attempted to change from '%s' to '%s' -- tunnel disabled",
                 multi->locked_username,
-                np(username));
+                username);
 
             /* disable the tunnel */
             tls_deauthenticate(multi);
@@ -166,10 +166,7 @@
     }
     else
     {
-        if (username)
-        {
-            multi->locked_username = string_alloc(username, NULL);
-        }
+        multi->locked_username = string_alloc(username, NULL);
     }
     return true;
 }

