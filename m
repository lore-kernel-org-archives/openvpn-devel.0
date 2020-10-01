From: Vladislav Grishenko <themiron@...2010...>
Date: Fri,  2 Oct 2020 03:53:19 +0500
Message-Id: <20201001225319.25125-1-themiron@...2010...>
In-Reply-To: <20200927233224.2859-1-themiron@...2010...>
References: <20200927233224.2859-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH v3] Speedup TCP remote hosts connections
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
be always unsuccessful, causing redundant wait for one or more seconds:

    00:00:00.667607 fcntl(5, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
    00:00:00.667713 connect(5, {...}, 16) = -1 EINPROGRESS (Operation now in progress)
    00:00:00.667832 poll([{fd=5, events=POLLOUT}], 1, 0) = 0 (Timeout)
    00:00:00.667954 nanosleep({tv_sec=1, tv_nsec=0}, 0x7fff52450270) = 0
    00:00:01.668608 poll([{fd=5, events=POLLOUT}], 1, 0) = 1 ([{fd=5, revents=POLLOUT}])

After this patch openvpn_connect() will perform blocking wait for connection
establishment (if possible) and just check for management events once in one
second (if management enabled) w/o sleep. This speedups TCP/Unix connection
establishment and provides almost real connection time that can be used for
detection of the fastest remote server in subsequent patches:

    00:00:00.790510 fcntl(5, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
    00:00:00.790616 connect(5, {...}, 16) = -1 EINPROGRESS (Operation now in progress)
    00:00:00.790877 poll([{fd=5, events=POLLOUT}], 1, 1000) = 0 (Timeout)
    00:00:01.792880 poll([{fd=5, events=POLLOUT}], 1, 1000) = 1 ([{fd=5, revents=POLLOUT}])

Or, with management interface enabled:

    00:00:00.906421 fcntl(5, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
    00:00:00.906527 connect(6, {...}, 16) = -1 EINPROGRESS (Operation now in progress)
    00:00:00.906779 poll([{fd=6, events=POLLOUT}], 1, 1000) = 0 (Timeout)
    00:00:01.910418 poll([{fd=3, events=POLLIN|POLLPRI}], 1, 0) = 0 (Timeout)
    00:00:01.911365 poll([{fd=6, events=POLLOUT}], 1, 1000) = 0 ([{fd=6, revents=POLLOUT}])

v2: cosmetics, decrease connection_timeout to avoid wait more than it
v3: teach management_sleep() to handle zero timeout and reject negative
    use 1s timeout for connection and 0s timeout for management events

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/manage.c | 30 +++++++++++++++++++++++-------
 src/openvpn/socket.c |  6 +++---
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 898cb3b3..ac142177 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3310,12 +3310,17 @@ man_block(struct management *man, volatile int *signal_received, const time_t ex
 
     if (man_standalone_ok(man))
     {
+        /* expire time can be already overdue, for this case init zero
+         * timeout to avoid waiting first time and exit loop early with
+         * either obtained event or timeout.
+         */
+        tv.tv_usec = 0;
+        tv.tv_sec = 0;
+
         while (true)
         {
             event_reset(man->connection.es);
             management_socket_set(man, man->connection.es, NULL, NULL);
-            tv.tv_usec = 0;
-            tv.tv_sec = 1;
             if (man_check_for_signals(signal_received))
             {
                 status = -1;
@@ -3343,6 +3348,10 @@ man_block(struct management *man, volatile int *signal_received, const time_t ex
                 }
                 break;
             }
+
+            /* wait one second more */
+            tv.tv_sec = 1;
+            tv.tv_usec = 0;
         }
     }
     return status;
@@ -3444,7 +3453,7 @@ management_event_loop_n_seconds(struct management *man, int sec)
 
         /* set expire time */
         update_time();
-        if (sec)
+        if (sec >= 0)
         {
             expire = now + sec;
         }
@@ -3474,7 +3483,7 @@ management_event_loop_n_seconds(struct management *man, int sec)
         /* revert state */
         man->persist.standalone_disabled = standalone_disabled_save;
     }
-    else
+    else if (sec > 0)
     {
         sleep(sec);
     }
@@ -4117,11 +4126,15 @@ log_history_ref(const struct log_history *h, const int index)
 void
 management_sleep(const int n)
 {
-    if (management)
+    if (n < 0)
+    {
+        return;
+    }
+    else if (management)
     {
         management_event_loop_n_seconds(management, n);
     }
-    else
+    else if (n > 0)
     {
         sleep(n);
     }
@@ -4132,7 +4145,10 @@ management_sleep(const int n)
 void
 management_sleep(const int n)
 {
-    sleep(n);
+    if (n > 0)
+    {
+        sleep(n);
+    }
 }
 
 #endif /* ENABLE_MANAGEMENT */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 76bdbfc5..155780e3 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1470,14 +1470,14 @@ openvpn_connect(socket_descriptor_t sd,
             struct pollfd fds[1];
             fds[0].fd = sd;
             fds[0].events = POLLOUT;
-            status = poll(fds, 1, 0);
+            status = poll(fds, 1, (connect_timeout > 0) ? 1000 : 0);
 #else
             fd_set writes;
             struct timeval tv;
 
             FD_ZERO(&writes);
             openvpn_fd_set(sd, &writes);
-            tv.tv_sec = 0;
+            tv.tv_sec = (connect_timeout > 0) ? 1 : 0;
             tv.tv_usec = 0;
 
             status = select(sd + 1, NULL, &writes, NULL, &tv);
@@ -1507,7 +1507,7 @@ openvpn_connect(socket_descriptor_t sd,
 #endif
                     break;
                 }
-                management_sleep(1);
+                management_sleep(0);
                 continue;
             }
 
-- 
2.17.1


