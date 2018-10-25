From: selva.nair@...277...
Date: Wed, 24 Oct 2018 23:05:16 -0400
Message-Id: <1540436716-5725-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Declare Windows version of openvpn_execve()
 before use
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

From: Selva Nair <selva.nair@...277...>

commit bf97c00f7dba441b504881f38e40afcbb610a39f moved
the generic openvpn_execve() to run_command.c and made it static.
But the Windows version is still in win32.c and is called from
run_command.c

Fix by declaring the function in win32.h

Signed-off-by: Selva Nair <selva.nair@...277...>
---
This is an easy way out. In the spirit of commit bf97c00f7db, the
entire win32 version of openvpn_execve() could move to run_command.c
and become static. That will also require pulling wide_cmd_line()
and env_block() out of win32.c.

 src/openvpn/win32.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index b5cbe25..4b4524f 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -27,6 +27,7 @@
 
 #include "mtu.h"
 #include "openvpn-msg.h"
+#include "argv.h"
 
 /* location of executables */
 #define SYS_PATH_ENV_VAR_NAME "SystemRoot"  /* environmental variable name that normally contains the system path */
@@ -316,5 +317,11 @@ const char *win32_version_string(struct gc_arena *gc, bool add_name);
 bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
                        ack_message_t *ack, const char *context);
 
+/*
+ * Attempt to simulate fork/execve on Windows
+ */
+int
+openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
+
 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
-- 
2.6.2


