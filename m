From: Gert Doering <gert@...1296...>
Date: Mon, 25 Mar 2024 08:13:20 +0100
Message-ID: <20240325071320.11348-1-gert@...1296...>
In-Reply-To: <gerrit.1709557301000.I1a36651c0dea52259533ffc00bccb9b03bf82e26@...2715...>
References: <gerrit.1709557301000.I1a36651c0dea52259533ffc00bccb9b03bf82e26@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] samples: Update sample configurations
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

From: Frank Lichtenheld <frank@...2641...>

- Remove compression settings. Not recommended anymore.
- Remove old cipher setting. Replaced by data-ciphers negotiation.
- Add comment how to set data-ciphers for very old clients.
- Remove/reword some old comments. e.g. no need to reference
  OpenVPN 1.x anymore.
- Mention peer-fingerprint alternative.

Github: #511
Change-Id: I1a36651c0dea52259533ffc00bccb9b03bf82e26
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/532
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/sample/sample-config-files/README b/sample/sample-config-files/README
index d53ac79..1493dab 100644
--- a/sample/sample-config-files/README
+++ b/sample/sample-config-files/README
@@ -4,3 +4,5 @@
 which is located at:
 
 http://openvpn.net/howto.html
+
+See also the openvpn-examples man page.
diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
index f51e017..53b8027 100644
--- a/sample/sample-config-files/client.conf
+++ b/sample/sample-config-files/client.conf
@@ -1,5 +1,5 @@
 ##############################################
-# Sample client-side OpenVPN 2.0 config file #
+# Sample client-side OpenVPN 2.6 config file #
 # for connecting to multi-client server.     #
 #                                            #
 # This configuration can be used by multiple #
@@ -102,22 +102,15 @@
 # EasyRSA can do this for you.
 remote-cert-tls server
 
+# Allow to connect to really old OpenVPN versions
+# without AEAD support (OpenVPN 2.3.x or older)
+# This adds AES-256-CBC as fallback cipher and
+# keeps the modern ciphers as well.
+;data-ciphers AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305:AES-256-CBC
+
 # If a tls-auth key is used on the server
 # then every client must also have the key.
-tls-auth ta.key 1
-
-# Select a cryptographic cipher.
-# If the cipher option is used on the server
-# then you must also specify it here.
-# Note that v2.4 client/server will automatically
-# negotiate AES-256-GCM in TLS mode.
-# See also the data-ciphers option in the manpage
-cipher AES-256-CBC
-
-# Enable compression on the VPN link.
-# Don't enable this unless it is also
-# enabled in the server config file.
-#comp-lzo
+;tls-auth ta.key 1
 
 # Set log file verbosity.
 verb 3
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
index 97732c6..48716a0 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -1,5 +1,5 @@
 #################################################
-# Sample OpenVPN 2.0 config file for            #
+# Sample OpenVPN 2.6 config file for            #
 # multi-client server.                          #
 #                                               #
 # This file is for the server side              #
@@ -47,15 +47,15 @@
 # an explicit unit number, such as tun0.
 # On Windows, use "dev-node" for this.
 # On most systems, the VPN will not function
-# unless you partially or fully disable
+# unless you partially or fully disable/open
 # the firewall for the TUN/TAP interface.
 ;dev tap
 dev tun
 
 # Windows needs the TAP-Win32 adapter name
 # from the Network Connections panel if you
-# have more than one.  On XP SP2 or higher,
-# you may need to selectively disable the
+# have more than one.
+# You may need to selectively disable the
 # Windows firewall for the TAP adapter.
 # Non-Windows systems usually don't need this.
 ;dev-node MyTap
@@ -66,8 +66,9 @@
 # key file.  The server and all clients will
 # use the same ca file.
 #
-# See the "easy-rsa" directory for a series
-# of scripts for generating RSA certificates
+# See the "easy-rsa" project at
+# https://github.com/OpenVPN/easy-rsa
+# for generating RSA certificates
 # and private keys.  Remember to use
 # a unique Common Name for the server
 # and each of the client certificates.
@@ -75,6 +76,13 @@
 # Any X509 key management system can be used.
 # OpenVPN can also use a PKCS #12 formatted key file
 # (see "pkcs12" directive in man page).
+#
+# If you do not want to maintain a CA
+# and have a small number of clients
+# you can also use self-signed certificates
+# and use the peer-fingerprint option.
+# See openvpn-examples man page for a
+# configuration example.
 ca ca.crt
 cert server.crt
 key server.key  # This file should be kept secret
@@ -84,12 +92,18 @@
 #   openssl dhparam -out dh2048.pem 2048
 dh dh2048.pem
 
+# Allow to connect to really old OpenVPN versions
+# without AEAD support (OpenVPN 2.3.x or older)
+# This adds AES-256-CBC as fallback cipher and
+# keeps the modern ciphers as well.
+;data-ciphers AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305:AES-256-CBC
+
 # Network topology
 # Should be subnet (addressing via IP)
 # unless Windows clients v2.0.9 and lower have to
 # be supported (then net30, i.e. a /30 per client)
 # Defaults to net30 (not recommended)
-;topology subnet
+topology subnet
 
 # Configure server mode and supply a VPN subnet
 # for OpenVPN to draw client addresses from.
@@ -218,7 +232,7 @@
 # IF YOU HAVE NOT GENERATED INDIVIDUAL
 # CERTIFICATE/KEY PAIRS FOR EACH CLIENT,
 # EACH HAVING ITS OWN UNIQUE "COMMON NAME",
-# UNCOMMENT THIS LINE OUT.
+# UNCOMMENT THIS LINE.
 ;duplicate-cn
 
 # The keepalive directive causes ping-like
@@ -241,26 +255,7 @@
 # a copy of this key.
 # The second parameter should be '0'
 # on the server and '1' on the clients.
-tls-auth ta.key 0 # This file is secret
-
-# Select a cryptographic cipher.
-# This config item must be copied to
-# the client config file as well.
-# Note that v2.4 client/server will automatically
-# negotiate AES-256-GCM in TLS mode.
-# See also the ncp-cipher option in the manpage
-cipher AES-256-CBC
-
-# Enable compression on the VPN link and push the
-# option to the client (v2.4+ only, for earlier
-# versions see below)
-;compress lz4-v2
-;push "compress lz4-v2"
-
-# For compression compatible with older clients use comp-lzo
-# If you enable it here, you must also
-# enable it in the client config file.
-;comp-lzo
+;tls-auth ta.key 0 # This file is secret
 
 # The maximum number of concurrently connected
 # clients we want to allow.

