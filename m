From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:59 +0200
Message-Id: <20220624083809.23487-16-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 15/25] dco: add documentation for
 ovpn-dco-linux
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 Changes.rst                           |   9 ++
 README.dco.md                         | 123 ++++++++++++++++++++++++++
 doc/man-sections/advanced-options.rst |  13 +++
 doc/man-sections/server-options.rst   |   6 ++
 4 files changed, 151 insertions(+)
 create mode 100644 README.dco.md

diff --git a/Changes.rst b/Changes.rst
index 67a23c79..275f8d64 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -79,6 +79,15 @@ Cookie based handshake for UDP server
     shake. The tls-crypt-v2 option allows controlling if older clients are
     accepted.
 
+Data channel offloading with ovpn-dco
+    2.6.0+ implements support for data-channel offloading where the data packets
+    are directly processed and forwarded in kernel space thanks to the ovpn-dco
+    kernel module. The userspace openvpn program acts purely as a control plane
+    application. Note that DCO will use DATA_V2 packets in P2P mode, therefore,
+    this implies that peers must be running 2.6.0+ in order to have P2P-NCP
+    which brings DATA_V2 packet support.
+
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
diff --git a/README.dco.md b/README.dco.md
new file mode 100644
index 00000000..e73e0fc2
--- /dev/null
+++ b/README.dco.md
@@ -0,0 +1,123 @@
+OpenVPN data channel offload
+============================
+2.6.0+ implements support for data-channel offloading where the data packets
+are directly processed and forwarded in kernel space thanks to the ovpn-dco
+kernel module. The userspace openvpn program acts purely as a control plane
+application.
+
+
+Overview of current release
+---------------------------
+- See the "Limitations by design" and "Current limitations" sections for
+  features that are not and/or will not be supported by OpenVPN + ovpn-dco
+
+
+Getting started (Linux)
+-----------------------
+
+- Use a recent Linux kernel. Linux 5.4.0 and newer are known to work with
+  ovpn-dco.
+
+Get the ovpn-dco module from one these urls and build it:
+
+* https://gitlab.com/openvpn/ovpn-dco
+* https://github.com/OpenVPN/ovpn-dco
+
+e.g.
+
+    git clone https://github.com/OpenVPN/ovpn-dco
+    cd ovpn-dco
+    make
+    sudo make install
+
+If you want to report bugs please ensure to compile ovpn-dco with
+`make DEBUG=1` and include any debug message being printed by the
+kernel (you can view those messages with `dmesg`).
+
+Clone OpenVPN and build dco branch. For example:
+
+    git clone -b dco https://github.com/openvpn/openvpn.git
+    cd openvpn
+    autoreconf -vi
+    ./configure --enable-dco
+    make
+    sudo make install # Or run just src/openvpn/openvpn
+
+If you start openvpn it should automatically detect DCO support and use the
+kernel module. Add the option `--disable-dco` to disable data channel offload
+support. If the configuration contains an option that is incompatible with
+data channel offloading OpenVPN will automatically disable DCO support and
+warn the user.
+
+Should OpenVPN be configured to use a feature that is not supported by ovpn-dco
+or should the ovpn-dco kernel module not be available on the system, you will
+see a message like
+
+    Note: Kernel support for ovpn-dco missing, disabling data channel offload.
+
+in your log.
+
+
+DCO and P2P mode
+----------------
+DCO is also available when running OpenVPN in P2P mode without --pull/--client option.
+The P2P mode is useful for scenarios when the OpenVPN tunnel should not interfere with
+overall routing and behave more like a "dumb" tunnel like GRE.
+
+However, DCO requires DATA_V2 to be enabled. This requires P2P with NCP capability, which
+is only available in OpenVPN 2.6 and later.
+
+OpenVPN prints a diagnostic message for the P2P NCP result when running in P2P mode:
+
+    P2P mode NCP negotiation result: TLS_export=1, DATA_v2=1, peer-id 9484735, cipher=AES-256-GCM
+
+Double check that your have `DATA_v2=1` in your output and a supported AEAD cipher
+(AES-XXX-GCM or CHACHA20POLY1305).
+
+
+Routing with ovpn-dco
+---------------------
+The ovpn-dco kernel module implements a more transparent approach to
+configuring routes to clients (aka 'iroutes') and consults the kernel
+routing tables for forwarding decisions.
+
+- Each client has an IPv4 and/or an IPv6 VPN IP assigned to it.
+- Additional IP ranges can be routed to a client by adding a route with
+  a client VPN IP as the gateway/nexthop (i.e. ip route add a.b.c.d/24 via $VPNIP).
+- Due to the point above, there is no real need to add a companion --route for
+  each --iroute directive, unless you want to blackhole traffic when the specific
+  client is not connected.
+- No internal routing is available. If you need truly internal routes, this can be
+  achieved either with filtering using `iptables` or using `ip rule`.
+- client-to-client behaviour, as implemented in userspace, does not exist: packets
+  always reach the tunnel interface and are then re-routed to the destination peer
+  based on the system routing table.
+
+
+Limitations by design
+----------------------
+- Layer 3 (dev tun only)
+- only AEAD ciphers are supported and currently only
+  Chacha20-Poly1305 and AES-GCM-128/192/256
+- no support for compression or compression framing
+  - see also `--compress migrate` option to move to a setup without compression
+- various features not implemented since they have better replacements
+  - --shaper, use tc instead
+  - packet manipulation, use nftables/iptables instead
+- OpenVPN 2.4.0 is the minimum peer version.
+  - older versions are missing support for the AEAD ciphers
+- topology subnet is the only supported `--topology` for servers
+- iroute directives install routes on the host operating system, see also
+  Routing with ovpn-dco
+
+
+Current implementation limitations
+-------------------
+- --persistent-tun not tested/supported
+- fallback to non-dco in client mode missing
+- IPv6 mapped IPv4 addresses need Linux 5.4.189+/5.10.110+/5.12+ to work
+- Some incompatible options may not properly fallback to non-dco
+- TCP performance with ovpn-dco can still exhibit bad behaviour and drop to a
+  few megabits per seconds
+- Not all incompatible options are currently identified
+- No per client statistics. Only total statistics available on the interface
diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index 5157c561..d5a6b4f2 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -91,3 +91,16 @@ used when debugging or testing out special usage scenarios.
   *(Linux only)* Set the TX queue length on the TUN/TAP interface.
   Currently defaults to operating system default.
 
+--disable-dco
+  Disables the opportunistic use of data channel offloading if available.
+  Without this option, OpenVPN will opportunistically use DCO mode if
+  the config options and the running kernel supports using DCO.
+
+  Data channel offload currently requires data-ciphers to only contain
+  AEAD ciphers (AES-GCM and Chacha20-Poly1305) and Linux with the
+  ovpn-dco module.
+
+  Note that some options have no effect or cannot be used when DCO mode
+  is enabled.
+
+  On platforms that do not support DCO ``disable-dco`` has no effect.
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 08ee7bd3..31992732 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -321,6 +321,12 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   from the kernel to OpenVPN. Once in OpenVPN, the ``--iroute`` directive
   routes to the specific client.
 
+  However, when using DCO, the ``--iroute`` directive is usually enough
+  for DCO to fully configure the routing table. The extra ``--route``
+  directive is required only if the expected behaviour is to route the
+  traffic for a specific network to the VPN interface also when the
+  responsible client is not connected (traffic will then be dropped).
+
   This option must be specified either in a client instance config file
   using ``--client-config-dir`` or dynamically generated using a
   ``--client-connect`` script.
-- 
2.35.1


