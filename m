From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 22 Feb 2022 13:14:39 +0100
Message-Id: <20220222121439.1260-1-frank@...2641...>
In-Reply-To: <20220221111933.1314-1-frank@...2641...>
References: <20220221111933.1314-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] doc: cleanup for --data-ciphers and
 related
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

- Fix various formatting inconsistencies
- Remove outdated (as of 2.6) information from
  --data-ciphers and instead add a link to
  cipher negotiation chapter.
- Some drive-by fixes in related code comments
  and log messages as I was reading them.

Cc: Arne Schwabe <arne@...1227...>
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/cipher-negotiation.rst |  8 ++---
 doc/man-sections/protocol-options.rst   | 40 +++++++++++--------------
 src/openvpn/options.c                   | 16 +++++-----
 3 files changed, 29 insertions(+), 35 deletions(-)

v2:
 - rip out outdated documentation from --data-cipers
 - add link to cipher negotiations documentation instead
 - some comment and message fixes in the code as I was
   going through it to understand it.
 - avoid any mention of NCP except as the names of the old
   options. Removed explanation of what NCP stands for again
   as should now not be required anymore.


diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
index 9bcaed0a..fad07480 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -34,7 +34,7 @@ mode and does not have ``--ncp-disable`` will always announce support for
 
 This only causes a problem if ``--ncp-ciphers`` option has been changed from the
 default of :code:`AES-256-GCM:AES-128-GCM` to a value that does not include
-these two ciphers. When a OpenVPN servers try to use `AES-256-GCM` or
+these two ciphers. When a OpenVPN server tries to use `AES-256-GCM` or
 `AES-128-GCM` the connection will then fail. It is therefore recommended to
 always have the `AES-256-GCM` and `AES-128-GCM` ciphers to the ``--ncp-ciphers``
 options to avoid this behaviour.
@@ -84,15 +84,15 @@ support.
 
 If the server is 2.3 or older and  has been configured with the
 ``--enable-small`` :code:`./configure` argument, adding
-``data-ciphers-fallback cipher`` to the client config with the explicit
+``--data-ciphers-fallback cipher`` to the client config with the explicit
 cipher used by the server is necessary.
 
 Blowfish in CBC mode (BF-CBC) deprecation
 ------------------------------------------
-The ``--cipher`` option defaulted to ``BF-CBC`` in OpenVPN 2.4 and older
+The ``--cipher`` option defaulted to `BF-CBC` in OpenVPN 2.4 and older
 version. The default was never changed to ensure backwards compatibility.
 In OpenVPN 2.5 this behaviour has now been changed so that if the ``--cipher``
-is not explicitly set it does not allow the weak ``BF-CBC`` cipher any more
+is not explicitly set it does not allow the weak `BF-CBC` cipher any more
 and needs to explicitly added as ``--cipher BFC-CBC`` or added to
 ``--data-ciphers``.
 
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 1c6b1200..d52da185 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -73,7 +73,7 @@ configured in a compatible way between both the local and remote side.
   Starting with 2.6.0, this option is always ignored in TLS mode
   when it comes to configuring the cipher and will only control the
   cipher for ``--secret`` pre-shared-key mode (note: this mode is
-  deprecated strictly not recommended).
+  deprecated and strictly not recommended).
 
   If you wish to specify the cipher to use on the data channel,
   please see ``--data-ciphers`` (for regular negotiation) and
@@ -87,8 +87,8 @@ configured in a compatible way between both the local and remote side.
   Set ``alg`` to :code:`none` to disable encryption.
 
 --compress algorithm
-  **DEPRECATED** Enable a compression algorithm.  Compression is generally
-  not recommended.  VPN tunnels which use compression are susceptible to
+  **DEPRECATED** Enable a compression algorithm. Compression is generally
+  not recommended. VPN tunnels which use compression are susceptible to
   the VORALCE attack vector. See also the :code:`migrate` parameter below.
 
   The ``algorithm`` parameter may be :code:`lzo`, :code:`lz4`,
@@ -193,6 +193,10 @@ configured in a compatible way between both the local and remote side.
   supported by the client will be pushed to clients that support cipher
   negotiation.
 
+  For more details see the chapter on `Data channel cipher negotiation`_.
+  *Especially* if you need to support clients with OpenVPN versions older
+  than 2.5!
+
   Starting with OpenVPN 2.6 a cipher can be prefixed with a :code:`?` to mark
   it as optional. This allows including ciphers in the list that may not be
   available on all platforms.
@@ -201,25 +205,16 @@ configured in a compatible way between both the local and remote side.
   supports it.
 
   Cipher negotiation is enabled in client-server mode only. I.e. if
-  ``--mode`` is set to 'server' (server-side, implied by setting
+  ``--mode`` is set to `server` (server-side, implied by setting
   ``--server`` ), or if ``--pull`` is specified (client-side, implied by
-  setting --client).
+  setting ``--client``).
 
   If no common cipher is found during cipher negotiation, the connection
   is terminated. To support old clients/old servers that do not provide any
   cipher negotiation support see ``--data-ciphers-fallback``.
 
-  Additionally, to allow for more smooth transition, if NCP is enabled,
-  OpenVPN will inherit the cipher of the peer if that cipher is different
-  from the local ``--cipher`` setting, but the peer cipher is one of the
-  ciphers specified in ``--data-ciphers``. E.g. a non-NCP client (<=v2.3,
-  or with --ncp-disabled set) connecting to a NCP server (v2.4+) with
-  ``--cipher BF-CBC`` and ``--data-ciphers AES-256-GCM:AES-256-CBC`` set can
-  either specify ``--cipher BF-CBC`` or ``--cipher AES-256-CBC`` and both
-  will work.
-
-  Note for using NCP with an OpenVPN 2.4 peer: This list must include the
-  :code:`AES-256-GCM` and :code:`AES-128-GCM` ciphers.
+  If ``--compat-mode`` is set to a version older than 2.5.0 ``--cipher``
+  will be appended to ``--data-ciphers`` if not already present.
 
   This list is restricted to be 127 chars long after conversion to OpenVPN
   ciphers.
@@ -228,14 +223,13 @@ configured in a compatible way between both the local and remote side.
   to ``--data-ciphers`` in OpenVPN 2.5 to more accurately reflect its meaning.
 
 --data-ciphers-fallback alg
+  Configure a cipher that is used to fall back to if we could not determine
+  which cipher the peer is willing to use.
 
-    Configure a cipher that is used to fall back to if we could not determine
-    which cipher the peer is willing to use.
-
-    This option should only be needed to
-    connect to peers that are running OpenVPN 2.3 and older version, and
-    have been configured with `--enable-small`
-    (typically used on routers or other embedded devices).
+  This option should only be needed to
+  connect to peers that are running OpenVPN 2.3 or older versions, and
+  have been configured with ``--enable-small``
+  (typically used on routers or other embedded devices).
 
 --secret args
   **DEPRECATED** Enable Static Key encryption mode (non-TLS). Use pre-shared secret
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7ce0ba61..075aad65 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3141,7 +3141,7 @@ options_postprocess_cipher(struct options *o)
         msg(M_INFO, "Note: --cipher is not set. OpenVPN versions before 2.5 "
                     "defaulted to BF-CBC as fallback when cipher negotiation "
                     "failed in this case. If you need this fallback please add "
-                    "'--data-ciphers-fallback 'BF-CBC' to your configuration "
+                    "'--data-ciphers-fallback BF-CBC' to your configuration "
                     "and/or add BF-CBC to --data-ciphers.");
     }
     else if (!o->enable_ncp_fallback
@@ -3155,13 +3155,13 @@ options_postprocess_cipher(struct options *o)
 }
 
 /**
- * The option --compat-mode is used to set up default settings to values 
+ * The option --compat-mode is used to set up default settings to values
  * used on the specified openvpn version and earlier.
  *
  * This function is used in various "default option" paths to test if the
  * user requested compatibility with a version before the one specified
- * as argument. This way some default settings can be automatically 
- * altered to guarantee compatibility with the version specified by the 
+ * as argument. This way some default settings can be automatically
+ * altered to guarantee compatibility with the version specified by the
  * user via --compat-mode.
  *
  * @param version   need compatibility with openvpn versions before the
@@ -3219,11 +3219,11 @@ options_set_backwards_compatible_options(struct options *o)
     }
 
     /* Versions < 2.5.0 do need --cipher in the list of accepted ciphers.
-     * Version 2.4 might probably does not need it but NCP was not so
+     * Version 2.4 probably does not need it but NCP was not so
      * good with 2.4 and ncp-disable might be more common on 2.4 peers.
-     * Only do this iif --cipher is not explicitly (BF-CBC). This is not
-     * 100% correct backwards compatible behaviour but 2.5 already behaved like
-     * this */
+     * Only do this if --cipher is set explicitly (or compat mode is
+     * < 2.4.0, see above). This is not 100% correct backwards compatible
+     * behaviour but 2.5 already behaved like this */
     if (o->ciphername && need_compatibility_before(o, 20500)
         && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
     {
-- 
2.30.2


