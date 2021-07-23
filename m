From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Jul 2021 11:43:59 +0200
Message-Id: <20210723094359.282005-1-arne@...1227...>
In-Reply-To: <20210722162409.231265-1-arne@...1227...>
References: <20210722162409.231265-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix OpenVPN querying user/password if
 auth-token with user expires
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

The problematic behaviour happens when start a profile without
auth-user-pass and connect to a server that pushes auth-token
When the auth token expires OpenVPN asks for auth User and password
again.

The problem is that the auth_user_pass_setup sets
auth_user_pass_enabled = true; This function is called from two places.
In ssl.c it is only called with an auth-token present or that
variable already set. The other one is init_query_passwords.

Move setting auth_user_pass_enabled to the second place to ensure it is
only set if we really want passwords.

Patch V2: Remove unrelated code change

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 1 +
 src/openvpn/ssl.c  | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a1401e805..d5d192663 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -595,6 +595,7 @@ init_query_passwords(const struct context *c)
     /* Auth user/pass input */
     if (c->options.auth_user_pass_file)
     {
+        auth_user_pass_enabled = true;
 #ifdef ENABLE_MANAGEMENT
         auth_user_pass_setup(c->options.auth_user_pass_file, &c->options.sc_info);
 #else
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index aa8cb3b27..c2dc36019 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -396,7 +396,6 @@ static char *auth_challenge; /* GLOBAL */
 void
 auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *sci)
 {
-    auth_user_pass_enabled = true;
     if (!auth_user_pass.defined && !auth_token.defined)
     {
 #ifdef ENABLE_MANAGEMENT
-- 
2.32.0


