MIME-Version: 1.0
Sender: jorgepeixoto@...277...
From: Jorge Luiz Silva Peixoto <jorge.peixoto@...277...>
Date: Wed, 4 Feb 2015 14:01:58 -0300
Message-ID: <CAB7qsSN2BzxzuY2hfqE59U+5dw4+wdGGOfUrXRQ4YmoMwAt4Mw@...278...>
Subject: [Openvpn-devel] [PATCH] Fix CN maximum length
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The following patch fixes CN maximum length as discussed with Steffan
Kargen at openvpn users mailing list.


Signed-off-by: Jorge Peixoto <jorgepeixoto@...277...>
---
 src/openvpn/ssl_verify.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index ad50458..73488fc 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -47,7 +47,7 @@
 #endif

 /** Maximum length of common name */
-#define TLS_USERNAME_LEN 64
+#define TLS_USERNAME_LEN 65

 /** Legal characters in an X509 name with --compat-names */
 #define X509_NAME_CHAR_CLASS
(CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_SLASH|CC_COLON|CC_EQUAL)
@@ -625,7 +625,7 @@ verify_cert(struct tls_session *session,
openvpn_x509_cert_t *cert, int cert_dep
              "limited to %d characters",
               opt->x509_username_field,
                 subject,
-                TLS_USERNAME_LEN);
+                TLS_USERNAME_LEN-1);
          goto cleanup;
        }
     }
@@ -1165,7 +1165,7 @@ verify_user_pass(struct user_pass *up, struct
tls_multi *multi,
   /* check sizing of username if it will become our common name */
   if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) &&
strlen (up->username) >= TLS_USERNAME_LEN)
     {
-      msg (D_TLS_ERRORS, "TLS Auth Error: --username-as-common name
specified and username is longer than the maximum permitted Common
Name length of %d characters", TLS_USERNAME_LEN);
+      msg (D_TLS_ERRORS, "TLS Auth Error: --username-as-common name
specified and username is longer than the maximum permitted Common
Name length of %d characters", TLS_USERNAME_LEN-1);
       s1 = OPENVPN_PLUGIN_FUNC_ERROR;
     }

-- 
1.9.1

