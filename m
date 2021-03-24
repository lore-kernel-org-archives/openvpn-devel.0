From: Arne Schwabe <arne@...1227...>
Date: Thu, 25 Mar 2021 00:51:50 +0100
Message-Id: <20210324235151.9384-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/2] Deprecate non TLS mode in OpenVPN
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

The non-TLS mode is a relict from OpenVPN 1.x or 2.0. When tls mode was
introduce the advantages of TLS over non-tls were small but tls mode
evolved to include a lot more features. (NCP, multipeer, AEAD ciphers to name
a few).

Today VPN that use --secret are mainly used because of its relative easy to
setup and requiring to setup a PKI. This shortcoming of TLS mode should be
addressed now with the peer-fingerprint option.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/protocol-options.rst |  2 +-
 src/openvpn/options.c                 | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 01789e58..4b6928c6 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -235,7 +235,7 @@ configured in a compatible way between both the local and remote side.
   disables cipher negotiation.
 
 --secret args
-  Enable Static Key encryption mode (non-TLS). Use pre-shared secret
+  **DEPRECATED** Enable Static Key encryption mode (non-TLS). Use pre-shared secret
   ``file`` which was generated with ``--genkey``.
 
   Valid syntaxes:
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e52679f0..5b559edf 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -514,7 +514,7 @@ static const char usage_message[] =
     "\n"
     "Data Channel Encryption Options (must be compatible between peers):\n"
     "(These options are meaningful for both Static Key & TLS-mode)\n"
-    "--secret f [d]  : Enable Static Key encryption mode (non-TLS).\n"
+    "--secret f [d]  : (DEPRECATED) Enable Static Key encryption mode (non-TLS).\n"
     "                  Use shared secret file f, generate with --genkey.\n"
     "                  The optional d parameter controls key directionality.\n"
     "                  If d is specified, use separate keys for each\n"
@@ -2564,6 +2564,15 @@ options_postprocess_verify_ce(const struct options *options,
         msg(M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
     }
 
+    if (!options->tls_server || !options->tls_client)
+    {
+        msg(M_INFO, "DEPRECATION: No tls-client or tls-server option in "
+                    "configuration detected. OpenVPN 2.7 will remove the "
+                    "functionality to run a VPN without TLS. "
+                    "See the examples section in the manual page for "
+                    "examples of a similar quick setup with peer-fingerprint.");
+    }
+
     if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))
     {
         msg(M_WARN, "WARNING: POTENTIALLY DANGEROUS OPTION "
@@ -7868,6 +7877,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "secret") && p[1] && !p[3])
     {
+        msg(M_WARN, "DEPRECATED OPTION: The option --secret is deprecated. ");
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         options->shared_secret_file = p[1];
         options->shared_secret_file_inline = is_inline;
-- 
2.30.1


