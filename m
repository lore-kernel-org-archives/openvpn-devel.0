From: Steffan Karger <steffan@...1856...>
Date: Mon, 14 Nov 2016 21:06:07 +0100
Message-Id: <1479153967-6788-1-git-send-email-steffan@...1856...>
In-Reply-To: <1479153490-6259-1-git-send-email-steffan@...1856...>
References: <1479153490-6259-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2] Deprecate key-method 1
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

Key method 2 has been the default since OpenVPN 2.0, and is both more
functional and secure.  Also, key method 1 was only ever supported for
peer-to-peer connections (i.e. not for client-server).

Let's get rid of some legacy and phase out key method 1.

v2: add Changes.rst entry, and update man page

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst           | 7 +++++++
 doc/openvpn.8         | 5 ++++-
 src/openvpn/options.c | 6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index c1b49c7..17d8edb 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -112,6 +112,13 @@ AIX platform support
     devices since AIX does not provide tun interface.
 
 
+Deprecated features
+-------------------
+- ``--key-method 1`` is deprecated in 2.4 and will be removed in 2.5.  Migrate
+  to ``--key-method 2`` as soon as possible.  Note that this requires changing
+  the option in both the client and server side configs.
+
+
 User-visible Changes
 --------------------
 - For certificate DNs with duplicate fields, e.g. "OU=one,OU=two", both fields
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 863dcf9..7227d22 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4782,7 +4782,10 @@ exchanged over the TLS session.
 
 In method 1 (the default for OpenVPN 1.x), both sides generate
 random encrypt and HMAC-send keys which are forwarded to
-the other host over the TLS channel.
+the other host over the TLS channel. Method 1 is
+.B deprecated in OpenVPN 2.4
+, and
+.B will be removed in OpenVPN 2.5\fR.
 
 In method 2, (the default for OpenVPN 2.0)
 the client generates a random key.  Both client
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1eb3a41..f39c4fa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2245,6 +2245,12 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	  "may accept clients which do not present a certificate");
     }
 
+  if (options->key_method == 1)
+    {
+      msg (M_WARN, "WARNING: --key-method 1 is deprecated and will be removed"
+	  "in OpenVPN 2.5.  Migrate to --key-method 2 as soon as possible.");
+    }
+
   if (options->tls_server || options->tls_client)
     {
 #ifdef ENABLE_PKCS11
-- 
2.7.4


