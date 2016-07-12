From: Arne Schwabe <arne@...1227...>
Date: Tue, 12 Jul 2016 11:14:08 +0200
Message-Id: <1468314848-11820-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Use AES ciphers in our sample configuration
	files and add a few modern 2.4 examples
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 sample/sample-config-files/client.conf        |  8 ++++++--
 sample/sample-config-files/server.conf        | 23 +++++++++++++++++------
 sample/sample-config-files/static-home.conf   |  3 +++
 sample/sample-config-files/static-office.conf |  3 +++
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
index fedcbd6..d8dfd96 100644
--- a/sample/sample-config-files/client.conf
+++ b/sample/sample-config-files/client.conf
@@ -110,12 +110,16 @@ tls-auth ta.key 1
 # Select a cryptographic cipher.
 # If the cipher option is used on the server
 # then you must also specify it here.
-;cipher x
+# Note that 2.4 client/server will automatically
+# negoiate AES-256-GCM in TLS mode. 
+# See also the ncp-cipher option in the manpage
+cipher AES-256-CBC
+
 
 # Enable compression on the VPN link.
 # Don't enable this unless it is also
 # enabled in the server config file.
-comp-lzo
+#comp-lzo
 
 # Set log file verbosity.
 verb 3
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
index c85ca0f..79e1234 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -246,14 +246,21 @@ tls-auth ta.key 0 # This file is secret
 # Select a cryptographic cipher.
 # This config item must be copied to
 # the client config file as well.
-;cipher BF-CBC        # Blowfish (default)
-;cipher AES-128-CBC   # AES
-;cipher DES-EDE3-CBC  # Triple-DES
-
-# Enable compression on the VPN link.
+# Note that 2.4 client/server will automatically
+# negoiate AES-256-GCM in TLS mode. 
+# See also the ncp-cipher option in the manpage
+cipher AES-256-CBC
+
+# Enable compression on the VPN link and push the
+# option to the client (2.4+ only, for earlier
+# versions see below)
+;compress lz4-v2
+;push "compress lz4-v2"
+
+# For compression compatible with older clients use comp-lzo
 # If you enable it here, you must also
 # enable it in the client config file.
-comp-lzo
+;comp-lzo
 
 # The maximum number of concurrently connected
 # clients we want to allow.
@@ -302,3 +309,7 @@ verb 3
 # sequential messages of the same message
 # category will be output to the log.
 ;mute 20
+
+# Notify the client that when the server restarts so it
+# can automatically reconnect.
+explicit-exit-notify 1
\ No newline at end of file
diff --git a/sample/sample-config-files/static-home.conf b/sample/sample-config-files/static-home.conf
index c966687..ed0c672 100644
--- a/sample/sample-config-files/static-home.conf
+++ b/sample/sample-config-files/static-home.conf
@@ -26,6 +26,9 @@ up ./home.up
 # Our pre-shared static key
 secret static.key
 
+# Cipher to use
+cipher AES-256-CBC
+
 # OpenVPN 2.0 uses UDP port 1194 by default
 # (official port assignment by iana.org 11/04).
 # OpenVPN 1.x uses UDP port 5000 by default.
diff --git a/sample/sample-config-files/static-office.conf b/sample/sample-config-files/static-office.conf
index 68030cc..609ddd0 100644
--- a/sample/sample-config-files/static-office.conf
+++ b/sample/sample-config-files/static-office.conf
@@ -23,6 +23,9 @@ up ./office.up
 # Our pre-shared static key
 secret static.key
 
+# Cipher to use
+cipher AES-256-CBC
+
 # OpenVPN 2.0 uses UDP port 1194 by default
 # (official port assignment by iana.org 11/04).
 # OpenVPN 1.x uses UDP port 5000 by default.
-- 
2.7.4 (Apple Git-66)


