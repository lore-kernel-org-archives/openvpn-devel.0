From: luca.boccassi@...277...
Date: Sun, 15 Mar 2026 23:05:31 +0000
Message-ID: <20260315230620.1594780-4-luca.boccassi@...277...>
In-Reply-To: <20260315230620.1594780-1-luca.boccassi@...277...>
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315230620.1594780-1-luca.boccassi@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 3/3] Ensure the management channel can
 take passwords up to the max length
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
Cc: Luca Boccassi <luca.boccassi@...277...>

From: Luca Boccassi <luca.boccassi@...277...>

These hardcoded limits are different than the password size limit.
Use the macro to ensure a password can always fit via the management
channel, otherwise when long passwords are used (e.g.: tokens) they
will be silently dropped.

Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
---
 src/openvpn/manage.c  | 4 ++--
 src/openvpn/options.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index df72f15f..5cb25107 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2653,9 +2653,9 @@ man_connection_init(struct management *man)
 
         /*
          * Allocate helper objects for command line input and
-         * command output from/to the socket.
+         * command output from/to the socket. Ensure a password cat fit.
          */
-        man->connection.in = command_line_new(1024);
+        man->connection.in = command_line_new(USER_PASS_LEN);
         man->connection.out = buffer_list_new();
 
         /*
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3d8b5059..4fafdc52 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -51,10 +51,10 @@
 #define MAX_PARMS 16
 
 /*
- * Max size of options line and parameter.
+ * Max size of options line and parameter. Ensure a password can fit.
  */
-#define OPTION_PARM_SIZE 256
-#define OPTION_LINE_SIZE 256
+#define OPTION_PARM_SIZE USER_PASS_LEN
+#define OPTION_LINE_SIZE USER_PASS_LEN
 
 extern const char title_string[];
 
-- 
2.47.3


