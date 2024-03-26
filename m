From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 26 Mar 2024 11:41:01 +0100
Message-Id: <20240326104101.531291-1-frank@...2641...>
In-Reply-To: <gerrit.1711389887000.If23988a05dd53a519c5e57f2aa3b2d10bd29df1d@...2715...>
References: <gerrit.1711389887000.If23988a05dd53a519c5e57f2aa3b2d10bd29df1d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix snprintf/swnprintf related compiler
 warnings
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

When openvpn_snprintf is replaced by snprintf the GCC/MSVC compiler
will perform additional checks that the result is not truncated.

This warning can be avoid by either explicitly checking the return value
of snprintf (proxy) or ensuring that it is never truncated(tls crypt)

Change-Id: If23988a05dd53a519c5e57f2aa3b2d10bd29df1d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/549
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

Note: Missing word in commit message added for submission.

        
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index c904301..5c1cdcb 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -948,17 +948,21 @@
                 }
 
                 /* send digest response */
-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Authorization: Digest username=\"%s\", realm=\"%s\", nonce=\"%s\", uri=\"%s\", qop=%s, nc=%s, cnonce=\"%s\", response=\"%s\"%s",
-                                 username,
-                                 realm,
-                                 nonce,
-                                 uri,
-                                 qop,
-                                 nonce_count,
-                                 cnonce,
-                                 response,
-                                 opaque_kv
-                                 );
+                int sret = openvpn_snprintf(buf, sizeof(buf), "Proxy-Authorization: Digest username=\"%s\", realm=\"%s\", nonce=\"%s\", uri=\"%s\", qop=%s, nc=%s, cnonce=\"%s\", response=\"%s\"%s",
+                                            username,
+                                            realm,
+                                            nonce,
+                                            uri,
+                                            qop,
+                                            nonce_count,
+                                            cnonce,
+                                            response,
+                                            opaque_kv
+                                            );
+                if (sret >= sizeof(buf))
+                {
+                    goto error;
+                }
                 msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
                 if (!send_line_crlf(sd, buf))
                 {
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index d842666..b046910 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -109,8 +109,11 @@
             "Authentication not possible.");
         goto cleanup;
     }
-    openvpn_snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s", (int) strlen(creds.username),
-                     creds.username, (int) strlen(creds.password), creds.password);
+    int sret = openvpn_snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s",
+                                (int) strlen(creds.username), creds.username,
+                                (int) strlen(creds.password), creds.password);
+    ASSERT(sret <= sizeof(to_send));
+
     size = send(sd, to_send, strlen(to_send), MSG_NOSIGNAL);
 
     if (size != strlen(to_send))
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 4383e98..6f29c3d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2069,7 +2069,7 @@
 #endif
 
 #ifndef OPENSSL_NO_EC
-    char groupname[256];
+    char groupname[64];
     if (is_ec)
     {
         size_t len;
@@ -2130,7 +2130,7 @@
 print_cert_details(X509 *cert, char *buf, size_t buflen)
 {
     EVP_PKEY *pkey = X509_get_pubkey(cert);
-    char pkeybuf[128] = { 0 };
+    char pkeybuf[64] = { 0 };
     print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));
 
     char sig[128] = { 0 };
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 975d31f..6ef1c7d 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -575,7 +575,7 @@
 
     char metadata_type_str[4] = { 0 }; /* Max value: 255 */
     openvpn_snprintf(metadata_type_str, sizeof(metadata_type_str),
-                     "%i", metadata_type);
+                     "%i", (uint8_t) metadata_type);
     struct env_set *es = env_set_create(NULL);
     setenv_str(es, "script_type", "tls-crypt-v2-verify");
     setenv_str(es, "metadata_type", metadata_type_str);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 452633c..d32223c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -33,6 +33,7 @@
 #include <sddl.h>
 #include <shellapi.h>
 #include <mstcpip.h>
+#include <inttypes.h>
 
 #include <versionhelpers.h>
 
@@ -2002,7 +2003,7 @@
         ReturnLastError(pipe, L"malloc");
         goto out;
     }
-    openvpn_swprintf(cmdline, cmdline_size, L"openvpn %ls --msg-channel %lu",
+    openvpn_swprintf(cmdline, cmdline_size, L"openvpn %ls --msg-channel %" PRIuPTR,
                      sud.options, svc_pipe);
 
     if (!CreateEnvironmentBlock(&user_env, imp_token, FALSE))

