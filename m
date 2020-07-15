From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:04 +0200
Message-Id: <20200715223013.11726-8-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 07/16] doc/man: Move --dhcp-option from
 client to vpn-network section
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

Even though the --dhcp-option is only useful in a client context, it is
more related to configuration of the VPN network interface and the
related settings.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/client-options.rst      | 69 ------------------------
 doc/man-sections/vpn-network-options.rst | 69 ++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index d6f9e6aa..966ede1e 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -146,75 +146,6 @@ configuration.
 --connect-timeout n
   See ``--server-poll-timeout``.
 
---dhcp-option args
-  Set additional network settings via DHCP.  On Windows, this is parsed by
-  the ``tap-windows6`` or ``wintun`` driver.  On other platforms these
-  options can be picked up by a ``--up`` script or plug-in if it has been
-  pushed by the OpenVPN server.  The option will then be saved in the
-  client's environment before the ``--up`` script is called, under the name
-  :code:`foreign_option_{n}`.
-
-  Valid syntax:
-  ::
-
-     dhcp-options type [parm]
-
-  :code:`DOMAIN` ``name``
-        Set Connection-specific DNS Suffix to :code:`name`.
-
-  :code:`DNS` ``address``
-        Set primary domain name server IPv4 or IPv6 address.
-        Repeat this option to set secondary DNS server addresses.
-
-        Note: DNS IPv6 servers are currently set using netsh (the existing
-        DHCP code can only do IPv4 DHCP, and that protocol only permits
-        IPv4 addresses anywhere). The option will be put into the
-        environment, so an ``--up`` script could act upon it if needed.
-
-  :code:`WINS` ``address``
-        Set primary WINS server address (NetBIOS over TCP/IP Name Server).
-        Repeat this option to set secondary WINS server addresses.
-
-  :code:`NBDD` ``address``
-        Set primary NBDD server address (NetBIOS over TCP/IP Datagram
-        Distribution Server). Repeat this option to set secondary NBDD
-        server addresses.
-
-  :code:`NTP` ``address``
-        Set primary NTP server address (Network Time Protocol).
-        Repeat this option to set secondary NTP server addresses.
-
-  :code:`NBT` ``type``
-        Set NetBIOS over TCP/IP Node type. Possible options:
-
-        :code:`1`
-              b-node (broadcasts)
-
-        :code:`2`
-              p-node (point-to-point name queries to a WINS server)
-
-        :code:`4`
-              m-node (broadcast then query name server)
-
-        :code:`8`
-              h-node (query name server, then broadcast).
-
-  :code:`NBS` ``scope-id``
-        Set NetBIOS over TCP/IP Scope. A NetBIOS Scope ID provides an
-        extended naming service for the NetBIOS over TCP/IP (Known as NBT)
-        module. The primary purpose of a NetBIOS scope ID is to isolate
-        NetBIOS traffic on a single network to only those nodes with the
-        same NetBIOS scope ID. The NetBIOS scope ID is a character string
-        that is appended to the NetBIOS name. The NetBIOS scope ID on two
-        hosts must match, or the two hosts will not be able to communicate.
-        The NetBIOS Scope ID also allows computers to use the same computer
-        name, as they have different scope IDs. The Scope ID becomes a part
-        of the NetBIOS name, making the name unique. (This description of
-        NetBIOS scopes courtesy of NeonSurge@...1311...)
-
-  :code:`DISABLE-NBT`
-        Disable Netbios-over-TCP/IP.
-
 --explicit-exit-notify n
   In UDP client mode or point-to-point mode, send server/peer an exit
   notification if tunnel is restarted or OpenVPN process is exited. In
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index fc18676e..d75cf540 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -88,6 +88,75 @@ routing.
   the TUN/TAP device used with ``--dev`` does not begin with :code:`tun`
   or :code:`tap`.
 
+--dhcp-option args
+  Set additional network settings via DHCP.  On Windows, this is parsed by
+  the ``tap-windows6`` or ``wintun`` driver.  On other platforms these
+  options can be picked up by a ``--up`` script or plug-in if it has been
+  pushed by the OpenVPN server.  The option will then be saved in the
+  client's environment before the ``--up`` script is called, under the name
+  :code:`foreign_option_{n}`.
+
+  Valid syntax:
+  ::
+
+     dhcp-options type [parm]
+
+  :code:`DOMAIN` ``name``
+        Set Connection-specific DNS Suffix to :code:`name`.
+
+  :code:`DNS` ``address``
+        Set primary domain name server IPv4 or IPv6 address.
+        Repeat this option to set secondary DNS server addresses.
+
+        Note: DNS IPv6 servers are currently set using netsh (the existing
+        DHCP code can only do IPv4 DHCP, and that protocol only permits
+        IPv4 addresses anywhere). The option will be put into the
+        environment, so an ``--up`` script could act upon it if needed.
+
+  :code:`WINS` ``address``
+        Set primary WINS server address (NetBIOS over TCP/IP Name Server).
+        Repeat this option to set secondary WINS server addresses.
+
+  :code:`NBDD` ``address``
+        Set primary NBDD server address (NetBIOS over TCP/IP Datagram
+        Distribution Server). Repeat this option to set secondary NBDD
+        server addresses.
+
+  :code:`NTP` ``address``
+        Set primary NTP server address (Network Time Protocol).
+        Repeat this option to set secondary NTP server addresses.
+
+  :code:`NBT` ``type``
+        Set NetBIOS over TCP/IP Node type. Possible options:
+
+        :code:`1`
+              b-node (broadcasts)
+
+        :code:`2`
+              p-node (point-to-point name queries to a WINS server)
+
+        :code:`4`
+              m-node (broadcast then query name server)
+
+        :code:`8`
+              h-node (query name server, then broadcast).
+
+  :code:`NBS` ``scope-id``
+        Set NetBIOS over TCP/IP Scope. A NetBIOS Scope ID provides an
+        extended naming service for the NetBIOS over TCP/IP (Known as NBT)
+        module. The primary purpose of a NetBIOS scope ID is to isolate
+        NetBIOS traffic on a single network to only those nodes with the
+        same NetBIOS scope ID. The NetBIOS scope ID is a character string
+        that is appended to the NetBIOS name. The NetBIOS scope ID on two
+        hosts must match, or the two hosts will not be able to communicate.
+        The NetBIOS Scope ID also allows computers to use the same computer
+        name, as they have different scope IDs. The Scope ID becomes a part
+        of the NetBIOS name, making the name unique. (This description of
+        NetBIOS scopes courtesy of NeonSurge@...1311...)
+
+  :code:`DISABLE-NBT`
+        Disable Netbios-over-TCP/IP.
+
 --ifconfig args
   Set TUN/TAP adapter parameters. It requires the *IP address* of the local
   VPN endpoint. For TUN devices in point-to-point mode, the next argument
-- 
2.26.0


