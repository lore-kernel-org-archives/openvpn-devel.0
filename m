From: David Sommerseth <davids@...515...>
Date: Fri, 17 Jul 2020 00:53:36 +0200
Message-Id: <20200716225338.611-7-davids@...515...>
In-Reply-To: <20200716225338.611-1-davids@...515...>
References: <20200716225338.611-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 6/8] doc/man: Adopt compression
 documentation
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

Commit c67e93b25208be2 updated the man page in reagrds to new
compression options and improving existing compression options.  This
adopts those changes into the .rst format.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/protocol-options.rst | 52 ++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index a5a1253a..d7bcbb98 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -5,6 +5,31 @@ protocol.  Many of these options also define the encryption options
 of the data channel in the OpenVPN wire protocol.  These options must be
 configured in a compatible way between both the local and remote side.
 
+--allow-compression mode
+  As described in the ``--compress`` option, compression is a potentially
+  dangerous option.  This option allows controlling the behaviour of
+  OpenVPN when compression is used and allowed.
+
+  Valid syntaxes:
+  ::
+
+      allow-compression
+      allow-compression mode
+
+  The ``mode`` argument can be one of the following values:
+
+  :code:`asym`  (default)
+      OpenVPN will only *decompress downlink packets* but *not compress
+      uplink packets*.  This also allows migrating to disable compression
+      when changing both server and client configurations to remove
+      compression at the same time is not a feasible option.
+
+  :code:`no`
+      OpenVPN will refuse any non-stub compression.
+
+  :code:`yes`
+      OpenVPN will send and receive compressed packets.
+
 --auth alg
   Authenticate data channel packets and (if enabled) ``tls-auth`` control
   channel packets with HMAC using message digest algorithm ``alg``. (The
@@ -58,23 +83,32 @@ configured in a compatible way between both the local and remote side.
   not recommended.  VPN tunnels which use compression are susceptible to
   the VORALCE attack vector.
 
-  The ``algorithm`` parameter may be :code:`lzo`, :code:`lz4`, or empty.
+  The ``algorithm`` parameter may be :code:`lzo`, :code:`lz4`,
+  :code:`lz4-v2`, :code:`stub`, :code:`stub-v2` or empty.
   LZO and LZ4 are different compression algorithms, with LZ4 generally
   offering the best performance with least CPU usage.
 
-  If the ``algorithm`` parameter is empty, compression will be turned off,
-  but the packet framing for compression will still be enabled, allowing a
-  different setting to be pushed later.
+  The :code:`lz4-v2` and :code:`stub-v2` variants implement a better
+  framing that does not add overhead when packets cannot be compressed. All
+  other variants always add one extra framing byte compared to no
+  compression framing.
+
+  If the ``algorithm`` parameter is :code:`stub`, :code:`stub-v2` or empty,
+  compression will be turned off, but the packet framing for compression
+  will still be enabled, allowing a different setting to be pushed later.
+  Additionally, :code:`stub` and :code:`stub-v2` wil disable announcing
+  ``lzo`` and ``lz4`` compression support via *IV_* variables to the
+  server.
 
   ***Security Considerations***
 
   Compression and encryption is a tricky combination. If an attacker knows
-  or is able to control (parts of) the plaintext of packets that contain
+  or is able to control (parts of) the plain-text of packets that contain
   secrets, the attacker might be able to extract the secret if compression
-  is enabled. See e.g. the CRIME and BREACH attacks on TLS which also
-  leverage compression to break encryption. If you are not entirely sure
-  that the above does not apply to your traffic, you are advised to
-  *not* enable compression.
+  is enabled. See e.g. the *CRIME* and *BREACH* attacks on TLS and
+  *VORACLE* on VPNs which also leverage to break encryption. If you are not
+  entirely sure that the above does not apply to your traffic, you are
+  advised to *not* enable compression.
 
 --comp-lzo mode
   **DEPRECATED** Enable LZO compression algorithm.  Compression is
-- 
2.26.0


