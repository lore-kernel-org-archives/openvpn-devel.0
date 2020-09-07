From: Arne Schwabe <arne@...1227...>
Date: Mon,  7 Sep 2020 18:18:49 +0200
Message-Id: <20200907161849.20508-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Ignore --cipher for cipher negotiation in
 server client mode
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

OpenVPN will ignore --cipher in lieu of the replacement data-ciphers
for cipher negioation.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/protocol-options.rst |  6 ++++--
 src/openvpn/options.c                 | 26 ++++----------------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index e9d5d63d..ca1407b9 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -57,8 +57,10 @@ configured in a compatible way between both the local and remote side.
   http://www.cs.ucsd.edu/users/mihir/papers/hmac.html
 
 --cipher alg
-  This option is deprecated for server-client mode. ``--data-ciphers``
-  or possibly `--data-ciphers-fallback`` should be used instead.
+  This option is ignored for server-client mode cipher selection.
+  ``--data-ciphers`` or possibly ``--data-ciphers-fallback`` must be used
+  instead.  It only determines which cipher is send in the
+  OCC string (see ``opt-verify``) for compatbility with old peers.
 
   Encrypt data channel packets with cipher algorithm ``alg``.
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 01da88ad..7dc3e3eb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3074,12 +3074,6 @@ options_postprocess_cipher(struct options *o)
                          "--data-ciphers-fallback config option");
         }
 
-        msg(M_WARN, "--cipher is not set. Previous OpenVPN version defaulted to "
-            "BF-CBC as fallback when cipher negotiation failed in this case. "
-            "If you need this fallback please add '--data-ciphers-fallback "
-            "BF-CBC' to your configuration and/or add BF-CBC to "
-            "--data-ciphers.");
-
         /* We still need to set the ciphername to BF-CBC since various other
          * parts of OpenVPN assert that the ciphername is set */
         o->ciphername = "BF-CBC";
@@ -3087,22 +3081,10 @@ options_postprocess_cipher(struct options *o)
     else if (!o->enable_ncp_fallback
              && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
     {
-        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing in"
-            " --data-ciphers (%s). Future OpenVPN version will "
-            "ignore --cipher for cipher negotiations. "
-            "Add '%s' to --data-ciphers or change --cipher '%s' to "
-            "--data-ciphers-fallback '%s' to silence this warning.",
-            o->ciphername, o->ncp_ciphers, o->ciphername,
-            o->ciphername, o->ciphername);
-        o->enable_ncp_fallback = true;
-
-        /* Append the --cipher to ncp_ciphers to allow it in NCP */
-        size_t newlen = strlen(o->ncp_ciphers) + 1 + strlen(o->ciphername) + 1;
-        char *ncp_ciphers = gc_malloc(newlen, false, &o->gc);
-
-        ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
-                                o->ciphername));
-        o->ncp_ciphers = ncp_ciphers;
+        msg(M_WARN, "Note: --cipher set to '%s' but missing in"
+            " --data-ciphers (%s). OpenVPN 2.6+ ignores --cipher for "
+            "cipher negiotiation.",
+            o->ciphername, o->ncp_ciphers);
     }
 }
 
-- 
2.26.2


