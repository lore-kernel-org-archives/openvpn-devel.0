From: selva.nair@...277...
Date: Wed, 27 Jul 2022 23:45:08 -0400
Message-Id: <20220728034508.15180-2-selva.nair@...277...>
In-Reply-To: <20220728034508.15180-1-selva.nair@...277...>
References: <20220728034508.15180-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Allow a few levels of recursion in
 virtual_output_callback()
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

Without this, replies to commands from the management client
are sometimes lost if the server is writing when a command
comes in and leads to a recursive call to this function.

For some reason I've not been able to trigger this on Linux,
but it does sometimes happen on Windows during intense write
activity by openvpn.exe sending log lines to the management
client.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/manage.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 27aa49a8..5670e594 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -312,8 +312,7 @@ virtual_output_callback_func(void *arg, const unsigned int flags, const char *st
 
 #define AF_DID_PUSH  (1<<0)
 #define AF_DID_RESET (1<<1)
-
-    if (!recursive_level) /* don't allow recursion */
+    if (recursive_level < 5) /* limit recursion */
     {
         struct gc_arena gc = gc_new();
         struct log_entry e;
@@ -380,6 +379,12 @@ virtual_output_callback_func(void *arg, const unsigned int flags, const char *st
 
         --recursive_level;
     }
+    else
+    {
+        /* cannot use msg here */
+        printf("virtual_output: message to management interface "
+               "dropped due to recursion: <%s>\n", str);
+    }
 }
 
 /*
-- 
2.30.2


