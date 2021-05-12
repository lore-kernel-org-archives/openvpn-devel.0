From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 May 2021 15:15:11 +0200
Message-Id: <20210512131511.1309914-10-arne@...1227...>
In-Reply-To: <20210512131511.1309914-1-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 9/9] Add detailed man page section to setup
 a OpenVPN setup with peer-fingerprint
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

This is meant to give new users a quickstart for a useable OpenVPN
setup. Our own documentation is lacking in this regard and many often
tutorials that can be found online are often questionable in some
aspects.

Linking the invidiaul RST file on github also give a tutorial
in a nicely formatted way.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                              |   4 +
 doc/Makefile.am                          |   1 +
 doc/man-sections/example-fingerprint.rst | 194 +++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 doc/man-sections/example-fingerprint.rst

diff --git a/Changes.rst b/Changes.rst
index 9185b55f7..f1c739f99 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -25,6 +25,10 @@ Certificate pinning/verify peer fingerprint
     fingerprint of the peer. The option takes use a number of allowed
     SHA256 certificate fingerprints.
 
+    See the man page section "Small OpenVPN setup with peer-fingerprint"
+    for a tutorial how to use this feature. This is also available online
+    under https://github.com/openvpn/openvpn/blob/master/doc/man-sections/example-fingerprint.rst
+
 TLS mode with self-signed certificates
     When ``--peer-fingerprint`` is used, the ``--ca`` and ``--capath`` option
     become optional. This allows for small OpenVPN setups without setting up
diff --git a/doc/Makefile.am b/doc/Makefile.am
index e411f5f9d..e7022c085 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -25,6 +25,7 @@ dist_noinst_DATA = \
 	man-sections/connection-profiles.rst \
 	man-sections/encryption-options.rst \
 	man-sections/examples.rst \
+	man-sections/examples.rst \
 	man-sections/generic-options.rst \
 	man-sections/inline-files.rst \
 	man-sections/link-options.rst \
diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/example-fingerprint.rst
new file mode 100644
index 000000000..7d915aedb
--- /dev/null
+++ b/doc/man-sections/example-fingerprint.rst
@@ -0,0 +1,194 @@
+Small OpenVPN setup with peer-fingerprint
+=========================================
+This section consists of instructions how to build a small OpenVPN setup with the
+:code:`peer-fingerprint` option. This setup has the advantage to be easy to setup
+and should for most small lab and home setups without the need to setup a PKI.
+For bigger scale setup setting up a PKI (e.g. via easy-rsa) is still recommended.
+
+Both server and client configuration can of course be further modified to individualise the
+setup.
+
+Server setup
+------------
+1. Install openvpn
+
+   Compile from source-code (see `INSTALL` file) or install via a distribution (apt/yum/ports)
+   or via installer (Windows).
+
+2. Generate a self-signed certificate for the server:
+   ::
+
+    openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout serverkey.pem -out server.pem -nodes -sha256 -days 3650 -subj '/CN=server'
+
+3. Generate SHA256 fingerprint of the server certificate
+
+   Use the OpenSSL command line utility to view the fingerprint of just
+   created certificate:
+   ::
+
+    openssl x509 -fingerprint -sha256 -in styx-win.pem -noout server.pem
+
+   This output something similar to:
+   ::
+
+     SHA256 Fingerprint=00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
+
+
+3. Write a server configuration (`server.conf`):
+::
+
+    # The server certificate we created in step 1
+    cert server.pem
+    key serverkey.pem
+
+    dh none
+    dev tun
+
+    # Listen on IPv6+IPv4 simultaneously
+    proto udp6
+
+    # The ip address the server will distribute
+    server 192.168.234.0 255.255.255.0
+    server-ipv6 fd00:6f76:706e::/64
+
+    # A tun-mtu of 1400 avoids problems of too big packets after VPN encapsulation
+    tun-mtu 1400
+
+    # The fingerprints of your clients. After adding/remvoing one here restart the
+    # server
+    <peer-fingerprint>
+    </peer-fingerprint>
+
+    # Notify clients when you restart the server to reconnect quickly
+    explicit-exit-notify 1
+
+    # Ping every 60s, restart if no data received for 5 minutes
+    keepalive 60 300
+
+4. Add at least one client as described in the client section.
+
+5. Start the server.
+    - On systemd based distributions move `server.pem`, `serverkey.pem` and
+      `server.conf` to :code:`/etc/openvpn/server` and start it via systemctl
+
+      ::
+
+          sudo mv server.conf server.pem /etc/openvpn
+
+          sudo systemctl start openvpn-server@...185...
+
+Adding a client
+---------------
+1. Install OpenVPN
+
+2. Generate a self-signed certificate for the client. In this example the client
+   name is alice. Each client should have a unique name. Replace alice with a
+   different name for each client.
+   ::
+
+      openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -nodes -sha256 -days 3650 -subj '/CN=alice'
+
+   This generate a certificate and a key for the client. The output of the command will look
+   something like this:
+   ::
+
+      -----BEGIN PRIVATE KEY-----
+      [base64 content]
+      -----END PRIVATE KEY-----
+      -----
+      -----BEGIN CERTIFICATE-----
+      [base 64 content]
+      -----END CERTIFICATE-----
+
+3. Create a new client configuration file. In this example we will name the file
+   `alice.ovpn`:
+
+   ::
+
+      # The name of your server to connect to
+      remote yourserver.example.net
+      client
+      # use a random source port instead the fixed 1194
+      nobind
+
+      # Uncomment the following line if you want to route
+      # all traffic via the VPN
+      # redirect-gateway def1 ipv6
+
+      # To set a a DNS server
+      # dhcp-option DNS 192.168.234.1
+
+      <key>
+      -----BEGIN PRIVATE KEY-----
+      [Insert here the key created in step 2]
+      -----END PRIVATE KEY-----
+      </key>
+      <cert>
+      -----BEGIN CERTIFICATE-----
+      [Insert here the certificate created in step 2]
+      -----END CERTIFICATE-----
+      </cert>
+
+      # This the fingerprint of the server that we trust. We generated this fingerprint
+      # in step 2 of the server setup
+      peer-fingerprint 00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
+
+      # The tun-mtu of the client should match the server MTU
+      tun-mtu 1400
+      dev tun
+
+
+4. Generate the fingerprint of the client certificate. For that we will
+   let OpenSSL read the client configuration file as the x509 command will
+   ignore anything that is not between the begin and end markers of the certificate:
+
+   ::
+
+      openssl x509 -fingerprint -sha256 -noout -in ./focal-server-locked.ovpn
+
+   This will again output something like
+   ::
+
+        SHA256 Fingerprint=ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00
+
+5. Edit the `server.conf` configuration file and add this new client
+   fingerprint as additional line  between :code:`<peer-fingerprint>`
+   and :code:`</peer-fingerprint>`
+
+   After adding *two* clients the part of configuration would look like this:
+
+   ::
+
+      <peer-fingerprint>
+      ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00
+      99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:88:77:66:55:44:33
+      </peer-fingperint>
+
+6. (optional) if the client is an older client that does not support the
+   :code:`peer-fingerprint` (OpenVPN 2.5 and older, OpenVPN Connect 3.3
+   and older), the config can be modified to still work with those.
+
+   Remove the line starting with :code:`peer-fingerprint` line. Then
+   add a new :code:`<ca>` section at the end of the configuration file
+   with the contents of the :code:`server.pem` created in step 2 of the
+   server setup. The end of `alice.ovpn` file should like:
+
+   ::
+
+      [...]  # Beginning of the file skipped
+      </cert>
+
+      # The tun-mtu of the client should match the server MTU
+      tun-mtu 1400
+      dev tun
+
+      <ca>
+      [contents of the server.pem]
+      </ca>
+
+   Note that we put the :code:`<ca>` section after the :code:`<cert>` section
+   to make the fingerprint generation from step 4 still work since it will
+   only use the first certificate its find.
+
+7. Import the file into the OpenVPN client or just use the
+   :code:`openvpn alice.ovpn` to start the VPN.
-- 
2.31.1


