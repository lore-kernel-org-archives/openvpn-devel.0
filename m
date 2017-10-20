From: selva.nair@...277...
Date: Fri, 20 Oct 2017 13:25:56 -0400
Message-Id: <1508520356-18277-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Avoid illegal memory access when malformed
 data is read from the pipe
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

- If only 1 byte is read from the interactive service client pipe, that
  evaluates to zero wide characters and subsequent check for NUL
  termination in the data buffer segfaults.
  Fix: reject clients that send less than a complete wide character.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index f3be113..0d162e8 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -466,6 +466,13 @@ GetStartupData(HANDLE pipe, STARTUP_DATA *sud)
     }
 
     size = bytes / sizeof(*data);
+    if (size == 0)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("malformed startup data: 1 byte received"));
+        ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
+        goto out;
+    }
+
     data = malloc(bytes);
     if (data == NULL)
     {
-- 
2.6.2


