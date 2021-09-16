From: stringvest88@...277...
Date: Thu, 16 Sep 2021 17:46:41 +0100
Message-Id: <20210916164641.867248-1-tincantech@...2282...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Correct --client-disconnect environment
 variable common_name
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

From: Richard T Bonhomme <tincantech@...2282...>

--client-disconnect is always passed the X509 certificate common_name,
which is incorrect when --username-as-common-name is used.

Set the environment variable common_name to the correct value, prior to
calling --client-disconnect.

Resolves https://community.openvpn.net/openvpn/ticket/160

Signed-off-by: Richard T Bonhomme <tincantech@...2282...>
---
 src/openvpn/multi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 22357cfb..18ee5e52 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -557,6 +557,9 @@ setenv_stats(struct context *c)
 static void
 multi_client_disconnect_setenv(struct multi_instance *mi)
 {
+    /* setenv client current common-name */
+    setenv_str(mi->context.c2.es, "common_name", tls_common_name(mi->context.c2.tls_multi, true));
+
     /* setenv client real IP address */
     setenv_trusted(mi->context.c2.es, get_link_socket_info(&mi->context));
 
-- 
2.25.1


