From: <steffan.karger@...1435...>
Date: Sun, 22 Feb 2015 15:11:08 +0100
Message-ID: <1424614268-5078-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Use tls-auth in sample config files
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

From: Steffan Karger <steffan.karger@...1435...>

For two reasons:
1) May motivate people to use tls-auth in their setups
2) Verify tls-auth functionality when running 'make check'

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 sample/sample-config-files/client.conf     |  2 +-
 sample/sample-config-files/loopback-client |  1 +
 sample/sample-config-files/loopback-server |  1 +
 sample/sample-config-files/server.conf     |  2 +-
 sample/sample-keys/gen-sample-keys.sh      |  3 +++
 sample/sample-keys/ta.key                  | 21 +++++++++++++++++++++
 6 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 sample/sample-keys/ta.key

diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
index 050ef60..fedcbd6 100644
--- a/sample/sample-config-files/client.conf
+++ b/sample/sample-config-files/client.conf
@@ -105,7 +105,7 @@ remote-cert-tls server
 
 # If a tls-auth key is used on the server
 # then every client must also have the key.
-;tls-auth ta.key 1
+tls-auth ta.key 1
 
 # Select a cryptographic cipher.
 # If the cipher option is used on the server
diff --git a/sample/sample-config-files/loopback-client b/sample/sample-config-files/loopback-client
index ebbd1cf..7117307 100644
--- a/sample/sample-config-files/loopback-client
+++ b/sample/sample-config-files/loopback-client
@@ -21,5 +21,6 @@ remote-cert-tls server
 ca sample-keys/ca.crt
 key sample-keys/client.key
 cert sample-keys/client.crt
+tls-auth sample-keys/ta.key 1
 ping 1
 inactive 120 10000000
diff --git a/sample/sample-config-files/loopback-server b/sample/sample-config-files/loopback-server
index 8cb97be..8e1f39c 100644
--- a/sample/sample-config-files/loopback-server
+++ b/sample/sample-config-files/loopback-server
@@ -21,5 +21,6 @@ dh sample-keys/dh2048.pem
 ca sample-keys/ca.crt
 key sample-keys/server.key
 cert sample-keys/server.crt
+tls-auth sample-keys/ta.key 0
 ping 1
 inactive 120 10000000
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
index 701be3c..c85ca0f 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -241,7 +241,7 @@ keepalive 10 120
 # a copy of this key.
 # The second parameter should be '0'
 # on the server and '1' on the clients.
-;tls-auth ta.key 0 # This file is secret
+tls-auth ta.key 0 # This file is secret
 
 # Select a cryptographic cipher.
 # This config item must be copied to
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index 414687e..725cfc9 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -14,6 +14,9 @@ then
     exit 1
 fi
 
+# Generate static key for tls-auth (or static key mode)
+$(dirname ${0})/../../src/openvpn/openvpn --genkey --secret ta.key
+
 # Create required directories and files
 mkdir -p sample-ca
 rm -f sample-ca/index.txt
diff --git a/sample/sample-keys/ta.key b/sample/sample-keys/ta.key
new file mode 100644
index 0000000..1669036
--- /dev/null
+++ b/sample/sample-keys/ta.key
@@ -0,0 +1,21 @@
+#
+# 2048 bit OpenVPN static key
+#
+-----BEGIN OpenVPN Static key V1-----
+a863b1cbdb911ff4ef3360ce135157e7
+241a465f5045f51cf9a92ebc24da34fd
+5fc48456778c977e374d55a8a7298aef
+40d0ab0c60b5e09838510526b73473a0
+8da46a8c352572dd86d4a871700a915b
+6aaa58a9dac560db2dfdd7ef15a202e1
+fca6913d7ee79c678c5798fbf7bd920c
+caa7a64720908da7254598b052d07f55
+5e31dc5721932cffbdd8965d04107415
+46c86823da18b66aab347e4522cc05ff
+634968889209c96b1024909cd4ce574c
+f829aa9c17d5df4a66043182ee23635d
+8cabf5a7ba02345ad94a3aa25a63d55c
+e13f4ad235a0825e3fe17f9419baff1c
+e73ad1dd652f1e48c7102fe8ee181e54
+10a160ae255f63fd01db1f29e6efcb8e
+-----END OpenVPN Static key V1-----
-- 
2.1.0


