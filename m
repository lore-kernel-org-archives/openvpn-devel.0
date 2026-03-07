From: Gert Doering <gert@...1296...>
Date: Sat,  7 Mar 2026 10:16:44 +0100
Message-ID: <20260307091654.21823-1-gert@...1296...>
In-Reply-To: <gerrit.1769789455000.Ia57fa6d2469be08343c0457dd0213f062bc4cfa5@...2715...>
References: <gerrit.1769789455000.Ia57fa6d2469be08343c0457dd0213f062bc4cfa5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] openvpnmscia: Improve check of vsnprintf
 return value
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

From: Frank Lichtenheld <frank@...2641...>

Avoid sign-compare warning and do not ignore error
return values.

Change-Id: Ia57fa6d2469be08343c0457dd0213f062bc4cfa5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1504
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1504
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 2bb0e1b..85ebda9 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -98,11 +98,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 void
 x_msg_va(const unsigned int flags, const char *format, va_list arglist)
 {
@@ -124,7 +119,7 @@
         /* Field 2: The message string. */
         char szBufStack[128];
         int iResultLen = vsnprintf(szBufStack, _countof(szBufStack), format, arglist);
-        if (iResultLen < _countof(szBufStack))
+        if (iResultLen > 0 && (unsigned int)iResultLen < _countof(szBufStack))
         {
             /* Use from stack. */
             MsiRecordSetStringA(hRecordProg, 2, szBufStack);
@@ -194,7 +189,3 @@
                       hRecordProg);
     MsiCloseHandle(hRecordProg);
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

