From: Gert Doering <gert@...1296...>
Date: Wed, 18 Jun 2025 16:13:21 +0200
Message-ID: <20250618141328.4600-1-gert@...1296...>
In-Reply-To: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
References: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] t_server_null: print error when server
 startup fails
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

Use "&" to background so that the exit code and all output can be
obtained in all failure cases.

Change-Id: I39dc6b08952a06dae7901e468f9487c8541d83c3
Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1024
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 5b74761..1f2fa2c 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -38,7 +38,7 @@
 MAX_CLIENTS="10"
 CLIENT_MATCH="Test-Client"
 SERVER_EXEC="${top_builddir}/src/openvpn/openvpn"
-SERVER_BASE_OPTS="--daemon --dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
+SERVER_BASE_OPTS="--dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
 SERVER_BIND_OPTS="--local 127.0.0.1"
 SERVER_CIPHER_OPTS=""
 SERVER_CERT_OPTS="--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0"
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index acf8479..65b7d56 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -11,20 +11,18 @@
     # Allow reading this file even umask values are strict
     touch "$log"
 
-    if [ -z "${RUN_SUDO}" ]; then
-        "${server_exec}" \
-         $server_conf \
-         --status "${status}" 1 \
-         --log "${log}" \
-         --writepid "${pid}" \
-         --explicit-exit-notify 3
-    else
-        $RUN_SUDO "${server_exec}" \
-                   $server_conf \
-                   --status "${status}" 1 \
-                   --log "${log}" \
-                   --writepid "${pid}" \
-                   --explicit-exit-notify 3
+    # Try to launch the server
+    $RUN_SUDO "${server_exec}" \
+               $server_conf \
+               --status "${status}" 1 \
+               --writepid "${pid}" \
+               --explicit-exit-notify 3 > "$log" 2>&1 &
+
+    sleep 1
+
+    if ! [ -r "$pid" ] || [ -z "$pid" ]; then
+        echo "ERROR: failed to start server $server_name"
+        tail -n 20 "$log"
     fi
 }
 

