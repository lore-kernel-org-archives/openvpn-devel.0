From: Gert Doering <gert@...1296...>
Date: Tue,  3 Jun 2025 16:20:29 +0200
Message-ID: <20250603142035.13685-1-gert@...1296...>
In-Reply-To: <gerrit.1748876308000.I480442a55025bfcce7cb68ec7564ff33b0b780e2@...2715...>
References: <gerrit.1748876308000.I480442a55025bfcce7cb68ec7564ff33b0b780e2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] t_server_null: Test different
 permutations of --dh
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

Do not include --dh by default, since we do not actually
need it. Use the different servers for different ways
of specifying it.

Change-Id: I480442a55025bfcce7cb68ec7564ff33b0b780e2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1038
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index ca8004a..365b5a8 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -40,7 +40,7 @@
 SERVER_EXEC="${top_builddir}/src/openvpn/openvpn"
 SERVER_BASE_OPTS="--daemon --local 127.0.0.1 --dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
 SERVER_CIPHER_OPTS=""
-SERVER_CERT_OPTS="--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0"
+SERVER_CERT_OPTS="--ca ${CA} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0"
 SERVER_CONF_BASE="${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}"
 
 TEST_SERVER_LIST="1 2 3"
@@ -55,13 +55,13 @@
 SERVER_SERVER_2="--server 10.29.42.0 255.255.255.0"
 SERVER_MGMT_PORT_2="11195"
 SERVER_EXEC_2="${SERVER_EXEC}"
-SERVER_CONF_2="${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}"
+SERVER_CONF_2="${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2} --dh ${DH}"
 
 SERVER_NAME_3="t_server_null_server-1196_udp"
 SERVER_SERVER_3="--server 10.29.43.0 255.255.255.0"
 SERVER_MGMT_PORT_3="11196"
 SERVER_EXEC_3="${SERVER_EXEC}"
-SERVER_CONF_3="${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --cipher AES-192-CBC --data-ciphers DEFAULT:AES-192-CBC"
+SERVER_CONF_3="${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --dh none --cipher AES-192-CBC --data-ciphers DEFAULT:AES-192-CBC"
 
 # Test client configurations
 CLIENT_EXEC="${top_builddir}/src/openvpn/openvpn"

