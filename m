From: Gert Doering <gert@...1296...>
Date: Thu, 21 Aug 2025 14:14:34 +0200
Message-ID: <20250821121442.30679-1-gert@...1296...>
In-Reply-To: <gerrit.1755776561000.I13ad2b7da6b008bc692b1f08f502fc3fc57e7206@...2715...>
References: <gerrit.1755776561000.I13ad2b7da6b008bc692b1f08f502fc3fc57e7206@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add sample FFDH parameters file and use
 that in t_server_null tests
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

Change-Id: I13ad2b7da6b008bc692b1f08f502fc3fc57e7206
Signed-off-by: Samuli Seppänen <sasepp@...2705...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1147
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/sample/sample-keys/ffdhe2048.pem b/sample/sample-keys/ffdhe2048.pem
new file mode 100644
index 0000000..9b182b7
--- /dev/null
+++ b/sample/sample-keys/ffdhe2048.pem
@@ -0,0 +1,8 @@
+-----BEGIN DH PARAMETERS-----
+MIIBCAKCAQEA//////////+t+FRYortKmq/cViAnPTzx2LnFg84tNpWp4TZBFGQz
++8yTnc4kmz75fS/jY2MMddj2gbICrsRhetPfHtXV/WVhJDP1H18GbtCFY2VVPe0a
+87VXE15/V8k1mE8McODmi3fipona8+/och3xWKE2rec1MKzKT0g6eXq8CrGCsyT7
+YdEIqUuyyOP7uWrat2DX9GgdT0Kj3jlN9K5W7edjcrsZCwenyO4KbXCeAvzhzffi
+7MA0BM0oNC9hkXL+nOmFg/+OTxIy7vKBg8P+OxtMb61zO7X8vC7CIAXFjvGDfRaD
+ssbzSibBsu/6iGtCOGEoXJf//////////wIBAg==
+-----END DH PARAMETERS-----
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 900f189..798cfd0 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -13,7 +13,7 @@
 top_builddir="${top_builddir:-..}"
 sample_keys="${srcdir}/../sample/sample-keys"
 
-DH="${sample_keys}/dh2048.pem"
+DH="${sample_keys}/ffdhe2048.pem"
 CA="${sample_keys}/ca.crt"
 CLIENT_CERT="${sample_keys}/client.crt"
 CLIENT_KEY="${sample_keys}/client.key"

