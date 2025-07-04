From: =?UTF-8?q?Christian=20Sch=C3=BCrmann?= <spike@...1385...>
Date: Fri,  4 Jul 2025 10:28:14 +0200
Message-ID: <20250704082813.99654-2-spike@...1385...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Replace deprecated OpenSSL.crypto.load_crl
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

OpenSSL.crypto.load_crl was deprecated with with pyOpenSSL 23.3.0 and
eventually removed in 24.3.0. pyOpenSSL recommends using cryptography.x509's
CRL functions as a replacement.
See also: https://github.com/pyca/pyopenssl/blob/main/CHANGELOG.rst

Signed-off-by: Christian Schürmann <spike@...1385...>
---
 contrib/extract-crl/extractcrl.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/extract-crl/extractcrl.py b/contrib/extract-crl/extractcrl.py
index 441464e..c387ea1 100755
--- a/contrib/extract-crl/extractcrl.py
+++ b/contrib/extract-crl/extractcrl.py
@@ -42,17 +42,17 @@ def measure_time(method):
 def load_crl(filename, format):
 
     def try_openssl_module(filename, format):
-        from OpenSSL import crypto
-        types = {
-            FILETYPE_PEM: crypto.FILETYPE_PEM,
-            FILETYPE_DER: crypto.FILETYPE_ASN1
+        from cryptography import x509
+        load_crl_functions = {
+            FILETYPE_PEM: x509.load_pem_x509_crl,
+            FILETYPE_DER: x509.load_der_x509_crl
         }
         if filename == '-':
-            crl = crypto.load_crl(types[format], sys.stdin.buffer.read())
+            crl = load_crl_functions[format](sys.stdin.buffer.read())
         else:
             with open(filename, 'rb') as f:
-                crl = crypto.load_crl(types[format], f.read())
-        return set(int(r.get_serial(), 16) for r in crl.get_revoked())
+                crl = load_crl_functions[format](f.read())
+        return set(r.serial_number for r in crl)
 
     def try_openssl_exec(filename, format):
         args = ['openssl', 'crl', '-inform', format, '-text']
-- 
2.50.0


