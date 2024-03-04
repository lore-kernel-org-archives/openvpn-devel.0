From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  4 Mar 2024 17:15:56 +0100
Message-Id: <20240304161556.2036270-1-frank@...2641...>
In-Reply-To: <gerrit.1709557301000.I199541fea5a76c8edef7f67d2dbfc476987dc2f7@...2715...>
References: <gerrit.1709557301000.I199541fea5a76c8edef7f67d2dbfc476987dc2f7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] samples: Remove tls-*.conf
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
Cc: Arne Schwabe <arne-openvpn@...1227...>, Antonio Quartulli <a@...2181...>

These are mostly redundant with client/server.conf
Let's try to manage to maintain one set of sample
configurations before we branch out further.

Change-Id: I199541fea5a76c8edef7f67d2dbfc476987dc2f7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Antonio Quartulli <a@...2181...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master and release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/531
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>
Antonio Quartulli <a@...2181...>

        
diff --git a/sample/sample-config-files/home.up b/sample/sample-config-files/home.up
deleted file mode 100755
index 9c347cc..0000000
--- a/sample/sample-config-files/home.up
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/sh
-route add -net 10.0.0.0 netmask 255.255.255.0 gw $5
diff --git a/sample/sample-config-files/office.up b/sample/sample-config-files/office.up
deleted file mode 100755
index 74a71a3..0000000
--- a/sample/sample-config-files/office.up
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/sh
-route add -net 10.0.1.0 netmask 255.255.255.0 gw $5
diff --git a/sample/sample-config-files/tls-home.conf b/sample/sample-config-files/tls-home.conf
deleted file mode 100644
index ff19d50..0000000
--- a/sample/sample-config-files/tls-home.conf
+++ /dev/null
@@ -1,83 +0,0 @@
-#
-# Sample OpenVPN configuration file for
-# home using SSL/TLS mode and RSA certificates/keys.
-#
-# '#' or ';' may be used to delimit comments.
-
-# Use a dynamic tun device.  For non-Linux OSes, you may want to use an
-# explicit unit number such as "tun1".
-# OpenVPN also supports virtual ethernet "tap" devices.
-dev tun
-
-# Our OpenVPN peer is the office gateway.
-remote 1.2.3.4
-
-# 10.1.0.2 is our local VPN endpoint (home).
-# 10.1.0.1 is our remote VPN endpoint (office).
-ifconfig 10.1.0.2 10.1.0.1
-
-# Our up script will establish routes
-# once the VPN is alive.
-up ./home.up
-
-# In SSL/TLS key exchange, Office will
-# assume server role and Home
-# will assume client role.
-tls-client
-
-# Certificate Authority file
-ca my-ca.crt
-
-# Our certificate/public key
-cert home.crt
-
-# Our private key
-key home.key
-
-# Our data channel cipher (must match peer config)
-cipher AES-256-GCM
-
-# OpenVPN 2.0 uses UDP port 1194 by default
-# (official port assignment by iana.org 11/04).
-# OpenVPN 1.x uses UDP port 5000 by default.
-# Each OpenVPN tunnel must use
-# a different port number.
-# lport or rport can be used
-# to denote different ports
-# for local and remote.
-; port 1194
-
-# Downgrade UID and GID to an
-# unpriviledged user after initialization
-# for extra security.
-; user openvpn
-; group openvpn
-
-# If you built OpenVPN with
-# LZO compression, uncomment
-# out the following line.
-; comp-lzo
-
-# Send a UDP ping to remote once
-# every 15 seconds to keep
-# stateful firewall connection
-# alive.  Uncomment this
-# out if you are using a stateful
-# firewall.
-; ping 15
-
-# Uncomment this section for a more reliable detection when a system
-# loses its connection.  For example, dial-ups or laptops that
-# travel to other locations.
-; ping 15
-; ping-restart 45
-; ping-timer-rem
-; persist-tun
-; persist-key
-
-# Verbosity level.
-# 0 -- quiet except for fatal errors.
-# 1 -- mostly quiet, but display non-fatal network errors.
-# 3 -- medium output, good for normal operation.
-# 9 -- verbose, good for troubleshooting
-verb 3
diff --git a/sample/sample-config-files/tls-office.conf b/sample/sample-config-files/tls-office.conf
deleted file mode 100644
index 152e58a..0000000
--- a/sample/sample-config-files/tls-office.conf
+++ /dev/null
@@ -1,86 +0,0 @@
-#
-# Sample OpenVPN configuration file for
-# office using SSL/TLS mode and RSA certificates/keys.
-#
-# '#' or ';' may be used to delimit comments.
-
-# Use a dynamic tun device.
-# For Linux 2.2 or non-Linux OSes,
-# you may want to use an explicit
-# unit number such as "tun1".
-# OpenVPN also supports virtual
-# ethernet "tap" devices.
-dev tun
-
-# 10.1.0.1 is our local VPN endpoint (office).
-# 10.1.0.2 is our remote VPN endpoint (home).
-ifconfig 10.1.0.1 10.1.0.2
-
-# Our up script will establish routes
-# once the VPN is alive.
-up ./office.up
-
-# In SSL/TLS key exchange, Office will
-# assume server role and Home
-# will assume client role.
-tls-server
-
-# Diffie-Hellman Parameters (tls-server only)
-dh dh2048.pem
-
-# Certificate Authority file
-ca my-ca.crt
-
-# Our certificate/public key
-cert office.crt
-
-# Our private key
-key office.key
-
-# Our data channel cipher (must match peer config)
-cipher AES-256-GCM
-
-# OpenVPN 2.0 uses UDP port 1194 by default
-# (official port assignment by iana.org 11/04).
-# OpenVPN 1.x uses UDP port 5000 by default.
-# Each OpenVPN tunnel must use
-# a different port number.
-# lport or rport can be used
-# to denote different ports
-# for local and remote.
-; port 1194
-
-# Downgrade UID and GID to an
-# unpriviledged user after initialization
-# for extra security.
-; user openvpn
-; group openvpn
-
-# If you built OpenVPN with
-# LZO compression, uncomment
-# out the following line.
-; comp-lzo
-
-# Send a UDP ping to remote once
-# every 15 seconds to keep
-# stateful firewall connection
-# alive.  Uncomment this
-# out if you are using a stateful
-# firewall.
-; ping 15
-
-# Uncomment this section for a more reliable detection when a system
-# loses its connection.  For example, dial-ups or laptops that
-# travel to other locations.
-; ping 15
-; ping-restart 45
-; ping-timer-rem
-; persist-tun
-; persist-key
-
-# Verbosity level.
-# 0 -- quiet except for fatal errors.
-# 1 -- mostly quiet, but display non-fatal network errors.
-# 3 -- medium output, good for normal operation.
-# 9 -- verbose, good for troubleshooting
-verb 3

