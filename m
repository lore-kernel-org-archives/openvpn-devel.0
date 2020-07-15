From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:00 +0200
Message-Id: <20200715223013.11726-4-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 03/16] doc/man: Move <connection> profiles
 section
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

The <connection> profile documentation has been enlisted in between all
the other OpenVPN options.  As <connection> is not strictly an option by
itself but a grouping mechanism, move it into its own section in the man
page.  This also makes the HTML rendering look much nicer and better
structured.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/openvpn.8.rst | 149 ++++++++++++++++++++++++----------------------
 1 file changed, 78 insertions(+), 71 deletions(-)

diff --git a/doc/openvpn.8.rst b/doc/openvpn.8.rst
index 4627a7d3..fc3ecdb8 100644
--- a/doc/openvpn.8.rst
+++ b/doc/openvpn.8.rst
@@ -204,77 +204,6 @@ Tunnel Options:
   prevent DNS caching. For example, "foo.bar.gov" would be modified to
   "<random-chars>.foo.bar.gov".
 
-``<connection>``
-  Define a client connection profile. Client connection profiles are
-  groups of OpenVPN options that describe how to connect to a given
-  OpenVPN server. Client connection profiles are specified within an
-  OpenVPN configuration file, and each profile is bracketed by
-  ``<connection>`` and ``</connection>``.
-
-  An OpenVPN client will try each connection profile sequentially until it
-  achieves a successful connection.
-
-  ``--remote-random`` can be used to initially "scramble" the connection
-  list.
-
-  Here is an example of connection profile usage:
-  ::
-
-     client
-     dev tun
-
-     <connection>
-     remote 198.19.34.56 1194 udp
-     </connection>
-
-     <connection>
-     remote 198.19.34.56 443 tcp
-     </connection>
-
-     <connection>
-     remote 198.19.34.56 443 tcp
-     http-proxy 192.168.0.8 8080
-     </connection>
-
-     <connection>
-     remote 198.19.36.99 443 tcp
-     http-proxy 192.168.0.8 8080
-     </connection>
-
-     persist-key
-     persist-tun
-     pkcs12 client.p12
-     remote-cert-tls server
-     verb 3
-
-  First we try to connect to a server at 198.19.34.56:1194 using UDP. If
-  that fails, we then try to connect to 198.19.34.56:443 using TCP. If
-  that also fails, then try connecting through an HTTP proxy at
-  192.168.0.8:8080 to 198.19.34.56:443 using TCP. Finally, try to connect
-  through the same proxy to a server at 198.19.36.99:443 using TCP.
-
-  The following OpenVPN options may be used inside of a ``<connection>``
-  block:
-
-  ``bind``, ``connect-retry``, ``connect-retry-max``, ``connect-timeout``,
-  ``explicit-exit-notify``, ``float``, ``fragment``, ``http-proxy``,
-  ``http-proxy-option``, ``key-direction``, ``link-mtu``, ``local``,
-  ``lport``, ``mssfix``, ``mtu-disc``, ``nobind``, ``port``, ``proto``,
-  ``remote``, ``rport``, ``socks-proxy``, ``tls-auth``, ``tls-crypt``,
-  ``tun-mtu and``, ``tun-mtu-extra``.
-
-  A defaulting mechanism exists for specifying options to apply to all
-  ``<connection>`` profiles. If any of the above options (with the
-  exception of ``remote`` ) appear outside of a ``<connection>`` block,
-  but in a configuration file which has one or more ``<connection>``
-  blocks, the option setting will be used as a default for
-  ``<connection>`` blocks which follow it in the configuration file.
-
-  For example, suppose the ``nobind`` option were placed in the sample
-  configuration file above, near the top of the file, before the first
-  ``<connection>`` block. The effect would be as if ``nobind`` were
-  declared in all ``<connection>`` blocks below it.
-
 --proto-force p
   When iterating through connection profiles, only consider profiles using
   protocol ``p`` (:code:`tcp` \| :code:`udp`).
@@ -5400,6 +5329,84 @@ instances.
 
 
 
+CONNECTION PROFILES
+===================
+
+Client configuration files may contain multiple remote servers which
+it will attempt to connect against.  But there are some configuration
+options which are related to specific ``--remote`` options.  For these
+use cases, connection profiles is the solution.
+
+By enacpulating the ``--remote`` option and related options within
+``<connection>`` and ``</connection>``, these options are handled as a
+group.
+
+An OpenVPN client will try each connection profile sequentially until it
+achieves a successful connection.
+
+``--remote-random`` can be used to initially "scramble" the connection
+list.
+
+Here is an example of connection profile usage:
+::
+
+   client
+   dev tun
+
+   <connection>
+   remote 198.19.34.56 1194 udp
+   </connection>
+
+   <connection>
+   remote 198.19.34.56 443 tcp
+   </connection>
+
+   <connection>
+   remote 198.19.34.56 443 tcp
+   http-proxy 192.168.0.8 8080
+   </connection>
+
+   <connection>
+   remote 198.19.36.99 443 tcp
+   http-proxy 192.168.0.8 8080
+   </connection>
+
+   persist-key
+   persist-tun
+   pkcs12 client.p12
+   remote-cert-tls server
+   verb 3
+
+First we try to connect to a server at 198.19.34.56:1194 using UDP. If
+that fails, we then try to connect to 198.19.34.56:443 using TCP. If
+that also fails, then try connecting through an HTTP proxy at
+192.168.0.8:8080 to 198.19.34.56:443 using TCP. Finally, try to connect
+through the same proxy to a server at 198.19.36.99:443 using TCP.
+
+The following OpenVPN options may be used inside of a ``<connection>``
+block:
+
+``bind``, ``connect-retry``, ``connect-retry-max``, ``connect-timeout``,
+``explicit-exit-notify``, ``float``, ``fragment``, ``http-proxy``,
+``http-proxy-option``, ``key-direction``, ``link-mtu``, ``local``,
+``lport``, ``mssfix``, ``mtu-disc``, ``nobind``, ``port``, ``proto``,
+``remote``, ``rport``, ``socks-proxy``, ``tls-auth``, ``tls-crypt``,
+``tun-mtu and``, ``tun-mtu-extra``.
+
+A defaulting mechanism exists for specifying options to apply to all
+``<connection>`` profiles. If any of the above options (with the
+exception of ``remote`` ) appear outside of a ``<connection>`` block,
+but in a configuration file which has one or more ``<connection>``
+blocks, the option setting will be used as a default for
+``<connection>`` blocks which follow it in the configuration file.
+
+For example, suppose the ``nobind`` option were placed in the sample
+configuration file above, near the top of the file, before the first
+``<connection>`` block. The effect would be as if ``nobind`` were
+declared in all ``<connection>`` blocks below it.
+
+
+
 INLINE FILE SUPPORT
 ===================
 
-- 
2.26.0


