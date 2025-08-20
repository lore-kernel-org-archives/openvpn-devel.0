From: Gert Doering <gert@...1296...>
Date: Wed, 20 Aug 2025 19:54:53 +0200
Message-ID: <20250820175459.11227-1-gert@...1296...>
In-Reply-To: <gerrit.1755702161000.If66438662bd862a195b2a69c4fa45f63838982b7@...2715...>
References: <gerrit.1755702161000.If66438662bd862a195b2a69c4fa45f63838982b7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Remove use of 'dh dh2048.pem' from
 sample configs, remove 'dh2048.pem' file
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

Since commit bd9aa06feb41 (Jan 2015) OpenVPN has allowed to use
'--dh none' to disable traditional Diffie Hellman, since more secure
ECDH algorithms are available that do not use explicit DH parameters.

If configured with a suffiently high securelevel (3+), or if running in
FIPS mode, OpenSSL 3.5 will refuse 2048 bit DH files, making our tests
fail.

Thus, remove all the DH2048 stuff from our sample configs.

Github: triggered by OpenVPN/openvpn#819

Change-Id: If66438662bd862a195b2a69c4fa45f63838982b7
Signed-off-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1145
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/doc/tests/authentication-plugins.md b/doc/tests/authentication-plugins.md
index b47c544..45fa381 100644
--- a/doc/tests/authentication-plugins.md
+++ b/doc/tests/authentication-plugins.md
@@ -36,7 +36,7 @@
       verb 4
       dev tun
       server 10.8.0.0 255.255.255.0
-      dh sample/sample-keys/dh2048.pem
+      dh none
       ca sample/sample-keys/ca.crt
       cert sample/sample-keys/server.crt
       key sample/sample-keys/server.key
diff --git a/sample/sample-config-files/loopback-server b/sample/sample-config-files/loopback-server
index 58daeb56..1980218 100644
--- a/sample/sample-config-files/loopback-server
+++ b/sample/sample-config-files/loopback-server
@@ -17,7 +17,7 @@
 verb 3
 reneg-sec 10
 tls-server
-dh sample-keys/dh2048.pem
+dh none
 ca sample-keys/ca.crt
 key sample-keys/server.key
 cert sample-keys/server.crt
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
index f6d9e65..8943c34 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -87,11 +87,6 @@
 cert server.crt
 key server.key  # This file should be kept secret
 
-# Diffie hellman parameters.
-# Generate your own with:
-#   openssl dhparam -out dh2048.pem 2048
-dh dh2048.pem
-
 # Allow to connect to really old OpenVPN versions
 # without AEAD support (OpenVPN 2.3.x or older)
 # This adds AES-256-CBC as fallback cipher and
@@ -306,4 +301,4 @@
 
 # Notify the client that when the server restarts so it
 # can automatically reconnect.
-explicit-exit-notify 1
\ No newline at end of file
+explicit-exit-notify 1
diff --git a/sample/sample-keys/dh2048.pem b/sample/sample-keys/dh2048.pem
deleted file mode 100644
index d393581..0000000
--- a/sample/sample-keys/dh2048.pem
+++ /dev/null
@@ -1,8 +0,0 @@
------BEGIN DH PARAMETERS-----
-MIIBCAKCAQEAgGOVdT2c3GUITi1pF9u+yo72PRBW7I7SnNIsHmXCRYibpyPMGxKM
-ROK6rduMllC0CjiXQZhMfqCg+GIca9xxBPKtTnwtKWD3eH5wgs24kw86mODITjJk
-6lTNM8it2HY4UuIQoFCqCdt5f5Gwgh2nwU5+dy731md6pmw9x9jUEXoyh67CeZfb
-C45x5ttzjpSBvYe5ZIiUypYKumYhdiZhk0RLefEtlUYF9oXrUExDqfYDpSO/1/X3
-oHC0O0EV3Lh1boZTG7+FjcvMYLIKYUDTmxHpII6/OAHhprg7U9ui1i7GyQRv1lze
-QV3FGO4UwLntnv352iYy91b0ls2mwD+zTwIBAg==
------END DH PARAMETERS-----
diff --git a/sample/sample-plugins/keying-material-exporter-demo/server.ovpn b/sample/sample-plugins/keying-material-exporter-demo/server.ovpn
index 5c670b1..1aabcb9 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/server.ovpn
+++ b/sample/sample-plugins/keying-material-exporter-demo/server.ovpn
@@ -8,7 +8,7 @@
 ca     ../../sample-keys/ca.crt
 cert   ../../sample-keys/server.crt
 key    ../../sample-keys/server.key
-dh     ../../sample-keys/dh2048.pem
+dh     none
 
 server 10.8.0.0 255.255.255.0
 port 1194

