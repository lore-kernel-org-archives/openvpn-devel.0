From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:37:27 +0200
Message-Id: <1330547854-18889-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
References: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [tap-windows 04/11] debug: add DbgPrint support
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/error.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/error.c b/src/error.c
index 5b25f48..0541bc3 100755
--- a/src/error.c
+++ b/src/error.c
@@ -81,6 +81,11 @@ MyDebugPrint (const unsigned char* format, ...)
 	      NTSTATUS status;
 	      char *end;
 
+#ifdef DBG_PRINT
+	      va_start (args, format);
+	      vDbgPrintEx (DPFLTR_IHVNETWORK_ID, DPFLTR_INFO_LEVEL, format, args);
+	      va_end (args);
+#endif
 	      va_start (args, format);
 	      status = RtlStringCchVPrintfExA (g_Debug.text + g_Debug.out,
 					       remaining,
-- 
1.7.3.4


