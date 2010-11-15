From: David Sommerseth <dazo@...384...>
Date: Mon, 15 Nov 2010 09:05:44 +0100
Message-Id: <1289808348-17463-4-git-send-email-dazo@...384...>
In-Reply-To: <1289808348-17463-1-git-send-email-dazo@...384...>
References: <1289808348-17463-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 2/6] Fix compiler warnings about not used
	dummy() functions
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
Cc: David Sommerseth <dazo@...384...>

It has been reported that the Microsoft Visual C compiler complains if
a .c file do not contain any compilable code, which can happen if the
code has been #ifdef'ed out.  To avoid this, these #ifdef sections have
a #else section which adds a static dummy() function which does nothing.

On the other hand, the GNU C compiler complains about unused functions when
it discovers this situation.

This patch tries to only add these dummy() functions if the Microsoft Visual C
compiler is detected, via the _MSC_VER macro.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 cryptoapi.c |    2 ++
 ieproxy.c   |    3 ++-
 perf.c      |    2 ++
 pkcs11.c    |    2 ++
 4 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/cryptoapi.c b/cryptoapi.c
index 8fb5387..3365cd7 100644
--- a/cryptoapi.c
+++ b/cryptoapi.c
@@ -470,5 +470,7 @@ int SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
 }
 
 #else
+#ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
 static void dummy (void) {}
+#endif
 #endif				/* WIN32 */
diff --git a/ieproxy.c b/ieproxy.c
index 89977a8..3099870 100644
--- a/ieproxy.c
+++ b/ieproxy.c
@@ -139,7 +139,8 @@ LPCTSTR getIeHttpProxy()
     return(NULL);
   }
 }
-
 #else
+#ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
 static void dummy (void) {}
+#endif
 #endif				/* WIN32 */
diff --git a/perf.c b/perf.c
index a149c07..67ea958 100644
--- a/perf.c
+++ b/perf.c
@@ -287,5 +287,7 @@ perf_print_state (int lev)
 }
 
 #else
+#ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
 static void dummy(void) {}
 #endif
+#endif
diff --git a/pkcs11.c b/pkcs11.c
index e06a2ed..d90ac96 100644
--- a/pkcs11.c
+++ b/pkcs11.c
@@ -982,5 +982,7 @@ cleanup:
 }
 
 #else
+#ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
 static void dummy (void) {}
+#endif
 #endif /* ENABLE_PKCS11 */
-- 
1.7.2.3


