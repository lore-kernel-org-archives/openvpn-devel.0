From: Gert Doering <gert@...1296...>
Date: Tue,  8 Jul 2025 09:33:51 +0200
Message-ID: <20250708073359.32549-1-gert@...1296...>
In-Reply-To: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
References: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] t_server_null: add multi-socket testing
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

From: Samuli Seppänen <samuli.seppanen@...277...>

This adds a new multi-socket server that listens on IPv4 and IPv6
localhost addresses for TCP and UDP connections respectively. It also
adds two success tests and one failure test with wrong protocol defined
at the client side.

Change-Id: I4ebe1158c36a641888131e824f59004a0f8fb4c5
Signed-off-by: Samuli Seppänen <sasepp@...2705...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/919
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 41ec591..a1c68cd 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -38,12 +38,14 @@
 MAX_CLIENTS="10"
 CLIENT_MATCH="Test-Client"
 SERVER_EXEC="${top_builddir}/src/openvpn/openvpn"
-SERVER_BASE_OPTS="--local 127.0.0.1 --dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
+SERVER_BASE_OPTS="--dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
+SERVER_BIND_OPTS="--local 127.0.0.1"
 SERVER_CIPHER_OPTS=""
 SERVER_CERT_OPTS="--ca ${CA} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0"
-SERVER_CONF_BASE="${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}"
+SERVER_CONF_BASE="${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS} ${SERVER_BIND_OPTS}"
+SERVER_CONF_BASE_MULTISOCKET="${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}"
 
-TEST_SERVER_LIST="1 2 3"
+TEST_SERVER_LIST="1 2 3 4"
 
 SERVER_NAME_1="t_server_null_server-1194_udp"
 SERVER_SERVER_1="--server 10.29.41.0 255.255.255.0"
@@ -63,6 +65,12 @@
 SERVER_EXEC_3="${SERVER_EXEC}"
 SERVER_CONF_3="${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --dh none --cipher AES-192-CBC --data-ciphers DEFAULT:AES-192-CBC"
 
+SERVER_NAME_4="t_server_null_server-1197_multisocket_ipv4_ipv6"
+SERVER_SERVER_4="--server 10.29.44.0 255.255.255.0"
+SERVER_MGMT_PORT_4="11197"
+SERVER_EXEC_4="${SERVER_EXEC}"
+SERVER_CONF_4="${SERVER_CONF_BASE_MULTISOCKET} ${SERVER_SERVER_4} --local 127.0.0.1 1197 tcp --local ::1 1197 udp --management 127.0.0.1 ${SERVER_MGMT_PORT_4}"
+
 # Test client configurations
 CLIENT_EXEC="${top_builddir}/src/openvpn/openvpn"
 CLIENT_BASE_OPTS="--client --nobind --remote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-security 2"
@@ -72,7 +80,7 @@
 CLIENT_CIPHER_OPTS=""
 CLIENT_CERT_OPTS="--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1"
 
-TEST_RUN_LIST="1 1L 2 2L 3 4a 4b 4c"
+TEST_RUN_LIST="1 1L 2 2L 3 4a 4b 4c 5a 5b 5c"
 CLIENT_CONF_BASE="${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}"
 CLIENT_CONF_BASE_LWIP="${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}"
 
@@ -121,3 +129,18 @@
 SHOULD_PASS_4c="no"
 CLIENT_EXEC_4c="${CLIENT_EXEC}"
 CLIENT_CONF_4c="${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-192-CBC --data-ciphers AES-128-CBC"
+
+TEST_NAME_5a="t_server_null_client.sh-openvpn_current_multisocket_ipv4_tcp"
+SHOULD_PASS_5a="yes"
+CLIENT_EXEC_5a="${CLIENT_EXEC}"
+CLIENT_CONF_5a="${CLIENT_CONF_BASE} --remote 127.0.0.1 1197 tcp"
+
+TEST_NAME_5b="t_server_null_client.sh-openvpn_current_multisocket_ipv6_udp"
+SHOULD_PASS_5b="yes"
+CLIENT_EXEC_5b="${CLIENT_EXEC}"
+CLIENT_CONF_5b="${CLIENT_CONF_BASE} --remote ::1 1197 udp"
+
+TEST_NAME_5c="t_server_null_client.sh-openvpn_current_multisocket_ipv6_tcp_fail"
+SHOULD_PASS_5c="no"
+CLIENT_EXEC_5c="${CLIENT_EXEC}"
+CLIENT_CONF_5c="${CLIENT_CONF_BASE} --remote ::1 1197 tcp"

