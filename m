From: Arne Schwabe <arne@...1227...>
Date: Thu, 23 Aug 2012 23:21:00 +0200
Message-Id: <1345756860-2044-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Document the inlining of files in openvpn
	and document key-direction
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

This patch documents the usage of inline files in OpenVPN. Hackish ways of inline files are deliberately left out. For tls-auth and
secret the key-direction option is right way of specifying the direction and not by using two tls-auth/secret lines where the first sets the direction and has a dummy file name and the second sets the inline file data but does not reset the direction parameter.

Also pkcs12 [[INLINE]] base64encoded_data works but is a quirk of how the config parser works

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8 |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a821b5e..49348e4 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3615,6 +3615,14 @@ would see nothing
 but random-looking data.
 .\"*********************************************************
 .TP
+.B \-\-key-direction
+Alternative way of specifying the optional direction parameter for the
+.B \-\-tls-auth
+and
+.B \-\-secret
+options. Useful when using inline files (See section on inline files).
+.\"*********************************************************
+.TP
 .B \-\-auth alg
 Authenticate packets with HMAC using message
 digest algorithm
@@ -5895,6 +5903,37 @@ X509_1_C=KG
 .ft
 .fi
 .\"*********************************************************
+.SH INLINE FILE SUPPORT
+OpenVPN allows including files in the main configuration for the 
+.B \-\-ca, \-\-cert, \-\-dh, \-\-extra-certs, \-\-key, \-\-pkcs12, \-\-secret
+and
+.B \-\-tls-auth 
+options. 
+
+Each inline file started by the line 
+.B <option>
+and ended by the line
+.B </option>
+
+Here is an example of an inline file usage
+
+.nf
+.ft 3
+.in +4
+<cert>
+-----BEGIN CERTIFICATE-----
+[...]
+-----END CERTIFICATE-----
+</cert>
+.in -4
+.ft
+.fi
+
+When using the inline file feature with 
+.B \-\-pkcs12 
+the inline file has to be base64 encoded. Encoding of a .p12 file into base64 can be done for example with OpenSSL by running
+.B openssl base64 -in input.p12 
+
 .SH SIGNALS
 .TP
 .B SIGHUP
-- 
1.7.9.5


