From: Arne Schwabe <arne@...1227...>
Date: Thu, 17 Feb 2022 19:22:34 +0100
Message-Id: <20220217182234.33850-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Fix OpenVPN querying user/password if
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

Patch v2: Remove unrelated code change
Patch v3: Rebase to master

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 1 +
 src/openvpn/ssl.c  | 7 ++++++-
 src/openvpn/ssl.h  | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 21adc3cf..e5fba621 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -590,6 +590,7 @@ init_query_passwords(const struct context *c)
     /* Auth user/pass input */
     if (c->options.auth_user_pass_file)
     {
+        enable_auth_user_pass();
 #ifdef ENABLE_MANAGEMENT
         auth_user_pass_setup(c->options.auth_user_pass_file, &c->options.sc_info);
 #else
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 14a943a7..b68708b0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -398,9 +398,14 @@ static char *auth_challenge; /* GLOBAL */
 #endif
 
 void
-auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *sci)
+enable_auth_user_pass()
 {
     auth_user_pass_enabled = true;
+}
+
+void
+auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *sci)
+{
     if (!auth_user_pass.defined && !auth_token.defined)
     {
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index cf754ad2..76d8a7dc 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -436,6 +436,9 @@ void tls_post_encrypt(struct tls_multi *multi, struct buffer *buf);
  */
 void pem_password_setup(const char *auth_file);
 
+/* Enables the use of user/password authentication */
+void enable_auth_user_pass();
+
 /*
  * Setup authentication username and password. If auth_file is given, use the
  * credentials stored in the file.
-- 
2.33.0


