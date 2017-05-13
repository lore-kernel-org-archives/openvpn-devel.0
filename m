MIME-Version: 1.0
From: Guido Vranken <guidovranken@...277...>
Date: Sat, 13 May 2017 12:37:50 +0200
Message-ID: <CAO5O-EKGgpYAsJC5j+osB_LAteoUDbOwVYVqkB2=cA3a6VVHoA@...278...>
Subject: [Openvpn-devel] [PATCH] Avoid a 1 byte overcopy in x509_get_subject
	(ssl_verify_openssl.c)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Guido Vranken <guidovranken@...277...>
---
 src/openvpn/ssl_verify_openssl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 8374783..d64f83c 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -285,11 +285,11 @@ x509_get_subject (X509 *cert, struct gc_arena *gc)

   BIO_get_mem_ptr (subject_bio, &subject_mem);

-  maxlen = subject_mem->length + 1;
-  subject = gc_malloc (maxlen, false, gc);
+  maxlen = subject_mem->length;
+  subject = gc_malloc (maxlen+1, false, gc);

   memcpy (subject, subject_mem->data, maxlen);
-  subject[maxlen - 1] = '\0';
+  subject[maxlen] = '\0';

 err:
   if (subject_bio)
-- 
2.1.4

