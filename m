From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 19 Jun 2017 11:28:40 +0200
Message-ID: <1497864520-12219-6-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
References: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5] Fix potential double-free in
 --x509-alt-username (CVE-2017-7521)
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

We didn't check the return value of ASN1_STRING_to_UTF8() in
extract_x509_extension().  Ignoring such a failure could result in buf
being free'd twice.  An error in ASN1_STRING_to_UTF8() can be caused
remotely if the peer can make the local process run out of memory.

The problem can only be triggered for configurations that use the
--x509-alt-username option with an x509 extension (i.e. the option
parameter starts with "ext:").

This issue was discovered, analysed and reported to the OpenVPN team by
Guido Vranken.

Extensive testing by Guido Vranken gives confidence that this function
is very unlikely to fail in real-world usage (using subjectAltName or
issuerAltName extensions) for other reasons than memory exhaustion.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 Changes.rst                      | 7 +++++++
 src/openvpn/ssl_verify_openssl.c | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 6fa1c0c..726e591 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -318,6 +318,13 @@ Security
   server.  That can eventuall cause the server to run out of memory, and thereby
   causing the server process to terminate. Discovered and reported to the
   OpenVPN security team by Guido Vranken.  (OpenSSL builds only.)
+- CVE-2017-7521: Fix a potential post-authentication remote code execution
+  attack on servers that use the ``--x509-alt-username`` option with an X.509
+  extension field (option argument prefixed with ``ext:``).  A client that can
+  cause a server to run out-of-memory (see above) might be able to cause the
+  server to double free, which in turn might lead to remote code execution.
+  Discovered and reported to the OpenVPN security team by Guido Vranken.
+  (OpenSSL builds only.)
 
 User-visible Changes
 --------------------
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 08451f2..f9e889f 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -156,7 +156,10 @@ extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
             switch (name->type)
             {
                 case GEN_EMAIL:
-                    ASN1_STRING_to_UTF8((unsigned char **)&buf, name->d.ia5);
+                    if (ASN1_STRING_to_UTF8((unsigned char **)&buf, name->d.ia5) < 0)
+                    {
+                        continue;
+                    }
                     if (strlen(buf) != name->d.ia5->length)
                     {
                         msg(D_TLS_ERRORS, "ASN1 ERROR: string contained terminating zero");
-- 
2.7.4



