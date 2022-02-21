From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 21 Feb 2022 12:19:33 +0100
Message-Id: <20220221111933.1314-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc: cleanup for --data-ciphers and related
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
- Explain what NCP means before using it.
- Also replace some of the usages of NCP
  with the clearer "cipher negotiation".

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/protocol-options.rst | 34 +++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 1c6b1200..4af65983 100644
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
@@ -191,7 +191,8 @@ configured in a compatible way between both the local and remote side.
 
   For servers, the first cipher from ``cipher-list`` that is also
   supported by the client will be pushed to clients that support cipher
-  negotiation.
+  negotiation. (That feature is also called ``Negotiable crypto parameters``
+  or ``NCP`` for short).
 
   Starting with OpenVPN 2.6 a cipher can be prefixed with a :code:`?` to mark
   it as optional. This allows including ciphers in the list that may not be
@@ -201,25 +202,25 @@ configured in a compatible way between both the local and remote side.
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
+  Additionally, to allow for more smooth transition, if ciper negotiation is enabled,
   OpenVPN will inherit the cipher of the peer if that cipher is different
   from the local ``--cipher`` setting, but the peer cipher is one of the
   ciphers specified in ``--data-ciphers``. E.g. a non-NCP client (<=v2.3,
-  or with --ncp-disabled set) connecting to a NCP server (v2.4+) with
+  or 2.4/2.5 with ``--ncp-disabled`` set) connecting to a NCP server (v2.4+) with
   ``--cipher BF-CBC`` and ``--data-ciphers AES-256-GCM:AES-256-CBC`` set can
   either specify ``--cipher BF-CBC`` or ``--cipher AES-256-CBC`` and both
   will work.
 
-  Note for using NCP with an OpenVPN 2.4 peer: This list must include the
-  :code:`AES-256-GCM` and :code:`AES-128-GCM` ciphers.
+  Note for using cipher negoatiation with an OpenVPN 2.4 peer: This list must
+  include the :code:`AES-256-GCM` and :code:`AES-128-GCM` ciphers.
 
   This list is restricted to be 127 chars long after conversion to OpenVPN
   ciphers.
@@ -228,14 +229,13 @@ configured in a compatible way between both the local and remote side.
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
-- 
2.30.2


