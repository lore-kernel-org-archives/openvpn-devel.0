From: Gert Doering <gert@...1296...>
Date: Tue, 16 Dec 2025 12:15:39 +0100
Message-ID: <20251216111544.27133-1-gert@...1296...>
In-Reply-To: <gerrit.1765869635000.I950863eeba67b8c006c794245a1a08752cd79fb0@...2715...>
References: <gerrit.1765869635000.I950863eeba67b8c006c794245a1a08752cd79fb0@...2715...>
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
handling by "while (buffer_i < r)".

Backport of 18d1b1fe008a4bbfd5a56ca7bb59f6f8cb58114a and the relevant
type fix of 5e5ead5ba019fc2a8266f77a7d840b30fd545198

Reported-by: Marc Heuse <marc@...2953...>
Github: openvpn-private-issues#101
Change-Id: I950863eeba67b8c006c794245a1a08752cd79fb0
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1444
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1444
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 94e623b..69497a6 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2830,8 +2830,13 @@
 multi_process_file_closed(struct multi_context *m, const unsigned int mpp_flags)
 {
     char buffer[INOTIFY_EVENT_BUFFER_SIZE];
-    size_t buffer_i = 0;
-    int r = read(m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);
+    ssize_t buffer_i = 0;
+    ssize_t r = read(m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);
+    if (r < 0)
+    {
+        msg(M_WARN | M_ERRNO, "MULTI: multi_process_file_closed error");
+        return;
+    }
 
     while (buffer_i < r)
     {

