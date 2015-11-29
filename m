From: Arne Schwabe <arne@...1227...>
Date: Sun, 29 Nov 2015 15:55:59 +0100
Message-Id: <1448808959-10565-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove --enable-password-save option
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

This options is enabled in virtually all distributions and gives no real security benefit.
---
 configure.ac       | 8 --------
 src/openvpn/misc.c | 8 --------
 src/openvpn/misc.h | 2 +-
 src/openvpn/ssl.c  | 8 ++++----
 4 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/configure.ac b/configure.ac
index a8675fe..721395d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -170,13 +170,6 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(
-	[password-save],
-	[AS_HELP_STRING([--enable-password-save], [allow --askpass and --auth-user-pass passwords to be read from a file @<:@default=no@:>@])],
-	,
-	[enable_password_save="no"]
-)
-
-AC_ARG_ENABLE(
 	[iproute2],
 	[AS_HELP_STRING([--enable-iproute2], [enable support for iproute2 @<:@default=no@:>@])],
 	,
@@ -1054,7 +1047,6 @@ test "${enable_port_share}" = "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enab
 test "${enable_def_auth}" = "yes" && AC_DEFINE([ENABLE_DEF_AUTH], [1], [Enable deferred authentication])
 test "${enable_pf}" = "yes" && AC_DEFINE([ENABLE_PF], [1], [Enable internal packet filter])
 test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
-test "${enable_password_save}" = "yes" && AC_DEFINE([ENABLE_PASSWORD_SAVE], [1], [Allow --askpass and --auth-user-pass passwords to be read from a file])
 
 case "${with_crypto_library}" in
 	openssl)
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 31815cb..5713d2e 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1110,14 +1110,6 @@ get_user_pass_cr (struct user_pass *up,
 
           if (fgets (password_buf, USER_PASS_LEN, fp) != NULL)
             {
-#ifndef ENABLE_PASSWORD_SAVE
-              /*
-               * Unless ENABLE_PASSWORD_SAVE is defined, don't allow sensitive passwords
-               * to be read from a file.
-               */
-              if (flags & GET_USER_PASS_SENSITIVE)
-                msg (M_FATAL, "Sorry, '%s' password cannot be read from a file", prefix);
-#endif
               chomp (password_buf);
             }
 
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index be93daa..dbe899e 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -242,7 +242,7 @@ struct static_challenge_info {};
  * Flags for get_user_pass and management_query_user_pass
  */
 #define GET_USER_PASS_MANAGEMENT    (1<<0)
-#define GET_USER_PASS_SENSITIVE     (1<<1)
+/* GET_USER_PASS_SENSITIVE     (1<<1)  not used anymore */
 #define GET_USER_PASS_PASSWORD_ONLY (1<<2)
 #define GET_USER_PASS_NEED_OK       (1<<3)
 #define GET_USER_PASS_NOFATAL       (1<<4)
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 817bc49..887bd75 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -332,7 +332,7 @@ void
 pem_password_setup (const char *auth_file)
 {
   if (!strlen (passbuf.password))
-    get_user_pass (&passbuf, auth_file, UP_TYPE_PRIVATE_KEY, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_PASSWORD_ONLY);
+    get_user_pass (&passbuf, auth_file, UP_TYPE_PRIVATE_KEY, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY);
 }
 
 int
@@ -375,11 +375,11 @@ auth_user_pass_setup (const char *auth_file, const struct static_challenge_info
        get_user_pass_cr (&auth_user_pass,
                          auth_file,
                          UP_TYPE_AUTH,
-                         GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_DYNAMIC_CHALLENGE,
+                         GET_USER_PASS_MANAGEMENT|GET_USER_PASS_DYNAMIC_CHALLENGE,
                          auth_challenge);
       else if (sci) /* static challenge response */
        {
-         int flags = GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_STATIC_CHALLENGE;
+         int flags = GET_USER_PASS_MANAGEMENT|GET_USER_PASS_STATIC_CHALLENGE;
          if (sci->flags & SC_ECHO)
            flags |= GET_USER_PASS_STATIC_CHALLENGE_ECHO;
          get_user_pass_cr (&auth_user_pass,
@@ -390,7 +390,7 @@ auth_user_pass_setup (const char *auth_file, const struct static_challenge_info
        }
       else
 # endif
-       get_user_pass (&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE);
+       get_user_pass (&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT);
 #endif
     }
 }
-- 
2.4.9 (Apple Git-60)


