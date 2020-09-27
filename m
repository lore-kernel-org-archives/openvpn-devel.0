From: Vladislav Grishenko <themiron@...2010...>
Date: Mon, 28 Sep 2020 04:32:24 +0500
Message-Id: <20200927233224.2859-1-themiron@...2010...>
In-Reply-To: <20200927231513.27608-1-themiron@...2010...>
References: <20200927231513.27608-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH] Speedup TCP remote hosts connections
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

For non-blocking TCP/Unix connection, OpenVPN checks was it established in
loop and if not - sleeps or handles management for next one second. Since
the first check is made right after the connection attempt, it will likely
be always unsuccessful, resulting in redundant wait for one or more seconds:

    00:00:00.667607 fcntl(5, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
    00:00:00.667713 connect(5, {...}, 16) = -1 EINPROGRESS (Operation now in progress)
    00:00:00.667832 poll([{fd=5, events=POLLOUT}], 1, 0) = 0 (Timeout)
    00:00:00.667954 nanosleep({tv_sec=1, tv_nsec=0}, 0x7fff52450270) = 0
    00:00:01.668608 poll([{fd=5, events=POLLOUT}], 1, 0) = 1 ([{fd=5, revents=POLLOUT}])

With this patch openvpn_connect() will wait for connection establishment for
the first second (if possible) and will return success immediately: this
speedups connection and provides real connection time that can be used for
detection of the fastest remote server in subsequent patches:

    00:00:00.019133 fcntl(5, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
    00:00:00.019265 connect(5, {...}, 16) = -1 EINPROGRESS (Operation now in progress)
    00:00:00.019388 poll([{fd=5, events=POLLOUT}], 1, 1000) = 1 ([{fd=5, revents=POLLOUT}])

If connection still can't established - this should be treated as either too
slow/far or non-responding server, so imprecise connection checks every next
one second in loop will be performed as usual.

v2: cosmetics, decrease connection_timeout to avoid wait more than it in total

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/socket.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 76bdbfc5..049216ff 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1464,13 +1464,27 @@ openvpn_connect(socket_descriptor_t sd,
 #endif
         )
     {
+        /* Non-blocking connection is in the progress and can be likely
+         * established within the first second with no need for imprecise
+         * sleeping in loop.
+         */
+        bool connect_wait = (connect_timeout > 0);
         while (true)
         {
 #if POLL
+            int timeout = 0;
             struct pollfd fds[1];
+
             fds[0].fd = sd;
             fds[0].events = POLLOUT;
-            status = poll(fds, 1, 0);
+            if (connect_wait)
+            {
+                connect_wait = false;
+                connect_timeout--;
+                timeout = 1000;
+            }
+
+            status = poll(fds, 1, timeout);
 #else
             fd_set writes;
             struct timeval tv;
@@ -1479,6 +1493,12 @@ openvpn_connect(socket_descriptor_t sd,
             openvpn_fd_set(sd, &writes);
             tv.tv_sec = 0;
             tv.tv_usec = 0;
+            if (connect_wait)
+            {
+                connect_wait = false;
+                connect_timeout--;
+                tv.tv_sec = 1;
+            }
 
             status = select(sd + 1, NULL, &writes, NULL, &tv);
 #endif
-- 
2.17.1


