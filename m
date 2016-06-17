From: Arne Schwabe <arne@...1227...>
Date: Fri, 17 Jun 2016 14:49:46 +0200
Message-Id: <1466167786-13748-1-git-send-email-arne@...1227...>
In-Reply-To: <56D959C9.8050802@...1227...>
References: <56D959C9.8050802@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Add documentation for
	http-proxy-user-pass option
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

Patch V2: fix formatting problems
---
 Changes.rst   | 4 ++++
 doc/openvpn.8 | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index ab322e2..f945ad7 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -51,6 +51,10 @@ AEAD (GCM) data channel cipher support
     bytes per packet for AES-128-GCM instead of 36 bytes per packet for
     AES-128-CBC + HMAC-SHA1).
 
+Http proxy password inside config file
+	Http proxy passwords can be specified with the inline file option
+    http-proxy-user-pass
+
 
 User-visible Changes
 --------------------
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f1a4361..6e8a6c1 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -497,7 +497,10 @@ and port
 If HTTP Proxy-Authenticate is required,
 .B authfile
 is a file containing a username and password on 2 lines, or
-"stdin" to prompt from console.
+"stdin" to prompt from console. Its content can also be specified
+in the config file with the
+.B \-\-http\-proxy\-user\-pass 
+option. (See section on inline files)
 
 .B auth\-method
 should be one of "none", "basic", or "ntlm".
@@ -6581,7 +6584,7 @@ X509_1_C=KG
 .SH INLINE FILE SUPPORT
 OpenVPN allows including files in the main configuration for the
 .B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-secret,
-.B \-\-crl-verify
+.B \-\-crl-verify,\-\-http\-proxy\-user\-pass
 and
 .B \-\-tls\-auth
 options.
-- 
2.7.4 (Apple Git-66)


