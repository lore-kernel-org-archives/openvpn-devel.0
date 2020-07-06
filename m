From: Richard Bonhomme <tincanteksup@...277...>
Date: Mon,  6 Jul 2020 16:32:05 +0100
Message-Id: <20200706153205.27957-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [Patch] New man page corrections - tls-options.rst
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

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 doc/man-sections/tls-options.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index bb8fc986..21549bdb 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -81,7 +81,7 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   ``openssl crl`` and ``X509_LOOKUP_hash_dir()``\(3)
   for more information.
 
-  Similarly to the ``--crl-verify`` option CRLs are not mandatory -
+  Similar to the ``--crl-verify`` option, CRLs are not mandatory -
   OpenVPN will log the usual warning in the logs if the relevant CRL is
   missing, but the connection will be allowed.
 
@@ -491,7 +491,7 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   Exit on TLS negotiation failure.
 
 --tls-export-cert directory
-  Store the certificates the clients uses upon connection to this
+  Store the certificates the clients use upon connection to this
   directory. This will be done before ``--tls-verify`` is called. The
   certificates will use a temporary name and will be deleted when the
   tls-verify script returns. The file name used for the certificate is
-- 
2.17.1


