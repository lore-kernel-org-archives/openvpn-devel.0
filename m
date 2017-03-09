From: Steffan Karger <steffan@...1856...>
Date: Thu,  9 Mar 2017 09:13:32 +0100
Message-Id: <1489047212-31994-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Remove duplicate X509 env variables
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

Commit 13b585e8 added support for multiple X509 env variables with the
same name, but as a side effect caused these variables to pile up for
each renegotiation.  The old code would simply overwrite the old variables
(as long as an equally-long chain was used for the new session).

To stop the variables from piling up, this commit removes any old X509
env variables if we start negotiating a new TLS session.

Trac: #854

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c        |  3 +++
 src/openvpn/ssl_verify.c | 17 +++++++++++++++++
 src/openvpn/ssl_verify.h |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 401b8fd..1189f56 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2821,6 +2821,9 @@ tls_process(struct tls_multi *multi,
                                    session->opt->crl_file, session->opt->crl_file_inline);
             }
 
+            /* New connection, remove any old X509 env variables */
+            tls_x509_clear_env(session->opt->es);
+
             dmsg(D_TLS_DEBUG_MED, "STATE S_START");
         }
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 9f12ab8..a6e9be3 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1486,4 +1486,21 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
         gc_free(&gc);
     }
 }
+
+void
+tls_x509_clear_env(struct env_set *es)
+{
+    struct env_item *item = es->list;
+    while (item)
+    {
+        struct env_item *next = item->next;
+        if (item->string
+            && 0 == strncmp("X509_", item->string, strlen("X509_")))
+        {
+            env_set_del(es, item->string);
+        }
+        item = next;
+    }
+}
+
 #endif /* ENABLE_CRYPTO */
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index ffab218..d91799e 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -238,6 +238,9 @@ tls_client_reason(struct tls_multi *multi)
 #endif
 }
 
+/** Remove any X509_ env variables from env_set es */
+void tls_x509_clear_env(struct env_set *es);
+
 #endif /* ENABLE_CRYPTO */
 
 #endif /* SSL_VERIFY_H_ */
-- 
2.7.4


