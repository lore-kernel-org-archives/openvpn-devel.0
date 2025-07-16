From: Gert Doering <gert@...1296...>
Date: Wed, 16 Jul 2025 18:56:49 +0200
Message-ID: <20250716165656.18887-1-gert@...1296...>
In-Reply-To: <gerrit.1752565606000.I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75@...2715...>
References: <gerrit.1752565606000.I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] t_server_null: match test numbers with
 server numbers
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

From: Samuli Seppänen <sasepp@...2705...>

This makes it obvious which server each test connects to

Change-Id: I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75
Signed-off-by: Samuli Seppänen <sasepp@...2705...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1086
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index a1c68cd..900f189 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -80,67 +80,67 @@
 CLIENT_CIPHER_OPTS=""
 CLIENT_CERT_OPTS="--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1"
 
-TEST_RUN_LIST="1 1L 2 2L 3 4a 4b 4c 5a 5b 5c"
+TEST_RUN_LIST="1a 1b 1c 1L 2a 2L 3a 3b 4a 4b 4c"
 CLIENT_CONF_BASE="${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}"
 CLIENT_CONF_BASE_LWIP="${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}"
 
-TEST_NAME_1="t_server_null_client.sh-openvpn_current_udp"
-SHOULD_PASS_1="yes"
-CLIENT_EXEC_1="${CLIENT_EXEC}"
-CLIENT_CONF_1="${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp"
+TEST_NAME_1a="t_server_null_client.sh-openvpn_current_udp"
+SHOULD_PASS_1a="yes"
+CLIENT_EXEC_1a="${CLIENT_EXEC}"
+CLIENT_CONF_1a="${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp"
+
+TEST_NAME_1b="t_server_null_client.sh-openvpn_current_udp_fail"
+SHOULD_PASS_1b="no"
+CLIENT_EXEC_1b="${CLIENT_EXEC}"
+CLIENT_CONF_1b="${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto udp"
+
+# --data-cipher list against server with defaults
+# --cipher ignored
+TEST_NAME_1c="t_server_null_client.sh-openvpn_current_udp_dc1"
+SHOULD_PASS_1c="yes"
+CLIENT_EXEC_1c="${CLIENT_EXEC}"
+CLIENT_CONF_1c="${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT"
 
 TEST_NAME_1L="t_server_null_client.sh-openvpn_current_udp_lwip"
 SHOULD_PASS_1L="yes"
 CLIENT_EXEC_1L="${CLIENT_EXEC}"
 CLIENT_CONF_1L="${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 udp --proto udp"
 
-TEST_NAME_2="t_server_null_client.sh-openvpn_current_tcp"
-SHOULD_PASS_2="yes"
-CLIENT_EXEC_2="${CLIENT_EXEC}"
-CLIENT_CONF_2="${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto tcp"
+TEST_NAME_2a="t_server_null_client.sh-openvpn_current_tcp"
+SHOULD_PASS_2a="yes"
+CLIENT_EXEC_2a="${CLIENT_EXEC}"
+CLIENT_CONF_2a="${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto tcp"
 
 TEST_NAME_2L="t_server_null_client.sh-openvpn_current_tcp_lwip"
 SHOULD_PASS_2L="yes"
 CLIENT_EXEC_2L="${CLIENT_EXEC}"
 CLIENT_CONF_2L="${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1195 tcp --proto tcp"
 
-TEST_NAME_3="t_server_null_client.sh-openvpn_current_udp_fail"
-SHOULD_PASS_3="no"
-CLIENT_EXEC_3="${CLIENT_EXEC}"
-CLIENT_CONF_3="${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto udp"
-
-# --data-cipher list against server with defaults
-# --cipher ignored
-TEST_NAME_4a="t_server_null_client.sh-openvpn_current_udp_dc1"
-SHOULD_PASS_4a="yes"
-CLIENT_EXEC_4a="${CLIENT_EXEC}"
-CLIENT_CONF_4a="${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT"
-
 # specific --data-cipher against server that supports that cipher
 # --cipher ignored
-TEST_NAME_4b="t_server_null_client.sh-openvpn_current_udp_dc3"
-SHOULD_PASS_4b="yes"
-CLIENT_EXEC_4b="${CLIENT_EXEC}"
-CLIENT_CONF_4b="${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC"
+TEST_NAME_3a="t_server_null_client.sh-openvpn_current_udp_dc3"
+SHOULD_PASS_3a="yes"
+CLIENT_EXEC_3a="${CLIENT_EXEC}"
+CLIENT_CONF_3a="${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC"
 
 # specific --data-cipher against server that doesn't support that cipher
 # --cipher ignored
-TEST_NAME_4c="t_server_null_client.sh-openvpn_current_udp_dc3_fail"
+TEST_NAME_3b="t_server_null_client.sh-openvpn_current_udp_dc3_fail"
+SHOULD_PASS_3b="no"
+CLIENT_EXEC_3b="${CLIENT_EXEC}"
+CLIENT_CONF_3b="${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-192-CBC --data-ciphers AES-128-CBC"
+
+TEST_NAME_4a="t_server_null_client.sh-openvpn_current_multisocket_ipv4_tcp"
+SHOULD_PASS_4a="yes"
+CLIENT_EXEC_4a="${CLIENT_EXEC}"
+CLIENT_CONF_4a="${CLIENT_CONF_BASE} --remote 127.0.0.1 1197 tcp"
+
+TEST_NAME_4b="t_server_null_client.sh-openvpn_current_multisocket_ipv6_udp"
+SHOULD_PASS_4b="yes"
+CLIENT_EXEC_4b="${CLIENT_EXEC}"
+CLIENT_CONF_4b="${CLIENT_CONF_BASE} --remote ::1 1197 udp"
+
+TEST_NAME_4c="t_server_null_client.sh-openvpn_current_multisocket_ipv6_tcp_fail"
 SHOULD_PASS_4c="no"
 CLIENT_EXEC_4c="${CLIENT_EXEC}"
-CLIENT_CONF_4c="${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-192-CBC --data-ciphers AES-128-CBC"
-
-TEST_NAME_5a="t_server_null_client.sh-openvpn_current_multisocket_ipv4_tcp"
-SHOULD_PASS_5a="yes"
-CLIENT_EXEC_5a="${CLIENT_EXEC}"
-CLIENT_CONF_5a="${CLIENT_CONF_BASE} --remote 127.0.0.1 1197 tcp"
-
-TEST_NAME_5b="t_server_null_client.sh-openvpn_current_multisocket_ipv6_udp"
-SHOULD_PASS_5b="yes"
-CLIENT_EXEC_5b="${CLIENT_EXEC}"
-CLIENT_CONF_5b="${CLIENT_CONF_BASE} --remote ::1 1197 udp"
-
-TEST_NAME_5c="t_server_null_client.sh-openvpn_current_multisocket_ipv6_tcp_fail"
-SHOULD_PASS_5c="no"
-CLIENT_EXEC_5c="${CLIENT_EXEC}"
-CLIENT_CONF_5c="${CLIENT_CONF_BASE} --remote ::1 1197 tcp"
+CLIENT_CONF_4c="${CLIENT_CONF_BASE} --remote ::1 1197 tcp"

