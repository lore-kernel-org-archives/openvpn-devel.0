From: Richard T Bonhomme <stringvest88@...277...>
Date: Thu, 29 Apr 2021 18:15:04 +0100
Message-Id: <20210429171504.1081888-1-tincantech@...2282...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add daemon_pid to --tls-crypt-v2-verify
 environment
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

From: string vest <stringvest88@...277...>

Under Windows, programmatically retrieving the parent process ID of
the openvpn instance which called a script is practically impossible.
The only sensible way, currently available, is to write a PID file.

This patch adds a single integer variable, named daemon_pid, to the
script environment. The value of which is set to the openvpn process
ID that called the script.

Providing this variable via the running openvpn process is more secure,
faster and far less prone to user-error than using a PID file.

Signed-off-by: Richard T Bonhomme <tincantech@...2282...>
---
 src/openvpn/tls_crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 7b5016d3..23d93a6c 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -537,6 +537,7 @@ tls_crypt_v2_verify_metadata(const struct tls_wrap_ctx *ctx,
     setenv_str(es, "script_type", "tls-crypt-v2-verify");
     setenv_str(es, "metadata_type", metadata_type_str);
     setenv_str(es, "metadata_file", tmp_file);
+    setenv_int(es, "daemon_pid", platform_getpid());
 
     struct argv argv = argv_new();
     argv_parse_cmd(&argv, opt->tls_crypt_v2_verify_script);
-- 
2.25.1


