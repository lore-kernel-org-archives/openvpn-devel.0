From: Gert Doering <gert@...1296...>
Date: Mon, 19 Jan 2026 18:12:11 +0100
Message-ID: <20260119171216.6100-1-gert@...1296...>
In-Reply-To: <gerrit.1768318939000.I5eac1b31ae40eb957e2c12ca6c37b491fef32847@...2715...>
References: <gerrit.1768318939000.I5eac1b31ae40eb957e2c12ca6c37b491fef32847@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] port-share: Check return value of fork()
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

While here, do some small C11 code cleanup.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)
Github: openvpn-private-issues#12
Change-Id: I5eac1b31ae40eb957e2c12ca6c37b491fef32847
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1470
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1470
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index ed2d5c9f..e4c5794 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -800,12 +800,9 @@
 port_share_open(const char *host, const char *port, const int max_initial_buf,
                 const char *journal_dir)
 {
-    pid_t pid;
     socket_descriptor_t fd[2];
     struct openvpn_sockaddr hostaddr;
     struct port_share *ps;
-    int status;
-    struct addrinfo *ai;
 
     ALLOC_OBJ_CLEAR(ps, struct port_share);
     ps->foreground_fd = -1;
@@ -814,9 +811,9 @@
     /*
      * Get host's IP address
      */
-
-    status =
-        openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port, 0, NULL, AF_UNSPEC, &ai);
+    struct addrinfo *ai;
+    int status = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port,
+                                     0, NULL, AF_UNSPEC, &ai);
     ASSERT(status == 0);
     ASSERT(sizeof(hostaddr.addr) >= ai->ai_addrlen);
     memcpy(&hostaddr.addr.sa, ai->ai_addr, ai->ai_addrlen);
@@ -836,19 +833,22 @@
      */
     if (socketpair(PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
     {
-        msg(M_WARN, "PORT SHARE: socketpair call failed");
+        msg(M_WARN | M_ERRNO, "PORT SHARE: socketpair call failed");
         goto error;
     }
 
     /*
      * Fork off background proxy process.
      */
-    pid = fork();
+    pid_t pid = fork();
 
-    if (pid)
+    if (pid < 0)
     {
-        int status;
-
+        msg(M_WARN | M_ERRNO, "PORT SHARE: fork failed");
+        goto error;
+    }
+    else if (pid)
+    {
         /*
          * Foreground Process
          */
@@ -862,7 +862,7 @@
         set_cloexec(fd[0]);
 
         /* wait for background child process to initialize */
-        status = recv_control(fd[0]);
+        int status = recv_control(fd[0]);
         if (status == RESPONSE_INIT_SUCCEEDED)
         {
             /* note that this will cause possible EAGAIN when writing to

