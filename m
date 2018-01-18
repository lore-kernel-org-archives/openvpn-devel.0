From: selva.nair@...277...
Date: Thu, 18 Jan 2018 13:58:36 -0500
Message-Id: <1516301916-11408-1-git-send-email-selva.nair@...277...>
In-Reply-To: <932660f8-ce6b-ab8f-f561-638f4443e2b0@...1227...>
References: <932660f8-ce6b-ab8f-f561-638f4443e2b0@...1227...>
Subject: [Openvpn-devel] [PATCH v2 3/3] Document management request >PK_SIGN
 and response pk-sig
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

From: Selva Nair <selva.nair@...277...>

v2: Commands renamed to >PK_SIGN and pk-sig

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Well, the previous version has been acked, but obviously that
patch is obsolete now.


 doc/management-notes.txt | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index a9ba18a..064e335 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -795,6 +795,43 @@ Base64 encoded output of RSA_private_encrypt() (OpenSSL) or mbedtls_pk_sign()
 This capability is intended to allow the use of arbitrary cryptographic
 service providers with OpenVPN via the management interface.
 
+COMMAND -- pk-sig (OpenVPN 2.5 or higher)
+------------------------------------------
+Provides support for external storage of the private key. Requires the
+--management-external-key option. This option can be used instead of "key"
+in client mode, and allows the client to run without the need to load the
+actual private key. When the SSL protocol needs to perform a sign
+operation, the data to be signed will be sent to the management interface
+via a notification as follows:
+
+>PK_SIGN:[BASE64_DATA]
+
+The management interface client should then create an appropriate signature of
+the (decoded) BASE64_DATA using the private key and return the SSL signature as
+follows:
+
+pk-sig
+[BASE64_SIG_LINE]
+.
+.
+.
+END
+
+RSA signatures (for RSA keys) and and ECDSA signatures (for EC keys) are
+supported. For EC keys openssl 1.1 or higher is required.
+
+Base64 encoded output of RSA_private_encrypt for RSA or ECDSA_sign() for EC
+using OpenSSL or mbedtls_pk_sign() using mbed TLS will provide a correct
+signature.
+
+This capability is intended to allow the use of arbitrary cryptographic service
+providers with OpenVPN via the management interface.
+
+Currently RSA signature is challenged for by '>RSA_SIGN', but eventually
+'>PK_SIGN' prompt will be used for all signature types. New management clients
+should be prepared to respond to '>PK_SIGN' with 'pk-sig' followed by the
+appropriate signature.
+
 COMMAND -- certificate (OpenVPN 2.4 or higher)
 ----------------------------------------------
 Provides support for external storage of the certificate. Requires the
-- 
2.1.4


