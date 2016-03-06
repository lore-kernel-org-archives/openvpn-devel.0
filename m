From: Selva Nair <selva.nair@...277...>
Date: Sun,  6 Mar 2016 00:22:02 -0500
Message-Id: <1457241722-23433-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1457241559-23374-1-git-send-email-selva.nair@...277...>
References: <1457241559-23374-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] Use appropriate buffer size for
	WideCharToMultiByte output in interactive.c
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

A widechar can potentially take more than 2 bytes in UTF-8.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 39397d1..6a7227b 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1063,17 +1063,16 @@ RunOpenvpn (LPVOID p)
   CloseHandleEx (&stdin_read);
   CloseHandleEx (&svc_pipe);
 
-  DWORD input_size = wcslen (sud.std_input) * 2;
-  if (input_size)
+  DWORD input_size = WideCharToMultiByte (CP_UTF8, 0, sud.std_input, -1, NULL, 0, NULL, NULL);
+  LPSTR input = NULL;
+  if (input_size && (input = malloc (input_size)))
     {
       DWORD written;
-      LPSTR input = malloc (input_size);
       WideCharToMultiByte (CP_UTF8, 0, sud.std_input, -1, input, input_size, NULL, NULL);
       WriteFile (stdin_write, input, strlen (input), &written, NULL);
       free (input);
     }
 
-
   while (TRUE)
     {
       DWORD bytes = PeekNamedPipeAsync (ovpn_pipe, 1, &exit_event);
-- 
1.7.10.4


