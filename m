From: Steffan Karger <steffan@...1856...>
Date: Sat,  9 Nov 2019 18:42:35 +0100
Message-Id: <20191109174235.20511-1-steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update sample configs to use modern cipher,
 remove static key examples
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

Since these are examples, people might use them as a basis for their own
configs. In the non-push/pull configs, we should specify a decent cipher.

Further, I don't think we should recommend anyone to still use a static key
configuration, so remove the static key config examples.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 sample/sample-config-files/loopback-client    |  1 +
 sample/sample-config-files/loopback-server    |  1 +
 sample/sample-config-files/static-home.conf   | 75 -------------------
 sample/sample-config-files/static-office.conf | 72 ------------------
 sample/sample-config-files/tls-home.conf      | 12 +--
 sample/sample-config-files/tls-office.conf    |  3 +
 6 files changed, 11 insertions(+), 153 deletions(-)
 delete mode 100644 sample/sample-config-files/static-home.conf
 delete mode 100644 sample/sample-config-files/static-office.conf

diff --git a/sample/sample-config-files/loopback-client b/sample/sample-config-files/loopback-client
index 7117307d..1734aa8b 100644
--- a/sample/sample-config-files/loopback-client
+++ b/sample/sample-config-files/loopback-client
@@ -22,5 +22,6 @@ ca sample-keys/ca.crt
 key sample-keys/client.key
 cert sample-keys/client.crt
 tls-auth sample-keys/ta.key 1
+cipher AES-256-GCM
 ping 1
 inactive 120 10000000
diff --git a/sample/sample-config-files/loopback-server b/sample/sample-config-files/loopback-server
index 8e1f39cd..58daeb56 100644
--- a/sample/sample-config-files/loopback-server
+++ b/sample/sample-config-files/loopback-server
@@ -22,5 +22,6 @@ ca sample-keys/ca.crt
 key sample-keys/server.key
 cert sample-keys/server.crt
 tls-auth sample-keys/ta.key 0
+cipher AES-256-GCM
 ping 1
 inactive 120 10000000
diff --git a/sample/sample-config-files/static-home.conf b/sample/sample-config-files/static-home.conf
deleted file mode 100644
index ed0c6726..00000000
--- a/sample/sample-config-files/static-home.conf
+++ /dev/null
@@ -1,75 +0,0 @@
-#
-# Sample OpenVPN configuration file for
-# home using a pre-shared static key.
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
-# Our pre-shared static key
-secret static.key
-
-# Cipher to use
-cipher AES-256-CBC
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
-# Downgrade UID and GID to
-# "nobody" after initialization
-# for extra security.
-; user nobody
-; group nobody
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
diff --git a/sample/sample-config-files/static-office.conf b/sample/sample-config-files/static-office.conf
deleted file mode 100644
index 609ddd02..00000000
--- a/sample/sample-config-files/static-office.conf
+++ /dev/null
@@ -1,72 +0,0 @@
-#
-# Sample OpenVPN configuration file for
-# office using a pre-shared static key.
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
-# Our pre-shared static key
-secret static.key
-
-# Cipher to use
-cipher AES-256-CBC
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
-# Downgrade UID and GID to
-# "nobody" after initialization
-# for extra security.
-; user nobody
-; group nobody
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
diff --git a/sample/sample-config-files/tls-home.conf b/sample/sample-config-files/tls-home.conf
index daa4ea1e..3a9297cc 100644
--- a/sample/sample-config-files/tls-home.conf
+++ b/sample/sample-config-files/tls-home.conf
@@ -4,12 +4,9 @@
 #
 # '#' or ';' may be used to delimit comments.
 
-# Use a dynamic tun device.
-# For Linux 2.2 or non-Linux OSes,
-# you may want to use an explicit
-# unit number such as "tun1".
-# OpenVPN also supports virtual
-# ethernet "tap" devices.
+# Use a dynamic tun device.  For non-Linux OSes, you may want to use an
+# explicit unit number such as "tun1".
+# OpenVPN also supports virtual ethernet "tap" devices.
 dev tun
 
 # Our OpenVPN peer is the office gateway.
@@ -37,6 +34,9 @@ cert home.crt
 # Our private key
 key home.key
 
+# Our data channel cipher (must match peer config)
+cipher AES-256-GCM
+
 # OpenVPN 2.0 uses UDP port 1194 by default
 # (official port assignment by iana.org 11/04).
 # OpenVPN 1.x uses UDP port 5000 by default.
diff --git a/sample/sample-config-files/tls-office.conf b/sample/sample-config-files/tls-office.conf
index d1961444..81052211 100644
--- a/sample/sample-config-files/tls-office.conf
+++ b/sample/sample-config-files/tls-office.conf
@@ -37,6 +37,9 @@ cert office.crt
 # Our private key
 key office.key
 
+# Our data channel cipher (must match peer config)
+cipher AES-256-GCM
+
 # OpenVPN 2.0 uses UDP port 1194 by default
 # (official port assignment by iana.org 11/04).
 # OpenVPN 1.x uses UDP port 5000 by default.
-- 
2.20.1


