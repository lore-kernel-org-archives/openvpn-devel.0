Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Fri, 17 Feb 2017 23:00:54 +0100
Message-Id: <45dbf05cd352ff703bbbf628f04190e08198c68e.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v1 15/15] OpenSSL: constify getbio()
	parameters
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

From: Emmanuel Deloget <logout@...260...>

Although it is required by BIO_new() to have a non-const object,
this is merely an OpenSSL interface accident. Newer versions of
OpenSSL (i.e. OpenSSL 1.1) have are a bit better w.r.t. constification
and changed this.

As a result, we can safely constify the BIO_METHOD parameter of getbio()
(yet we still need to un-const the value when feeding it to BIO_new()
for the sake of compatibility).

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 src/openvpn/ssl_openssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 2ff3e12b93d6f829e4b27aefc2622d52e41ce589..46942c225d72e42760cbb9fae577c87aee553508 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1389,10 +1389,10 @@ bio_debug_oc(const char *mode, BIO *bio)
  * through "memory BIOs".
  */
 static BIO *
-getbio(BIO_METHOD *type, const char *desc)
+getbio(const BIO_METHOD *type, const char *desc)
 {
     BIO *ret;
-    ret = BIO_new(type);
+    ret = BIO_new((BIO_METHOD *)type);
     if (!ret)
     {
         crypto_msg(M_FATAL, "Error creating %s BIO", desc);
-- 
2.7.4


