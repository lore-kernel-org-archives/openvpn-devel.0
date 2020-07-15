From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:01 +0200
Message-Id: <20200715223013.11726-5-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 04/16] doc/man: Remove unsupported options
 in OpenVPN 2.5
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

This removes the options from the man page which is enlisted as
deprecated options in OpenVPN 2.5.  To provide some history, a short
summary of why they were removed has been put into a new file which is
included into its own "UNSUPPORTED OPTIONS" section in the man page.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/openvpn.8.rst           | 144 +-----------------------------------
 doc/unsupported-options.rst |  33 +++++++++
 2 files changed, 35 insertions(+), 142 deletions(-)
 create mode 100644 doc/unsupported-options.rst

diff --git a/doc/openvpn.8.rst b/doc/openvpn.8.rst
index fc3ecdb8..713cd309 100644
--- a/doc/openvpn.8.rst
+++ b/doc/openvpn.8.rst
@@ -454,9 +454,7 @@ Tunnel Options:
     the client's tun interface always points to the local endpoint of the
     server's tun interface. This mode allocates a single IP address per
     connecting client. Only use when none of the connecting clients are
-    Windows systems. This mode is functionally equivalent to the
-    ``--ifconfig-pool-linear`` directive which is available in OpenVPN 2.0,
-    is deprecated and will be removed in OpenVPN 2.5
+    Windows systems.
 
   :code:`subnet`
     Use a subnet rather than a point-to-point topology by
@@ -2184,17 +2182,6 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   receive the given IP address. If you want guaranteed assignment, use
   ``--ifconfig-push``
 
---ifconfig-pool-linear
-  **DEPRECATED** This option will be removed in OpenVPN 2.5
-
-  Modifies the ``--ifconfig-pool`` directive to allocate individual TUN
-  interface addresses for clients rather than /30 subnets.
-
-  *NOTE:*   This option is incompatible with Windows clients.
-
-  This option is deprecated, and should be replaced with ``--topology
-  p2p`` which is functionally equivalent.
-
 --ifconfig-push args
   Push virtual IP endpoints for client tunnel, overriding the
   ``--ifconfig-pool`` dynamic allocation.
@@ -2668,17 +2655,6 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   authentication module/script MUST have logic to detect this condition
   and respond accordingly.
 
---client-cert-not-required
-  **DEPRECATED** This option will be removed in OpenVPN 2.5
-
-  Don't require client certificate, client will authenticate using
-  username/password only. Be aware that using this directive is less
-  secure than requiring certificates from all clients.
-
-  **Please note:** This is replaced by ``--verify-client-cert`` which
-  allows for more flexibility. The option ``--verify-client-cert none`` is
-  functionally equivalent to ``--client-cert-not-required``
-
 --verify-client-cert mode
   Specify whether the client is required to supply a valid certificate.
 
@@ -3178,41 +3154,6 @@ These options are meaningful for both Static & TLS-negotiated key modes
   ``--show-engines`` standalone option to list the crypto engines which
   are supported by OpenSSL.
 
---no-replay
-  **DEPRECATED** This option will be removed in OpenVPN 2.5.
-
-  (Advanced) Disable OpenVPN's protection against replay attacks. Don't
-  use this option unless you are prepared to make a tradeoff of greater
-  efficiency in exchange for less security.
-
-  OpenVPN provides datagram replay protection by default.
-
-  Replay protection is accomplished by tagging each outgoing datagram with
-  an identifier that is guaranteed to be unique for the key being used.
-  The peer that receives the datagram will check for the uniqueness of the
-  identifier. If the identifier was already received in a previous
-  datagram, OpenVPN will drop the packet. Replay protection is important
-  to defeat attacks such as a SYN flood attack, where the attacker listens
-  in the wire, intercepts a TCP SYN packet (identifying it by the context
-  in which it occurs in relation to other packets), then floods the
-  receiving peer with copies of this packet.
-
-  OpenVPN's replay protection is implemented in slightly different ways,
-  depending on the key management mode you have selected.
-
-  In Static Key mode or when using an CFB or OFB mode cipher, OpenVPN uses
-  a 64 bit unique identifier that combines a time stamp with an
-  incrementing sequence number.
-
-  When using TLS mode for key exchange and a CBC cipher mode, OpenVPN uses
-  only a 32 bit sequence number without a time stamp, since OpenVPN can
-  guarantee the uniqueness of this value for each key. As in IPSec, if the
-  sequence number is close to wrapping back to zero, OpenVPN will trigger
-  a new key exchange.
-
-  To check for replays, OpenVPN uses the *sliding window* algorithm used
-  by IPSec.
-
 --replay-window args
   Modify the replay protection sliding-window size and time window.
 
@@ -3311,27 +3252,6 @@ These options are meaningful for both Static & TLS-negotiated key modes
   default) and you are using either ``--secret`` (shared-secret key mode)
   or TLS mode with ``--tls-auth``.
 
---no-iv
-  **DEPRECATED** This option will be removed in OpenVPN 2.5.
-
-  (Advanced) Disable OpenVPN's use of IV (cipher initialization vector).
-  Don't use this option unless you are prepared to make a tradeoff of
-  greater efficiency in exchange for less security.
-
-  OpenVPN uses an IV by default, and requires it for CFB and OFB cipher
-  modes (which are totally insecure without it). Using an IV is important
-  for security when multiple messages are being encrypted/decrypted with
-  the same key.
-
-  IV is implemented differently depending on the cipher mode used.
-
-  In CBC mode, OpenVPN uses a pseudo-random IV for each packet.
-
-  In CFB/OFB mode, OpenVPN uses a unique sequence number and time stamp as
-  the IV. In fact, in CFB/OFB mode, OpenVPN uses a datagram space-saving
-  optimization that uses the unique identifier for datagram replay
-  protection as the IV.
-
 --use-prediction-resistance
   Enable prediction resistance on mbed TLS's RNG.
 
@@ -3635,39 +3555,6 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   The thumbprint hex string can easily be copy-and-pasted from the Windows
   Certificate Store GUI.
 
---key-method m
-  **DEPRECATED** This option will be removed in OpenVPN 2.5
-
-  Use data channel key negotiation method ``m``. The key method must match
-  on both sides of the connection.
-
-  After OpenVPN negotiates a TLS session, a new set of keys for protecting
-  the tunnel data channel is generated and exchanged over the TLS session.
-
-  In method :code:`1` (the default for OpenVPN 1.x), both sides generate
-  random encrypt and HMAC-send keys which are forwarded to the other host
-  over the TLS channel. Method :code:`1` is **deprecated in OpenVPN 2.4**,
-  and **will be removed in OpenVPN 2.5**.
-
-  In method :code:`2`, (the default for OpenVPN 2.0) the client generates
-  a random key. Both client and server also generate some random seed
-  material. All key source material is exchanged over the TLS channel. The
-  actual keys are generated using the TLS PRF function, taking source
-  entropy from both client and server. Method :code:`2` is designed to
-  closely parallel the key generation process used by TLS 1.0.
-
-  Note that in TLS mode, two separate levels of keying occur:
-
-  (1)  The TLS connection is initially negotiated, with both sides of the
-       connection producing certificates and verifying the certificate (or
-       other authentication info provided) of the other side. The
-       ``--key-method`` parameter has no effect on this process.
-
-  (2)  After the TLS connection is established, the tunnel session keys are
-       separately negotiated over the existing secure TLS channel. Here,
-       ``--key-method`` determines the derivation of the tunnel session keys.
-
-
 *WARNING:* ``--tls-ciphers`` and ``--tls-ciphersuites``
     These options are expert features, which - if used correctly - can
     improve the security of your VPN connection. But it is also easy to
@@ -4175,34 +4062,6 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   :code:`X509_<depth>_<attribute>=<value>`. Multiple ``--x509-track``
   options can be defined to track multiple attributes.
 
---ns-cert-type args
-  **DEPRECATED** This option will be removed in OpenVPN 2.5. Use the more
-  modern equivalent ``--remote-cert-tls`` instead. This option will be
-  removed in OpenVPN 2.5.
-
-  Valid syntax:
-  ::
-
-     ns-cert-type client | server
-
-  Require that peer certificate was signed with an explicit ``nsCertType``
-  designation of :code:`client` or :code:`server`.
-
-  This is a useful security option for clients, to ensure that the host
-  they connect with is a designated server.
-
-  See the easy-rsa/build-key-server script for an example of how to
-  generate a certificate with the ``nsCertType`` field set to "server".
-
-  If the server certificate's nsCertType field is set to :code:`server`,
-  then the clients can verify this with :code:`--ns-cert-type server`.
-
-  This is an important security precaution to protect against a
-  man-in-the-middle attack where an authorized client attempts to connect
-  to another client by impersonating the server. The attack is easily
-  prevented by having clients verify the server certificate using any one
-  of ``--ns-cert-type``, ``--verify-x509-name`` or ``--tls-verify``.
-
 --remote-cert-ku key-usage
   Require that peer certificate was signed with an explicit
   ``key-usage``.
@@ -4911,6 +4770,7 @@ well (except for **--topology** , which has no effect on IPv6).
      iroute-ipv6 ipv6addr/bits
 
 
+.. include:: unsupported-options.rst
 
 SCRIPTING AND ENVIRONMENTAL VARIABLES
 =====================================
diff --git a/doc/unsupported-options.rst b/doc/unsupported-options.rst
new file mode 100644
index 00000000..ae7c1bcc
--- /dev/null
+++ b/doc/unsupported-options.rst
@@ -0,0 +1,33 @@
+
+UNSUPPORTED OPTIONS
+===================
+
+Options listed in this section has been removed from OpenVPN and is no
+longer supported
+
+--client-cert-not-required
+  Removed in OpenVPN 2.5.  This should be replaxed with
+  ``--verify-client-cert none``.
+
+--ifconfig-pool-linear
+  Removed in OpenVPN 2.5.  This should be replaced with ``--topology p2p``.
+
+--key-method
+  Removed in OpenVPN 2.5.  This option should not be used, as using the old
+  ``key-method`` weakens the VPN tunnel security.  The old ``key-method``
+  was also only needed when the remote side was older than OpenVPN 2.0.
+
+--no-iv
+  Removed in OpenVPN 2.5.  This option should not be used as it weakens the
+  VPN tunnel security.
+
+--no-reply
+  Removed in OpenVPN 2.5.  This option should not be used as it weakens the
+  VPN tunnel security.
+
+--ns-cert-type
+  Removed in OpenVPN 2.5.  The ``nsCertType`` field is no longer supported
+  in recent SSL/TLS libraries.  If your certificates does not include *key
+  usage* and *extended key usage* fields, they must be upgraded and the
+  ``--remote-cert-tls`` option should be used instead.
+
-- 
2.26.0


