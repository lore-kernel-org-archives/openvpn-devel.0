From: Gert Doering <gert@...1296...>
Date: Mon, 15 Dec 2025 16:56:47 +0100
Message-ID: <20251215155652.23362-1-gert@...1296...>
In-Reply-To: <gerrit.1765813841000.Ie982f620a8af80564a70d993e6e84ec4e525236a@...2715...>
References: <gerrit.1765813841000.Ie982f620a8af80564a70d993e6e84ec4e525236a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] multi: Warn about failing read in
 multi_process_file_closed()
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

Handle failure explicitly instead of the implicit
handling by "while (buffer_i < r)". That error
checking was previously broken but was fixed by
commit 5e5ead5ba019fc2a8266f77a7d840b30fd545198.

Reported-by: Marc Heuse <marc@...2953...>
Github: openvpn-private-issues#101
Change-Id: Ie982f620a8af80564a70d993e6e84ec4e525236a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1443
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1443
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 92eac6f..329d0a3 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2806,6 +2806,11 @@
     char buffer[INOTIFY_EVENT_BUFFER_SIZE];
     ssize_t buffer_i = 0;
     ssize_t r = read(m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);
+    if (r < 0)
+    {
+        msg(M_WARN | M_ERRNO, "MULTI: multi_process_file_closed error");
+        return;
+    }
 
     while (buffer_i < r)
     {

