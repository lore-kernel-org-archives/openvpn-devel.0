From: Gert Doering <gert@...1296...>
Date: Sat, 22 Nov 2025 16:55:00 +0100
Message-ID: <20251122155506.8901-1-gert@...1296...>
In-Reply-To: <gerrit.1763661267000.I4c3e5aed23d2e4c543066bb8032ad8808dcd27a8@...2715...>
References: <gerrit.1763661267000.I4c3e5aed23d2e4c543066bb8032ad8808dcd27a8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] iservice: fix buffer size in call to
 FormatMessage
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

From: Heiko Hund <heiko@...2662...>

The buffer size is to be given in # of TCHARs according to the docs. In
this case that is the number of WCHARs in the buffer.

While here, remove the unused FORMAT_MESSAGE_ARGUMENT_ARRAY flag. Just
to make things a bit shorter.

Reported-by: stephan@...2953...
Change-Id: I4c3e5aed23d2e4c543066bb8032ad8808dcd27a8
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1387
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1387
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 33282c63..f64c247 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -734,9 +734,8 @@
 
     err_str = L"Unknown Win32 Error";
 
-    if (FormatMessage(FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_FROM_SYSTEM
-                          | FORMAT_MESSAGE_ARGUMENT_ARRAY,
-                      NULL, err, 0, buf, sizeof(buf), NULL))
+    if (FormatMessageW(FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_FROM_SYSTEM,
+                       NULL, err, 0, buf, _countof(buf), NULL))
     {
         err_str = buf;
     }

