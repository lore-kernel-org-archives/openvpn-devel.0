From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:07 +0200
Message-Id: <20200715223013.11726-11-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 10/16] doc/man: Moved --reneg-* options to
 its own section
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

The options related to renegotiation of the data channel encryption key
is not really a link option.  As the renegotiation is encryption
related but doesn't really fit into the generic, tls or pkcs11 sections,
add it into its own section.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/encryption-options.rst |  1 +
 doc/man-sections/link-options.rst       | 47 ----------------------
 doc/man-sections/renegotiation.rst      | 53 +++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 47 deletions(-)
 create mode 100644 doc/man-sections/renegotiation.rst

diff --git a/doc/man-sections/encryption-options.rst b/doc/man-sections/encryption-options.rst
index 5e99c52f..42c80eb8 100644
--- a/doc/man-sections/encryption-options.rst
+++ b/doc/man-sections/encryption-options.rst
@@ -130,6 +130,7 @@ Generating key material
        access to this file will be to generate auth tokens that the OpenVPN
        server will accept as valid.
 
+.. include:: renegotiation.rst
 .. include:: tls-options.rst
 .. include:: pkcs11-options.rst
 
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 5f75c5f3..43e33176 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -284,53 +284,6 @@ the local and the remote host.
   and has been used since version 2.0-beta17. Previous versions used port
   5000 as the default.
 
---reneg-bytes n
-  Renegotiate data channel key after ``n`` bytes sent or received
-  (disabled by default with an exception, see below). OpenVPN allows the
-  lifetime of a key to be expressed as a number of bytes
-  encrypted/decrypted, a number of packets, or a number of seconds. A key
-  renegotiation will be forced if any of these three criteria are met by
-  either peer.
-
-  If using ciphers with cipher block sizes less than 128-bits,
-  ``--reneg-bytes`` is set to 64MB by default, unless it is explicitly
-  disabled by setting the value to :code:`0`, but this is
-  **HIGHLY DISCOURAGED** as this is designed to add some protection against
-  the SWEET32 attack vector. For more information see the ``--cipher``
-  option.
-
---reneg-pkts n
-  Renegotiate data channel key after **n** packets sent and received
-  (disabled by default).
-
---reneg-sec args
-  Renegotiate data channel key after at most ``max`` seconds
-  (default :code:`3600`) and at least ``min`` seconds (default is 90% of
-  ``max`` for servers, and equal to ``max`` for clients).
-  ::
-
-     reneg-sec max [min]
-
-  The effective ``--reneg-sec`` value used is per session
-  pseudo-uniform-randomized between ``min`` and ``max``.
-
-  With the default value of :code:`3600` this results in an effective per
-  session value in the range of :code:`3240`..:code:`3600` seconds for
-  servers, or just 3600 for clients.
-
-  When using dual-factor authentication, note that this default value may
-  cause the end user to be challenged to reauthorize once per hour.
-
-  Also, keep in mind that this option can be used on both the client and
-  server, and whichever uses the lower value will be the one to trigger
-  the renegotiation. A common mistake is to set ``--reneg-sec`` to a
-  higher value on either the client or server, while the other side of the
-  connection is still using the default value of :code:`3600` seconds,
-  meaning that the renegotiation will still occur once per :code:`3600`
-  seconds. The solution is to increase --reneg-sec on both the client and
-  server, or set it to :code:`0` on one side of the connection (to
-  disable), and to your chosen value on the other side.
-
 --rport port
   Set TCP/UDP port number or name used by the ``--remote`` option. The
   port can also be set directly using the ``--remote`` option.
diff --git a/doc/man-sections/renegotiation.rst b/doc/man-sections/renegotiation.rst
new file mode 100644
index 00000000..aaede4eb
--- /dev/null
+++ b/doc/man-sections/renegotiation.rst
@@ -0,0 +1,53 @@
+Data Channel Renegotiation
+--------------------------
+
+When running OpenVPN in client/server mode, the data channel will use a
+separate ephemeral encryption key which is rotated at regular intervals.
+
+--reneg-bytes n
+  Renegotiate data channel key after ``n`` bytes sent or received
+  (disabled by default with an exception, see below). OpenVPN allows the
+  lifetime of a key to be expressed as a number of bytes
+  encrypted/decrypted, a number of packets, or a number of seconds. A key
+  renegotiation will be forced if any of these three criteria are met by
+  either peer.
+
+  If using ciphers with cipher block sizes less than 128-bits,
+  ``--reneg-bytes`` is set to 64MB by default, unless it is explicitly
+  disabled by setting the value to :code:`0`, but this is
+  **HIGHLY DISCOURAGED** as this is designed to add some protection against
+  the SWEET32 attack vector. For more information see the ``--cipher``
+  option.
+
+--reneg-pkts n
+  Renegotiate data channel key after **n** packets sent and received
+  (disabled by default).
+
+--reneg-sec args
+  Renegotiate data channel key after at most ``max`` seconds
+  (default :code:`3600`) and at least ``min`` seconds (default is 90% of
+  ``max`` for servers, and equal to ``max`` for clients).
+  ::
+
+     reneg-sec max [min]
+
+  The effective ``--reneg-sec`` value used is per session
+  pseudo-uniform-randomized between ``min`` and ``max``.
+
+  With the default value of :code:`3600` this results in an effective per
+  session value in the range of :code:`3240`..:code:`3600` seconds for
+  servers, or just 3600 for clients.
+
+  When using dual-factor authentication, note that this default value may
+  cause the end user to be challenged to reauthorize once per hour.
+
+  Also, keep in mind that this option can be used on both the client and
+  server, and whichever uses the lower value will be the one to trigger
+  the renegotiation. A common mistake is to set ``--reneg-sec`` to a
+  higher value on either the client or server, while the other side of the
+  connection is still using the default value of :code:`3600` seconds,
+  meaning that the renegotiation will still occur once per :code:`3600`
+  seconds. The solution is to increase --reneg-sec on both the client and
+  server, or set it to :code:`0` on one side of the connection (to
+  disable), and to your chosen value on the other side.
+
-- 
2.26.0


