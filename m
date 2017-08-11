From: Antonio Quartulli <a@...2181...>
Date: Fri, 11 Aug 2017 17:07:44 +0800
Message-Id: <20170811090744.31750-6-a@...2181...>
In-Reply-To: <20170811090744.31750-1-a@...2181...>
References: <20170811090744.31750-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 5/5] use NULL instead of 0 when assigning
 pointers
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/ps.c                 | 2 +-
 src/openvpn/ssl_openssl.c        | 2 +-
 src/openvpn/ssl_verify_openssl.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 45e24ded..5136a20c 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -922,7 +922,7 @@ port_share_open(const char *host,
         openvpn_close_socket(fd[1]);
 
         exit(0);
-        return 0; /* NOTREACHED */
+        return NULL; /* NOTREACHED */
     }
 
 error:
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index fa06f068..c977b9e2 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -703,7 +703,7 @@ tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio)
     for (;; )
     {
         cert = NULL;
-        if (!PEM_read_bio_X509(bio, &cert, 0, NULL)) /* takes ownership of cert */
+        if (!PEM_read_bio_X509(bio, &cert, NULL, NULL)) /* takes ownership of cert */
         {
             break;
         }
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index ea474955..2f3b10b9 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -202,8 +202,8 @@ extract_x509_field_ssl(X509_NAME *x509, const char *field_name, char *out,
 {
     int lastpos = -1;
     int tmp = -1;
-    X509_NAME_ENTRY *x509ne = 0;
-    ASN1_STRING *asn1 = 0;
+    X509_NAME_ENTRY *x509ne = NULL;
+    ASN1_STRING *asn1 = NULL;
     unsigned char *buf = NULL;
     ASN1_OBJECT *field_name_obj = OBJ_txt2obj(field_name, 0);
 
-- 
2.14.0


