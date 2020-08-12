From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 Aug 2020 10:54:12 +0200
Message-Id: <20200812085412.19178-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Improve sections about older OpenVPN
 clients in cipher-negotiation.rst
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

 - Explain the IV_NCP=2 client situation in 2.4 a bit better.
 - Make more clear what exact versions are meant in the old client section
 - add a missing - in a heading

Thanks to Richard Bohnhomme for initial proof reading.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/cipher-negotiation.rst | 34 ++++++++++++++-----------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
index 46c9d7cf..b2c20241 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -22,14 +22,18 @@ it is automatically added to this list. If both options are unset the default is
 
 OpenVPN 2.4 clients
 -------------------
-The negotiation support in OpenVPN 2.4 was a first implementation and still had some
-quirks. Its main goal was "upgrade to AES-256-GCM when possible".
+The negotiation support in OpenVPN 2.4 was the first iteration of the implementation
+and still had some quirks. Its main goal was "upgrade to AES-256-GCM when possible".
 An OpenVPN 2.4 client that is built against a crypto library that supports AES in GCM
 mode and does not have ``--ncp-disable`` will always announce support for
-`AES-256-GCM` and `AES-128-GCM` even if the ``--ncp-ciphers`` option does not include
-those two ciphers. It is therefore recommended to add `AES-256-GCM` and `AES-128-GCM`
-to the ``--ncp-ciphers`` options to workaround this bug.
+`AES-256-GCM` and `AES-128-GCM` to a server by sending :code:`IV_NCP=2`.
 
+This only causes a problem if ``--ncp-ciphers`` option has been changed from the
+default of :code:`AES-256-GCM:AES-128-GCM` to a value that does not include
+these two ciphers. When a OpenVPN servers try to use `AES-256-GCM` or
+`AES-128-GCM` the connection will then fail. It is therefore recommended to
+always have the `AES-256-GCM` and `AES-128-GCM` ciphers to the ``--ncp-ciphers``
+options to avoid this behaviour.
 
 OpenVPN 3 clients
 -----------------
@@ -42,7 +46,7 @@ To support OpenVPN 3.x based clients at least one of these ciphers needs to be
 included in the server's ``--data-ciphers`` option.
 
 
-OpenVPN 2.3 clients and older (and clients with ``--ncp-disable``)
+OpenVPN 2.3 and older clients (and clients with ``--ncp-disable``)
 ------------------------------------------------------------------
 When a client without cipher negotiation support connects to a server the
 cipher specified with the ``--cipher`` option in the client configuration
@@ -50,10 +54,10 @@ must be included in the ``--data-ciphers`` option of the server to allow
 the client to connect. Otherwise the client will be sent the ``AUTH_FAILED``
 message that indicates no shared cipher.
 
-If the client has been configured with the ``--enable-small``
-:code:``./configure`` argument, using ``data-ciphers-fallback cipher``
-in the server config file with the explicit cipher used by the client
-is necessary.
+If the client is 2.3 or older and has been configured with the
+``--enable-small``  :code:`./configure` argument, using
+``data-ciphers-fallback cipher`` in the server config file with the explicit
+cipher used by the client is necessary.
 
 OpenVPN 2.4 server
 ------------------
@@ -66,7 +70,7 @@ adding  `AES-128-GCM` and `AES-256-GCM` to the client's ``--data-ciphers``
 option is required. OpenVPN 2.5+ will only announce the ``IV_NCP=2`` flag if
 those ciphers are present.
 
-OpenVPN 2.3 and older servers (and servers with ``-ncp-disable``)
+OpenVPN 2.3 and older servers (and servers with ``--ncp-disable``)
 -----------------------------------------------------------------
 The cipher used by the server must be included in ``--data-ciphers`` to
 allow the client connecting to a server without cipher negotiation
@@ -74,10 +78,10 @@ support.
 (For compatibility OpenVPN 2.5 will also accept the cipher set with
 ``--cipher``)
 
-If the server has been configured with the ``--enable-small``
-:code:``./configure` argument, adding ``data-ciphers-fallback cipher``
-to the client config with the explicit cipher used by the server
-is necessary.
+If the server is 2.3 or older and  has been configured with the
+``--enable-small`` :code:`./configure` argument, adding
+``data-ciphers-fallback cipher`` to the client config with the explicit
+cipher used by the server is necessary.
 
 Blowfish in CBC mode (BF-CBC) deprecation
 ------------------------------------------
-- 
2.26.2


