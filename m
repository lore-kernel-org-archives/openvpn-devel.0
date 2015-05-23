From: Steffan Karger <steffan@...1856...>
Date: Sat, 23 May 2015 15:02:25 +0200
Message-Id: <1432386145-15045-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Re-read auth-user-pass file on (re)connect
	if required
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

Fixes trac #225 ('--auth-user-pass FILE' and '--auth-nocache' problem).

This patch is based on the changes suggested by ye_olde_iron in the trac
ticket.  Also added a note to the manpage to inform people to use
absolute paths when combining --auth-user-pass file and --auth-nocache.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8            | 3 +++
 src/openvpn/init.c       | 1 +
 src/openvpn/ssl.c        | 4 ++--
 src/openvpn/ssl_common.h | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index b9eee0d..e1e0af2 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4780,6 +4780,9 @@ when OpenVPN needs a username/password, it will prompt for input
 from stdin, which may be multiple times during the duration of an
 OpenVPN session.
 
+When using \-\-auth\-nocache in combination with a user/password file
+and \-\-chroot or \-\-daemon, make sure to use an absolute path.
+
 This directive does not affect the
 .B \-\-http\-proxy
 username/password.  It is always cached.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 87c2211..67caec7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2242,6 +2242,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.tmp_dir = options->tmp_dir;
   if (options->ccd_exclusive)
     to.client_config_dir_exclusive = options->client_config_dir;
+  to.auth_user_pass_file = options->auth_user_pass_file;
 #endif
 
 #ifdef ENABLE_X509_TRACK
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4ef715a..bc17fd0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1921,9 +1921,9 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
   if (auth_user_pass_enabled)
     {
 #ifdef ENABLE_CLIENT_CR
-      auth_user_pass_setup (NULL, session->opt->sci);
+      auth_user_pass_setup (session->opt->auth_user_pass_file, session->opt->sci);
 #else
-      auth_user_pass_setup (NULL, NULL);
+      auth_user_pass_setup (session->opt->auth_user_pass_file, NULL);
 #endif
       if (!write_string (buf, auth_user_pass.username, -1))
 	goto error;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index bb1c1c2..95cd2f7 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -277,6 +277,7 @@ struct tls_options
   const char *auth_user_pass_verify_script;
   bool auth_user_pass_verify_script_via_file;
   const char *tmp_dir;
+  const char *auth_user_pass_file;
 
   /* use the client-config-dir as a positive authenticator */
   const char *client_config_dir_exclusive;
-- 
2.1.4


