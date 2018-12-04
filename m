From: Arne Schwabe <arne@...1227...>
Date: Tue,  4 Dec 2018 17:05:02 +0100
Message-Id: <20181204160502.1089-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add tls-crypt-v2 to the list of supported
 inline options
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index eae2bd94..9d1a3fa6 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -6921,9 +6921,10 @@ X509_1_C=KG
 .SH INLINE FILE SUPPORT
 OpenVPN allows including files in the main configuration for the
 .B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-secret,
-.B \-\-crl\-verify, \-\-http\-proxy\-user\-pass, \-\-tls\-auth
+.B \-\-crl\-verify, \-\-http\-proxy\-user\-pass, \-\-tls\-auth,
+.B \-\-tls\-crypt,
 and
-.B \-\-tls\-crypt
+.B \-\-tls\-crypt-v2
 options.
 
 Each inline file started by the line
-- 
2.17.1


