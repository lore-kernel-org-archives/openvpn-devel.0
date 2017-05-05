From: selva.nair@...277...
Date: Fri,  5 May 2017 14:24:01 -0400
Message-Id: <1494008642-7239-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] In auth-pam plugin clear the password
	after use
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

From: Selva Nair <selva.nair@...277...>

This adds a minimal secure_memzero()

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/plugins/auth-pam/auth-pam.c |  2 ++
 src/plugins/auth-pam/utils.h    | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index d3e2c89..10622fd 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -799,8 +799,10 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                         command);
                 goto done;
         }
+        secure_memzero(up.password, sizeof(up.password));
     }
 done:
+    secure_memzero(up.password, sizeof(up.password));
 
 #ifdef USE_PAM_DLOPEN
     dlclose_pam();
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index fbc9705..c1fa3ee 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -63,4 +63,20 @@ get_env(const char *name, const char *envp[]);
 int
 string_array_len(const char *array[]);
 
+/**
+ * Securely zero memory without letting optimized away by the compiler
+ *
+ * @param data  Pointer to data to fill with zero
+ * @param len   Length of data, in bytes.
+ */
+inline void
+secure_memzero(void *data, size_t len)
+{
+    volatile char *p = (volatile char *) data;
+    while (len--)
+    {
+        *p++ = 0;
+    }
+}
+
 #endif
-- 
2.1.4


