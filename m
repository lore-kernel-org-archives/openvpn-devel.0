From: Gert Doering <gert@...1296...>
Date: Wed, 24 Sep 2025 14:18:55 +0200
Message-ID: <20250924121901.13532-1-gert@...1296...>
In-Reply-To: <gerrit.1758637530000.Ic395b6d1dce510bb4b499c5beba61f033a2a860b@...2715...>
References: <gerrit.1758637530000.Ic395b6d1dce510bb4b499c5beba61f033a2a860b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dns: Fix bug in error handling when
 talking to script
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

Comparing the result of read/write to a size_t value
is dangerous C. Since ssize_t and size_t have the same
size ssize_t is promoted to size_t, so -1 becomes
size_t max value and is not smaller than the expected
length.

Make sure to compare ssize_t to ssize_t to avoid any
suprises.

Change-Id: Ic395b6d1dce510bb4b499c5beba61f033a2a860b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Heiko Hund <heiko@...515...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1208
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1208
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@...515...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index efb888a..2a9e60b 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -642,11 +642,10 @@
 
         while (1)
         {
-            ssize_t rlen, wlen;
             char path[PATH_MAX];
 
             /* Block here until parent sends a path */
-            rlen = read(dns_pipe_fd[0], &path, sizeof(path));
+            ssize_t rlen = read(dns_pipe_fd[0], &path, sizeof(path));
             if (rlen < 1)
             {
                 if (rlen == -1 && errno == EINTR)
@@ -665,8 +664,8 @@
             /* Unblock parent process */
             while (1)
             {
-                wlen = write(ack_pipe_fd[1], &res, sizeof(res));
-                if ((wlen == -1 && errno != EINTR) || wlen < sizeof(res))
+                ssize_t wlen = write(ack_pipe_fd[1], &res, sizeof(res));
+                if ((wlen == -1 && errno != EINTR) || wlen < (ssize_t)sizeof(res))
                 {
                     /* Not much we can do about errors but exit */
                     close(dns_pipe_fd[0]);
@@ -727,7 +726,7 @@
         env_set_write_file(dvf, es);
 
         int wfd = updown_runner->fds[1];
-        size_t dvf_size = strlen(dvf) + 1;
+        ssize_t dvf_size = strlen(dvf) + 1;
         while (1)
         {
             ssize_t len = write(wfd, dvf, dvf_size);
@@ -746,7 +745,7 @@
         while (1)
         {
             ssize_t len = read(rfd, &status, sizeof(status));
-            if (len < sizeof(status))
+            if (len < (ssize_t)sizeof(status))
             {
                 if (len == -1 && errno == EINTR)
                 {

