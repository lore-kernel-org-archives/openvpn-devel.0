From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 27 Mar 2025 10:47:00 +0100
Message-Id: <20250327094700.305156-1-frank@...2641...>
In-Reply-To: <gerrit.1735303463000.I47d95eee8a00b9878331fd6cd6a7db12665f5537@...2715...>
References: <gerrit.1735303463000.I47d95eee8a00b9878331fd6cd6a7db12665f5537@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] t_server_null_default.rc: Add some tests
 with --data-ciphers
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
Cc: =?UTF-8?q?Samuli=20Sepp=C3=A4nen?= <sasepp@...2783...>

Trying to verify some of the negotiation parts.

Change-Id: I47d95eee8a00b9878331fd6cd6a7db12665f5537
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Samuli Seppänen <sasepp@...2783...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/847
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Samuli Seppänen <sasepp@...2783...>

        
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index e7bf5bc..ca8004a 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -1,3 +1,4 @@
+# -*- shell-script -*-
 # Notes regarding --dev null server and client configurations:
 #
 # The t_server_null_server.sh exits when all client pid files have gone
@@ -42,7 +43,7 @@
 SERVER_CERT_OPTS="--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0"
 SERVER_CONF_BASE="${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}"
 
-TEST_SERVER_LIST="1 2"
+TEST_SERVER_LIST="1 2 3"
 
 SERVER_NAME_1="t_server_null_server-1194_udp"
 SERVER_SERVER_1="--server 10.29.41.0 255.255.255.0"
@@ -56,6 +57,12 @@
 SERVER_EXEC_2="${SERVER_EXEC}"
 SERVER_CONF_2="${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}"
 
+SERVER_NAME_3="t_server_null_server-1196_udp"
+SERVER_SERVER_3="--server 10.29.43.0 255.255.255.0"
+SERVER_MGMT_PORT_3="11196"
+SERVER_EXEC_3="${SERVER_EXEC}"
+SERVER_CONF_3="${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --cipher AES-192-CBC --data-ciphers DEFAULT:AES-192-CBC"
+
 # Test client configurations
 CLIENT_EXEC="${top_builddir}/src/openvpn/openvpn"
 CLIENT_BASE_OPTS="--client --nobind --remote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-security 2"
@@ -65,7 +72,7 @@
 CLIENT_CIPHER_OPTS=""
 CLIENT_CERT_OPTS="--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1"
 
-TEST_RUN_LIST="1 1L 2 2L 3"
+TEST_RUN_LIST="1 1L 2 2L 3 4a 4b 4c"
 CLIENT_CONF_BASE="${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}"
 CLIENT_CONF_BASE_LWIP="${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}"
 
@@ -93,3 +100,24 @@
 SHOULD_PASS_3="no"
 CLIENT_EXEC_3="${CLIENT_EXEC}"
 CLIENT_CONF_3="${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto udp"
+
+# --data-cipher list against server with defaults
+# --cipher ignored
+TEST_NAME_4a="t_server_null_client.sh-openvpn_current_udp_dc1"
+SHOULD_PASS_4a="yes"
+CLIENT_EXEC_4a="${CLIENT_EXEC}"
+CLIENT_CONF_4a="${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT"
+
+# specific --data-cipher against server that supports that cipher
+# --cipher ignored
+TEST_NAME_4b="t_server_null_client.sh-openvpn_current_udp_dc3"
+SHOULD_PASS_4b="yes"
+CLIENT_EXEC_4b="${CLIENT_EXEC}"
+CLIENT_CONF_4b="${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC"
+
+# specific --data-cipher against server that doesn't support that cipher
+# --cipher ignored
+TEST_NAME_4c="t_server_null_client.sh-openvpn_current_udp_dc3_fail"
+SHOULD_PASS_4c="no"
+CLIENT_EXEC_4c="${CLIENT_EXEC}"
+CLIENT_CONF_4c="${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-192-CBC --data-ciphers AES-128-CBC"

