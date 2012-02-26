Message-ID: <4F4A70B6.6070309@...1667...>
Date: Sun, 26 Feb 2012 09:49:42 -0800
From: mark <mnunberg@...1667...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Allow management socket over inherited file
	descriptor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

 From e15b874fdd05e9952e94e36292b57071e96127ed Mon Sep 17 00:00:00 2001
From: Mark Nunberg <mnunberg@...1667...>
Date: Sun, 26 Feb 2012 09:37:33 -0800
Subject: [PATCH] Allow management socket over inherited file descriptor

Allows a direct management channel over a forked-and-execed openvpn
process (or possibly other means) instead of having to use a bound TCP
or UNIX socket. Helpful for wrapper applications and advanced scripts,
so that they leave less clutter in the local connection table and/or
filesystem
---
  manage.c  |   22 ++++++++++++++++++++--
  manage.h  |    1 +
  options.c |    9 ++++++++-
  3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/manage.c b/manage.c
index ce6fae7..f597ed9 100644
--- a/manage.c
+++ b/manage.c
@@ -1587,7 +1587,7 @@ man_listen (struct management *man)
      }
        else
  #endif
-    {
+    {
        man->connection.sd_top = create_socket_tcp ();
        socket_bind (man->connection.sd_top, &man->settings.local, 
"MANAGEMENT");
      }
@@ -1612,9 +1612,11 @@ man_listen (struct management *man)
      }
        else
  #endif
+    {
      msg (D_MANAGEMENT, "MANAGEMENT: TCP Socket listening on %s",
           print_sockaddr (&man->settings.local, &gc));
      }
+   }

  #ifdef WIN32
    man_start_ne32 (man);
@@ -1623,6 +1625,16 @@ man_listen (struct management *man)
    gc_free (&gc);
  }

+static void man_connect_from_sockfd(struct management *man)
+{
+    /*We have a socket already opened for us. Simple enough*/
+    man->connection.sd_top = SOCKET_UNDEFINED;
+    man->connection.state  = MS_INITIAL;
+    man->connection.sd_cli = man->settings.local.addr.in4.sin_port;
+    man_record_peer_info(man);
+    man_new_connection_post(man, "Connected from sockfd");
+}
+
  static void
  man_connect (struct management *man)
  {
@@ -2029,6 +2041,10 @@ man_settings_init (struct man_settings *ms,
      sockaddr_unix_init (&ms->local_unix, addr);
        else
  #endif
+   if(ms->flags & MF_SOCKFD) {
+       ms->local.addr.in4.sin_port = atoi(addr);
+    }
+    else
      {
        /*
         * Initialize socket address
@@ -2111,7 +2127,9 @@ man_connection_init (struct management *man)
        /*
         * Listen/connect socket
         */
-      if (man->settings.flags & MF_CONNECT_AS_CLIENT)
+      if(man->settings.flags & MF_SOCKFD)
+    man_connect_from_sockfd(man);
+      else if (man->settings.flags & MF_CONNECT_AS_CLIENT)
      man_connect (man);
        else
      man_listen (man);
diff --git a/manage.h b/manage.h
index f681f8d..ab939ff 100644
--- a/manage.h
+++ b/manage.h
@@ -339,6 +339,7 @@ struct management *management_init (void);
  #if MANAGEMENT_QUERY_REMOTE
  #define MF_QUERY_REMOTE     (1<<11)
  #endif
+#define MF_SOCKFD           (1<<12)

  bool management_open (struct management *man,
                const char *addr,
diff --git a/options.c b/options.c
index 736495e..07a2972 100644
--- a/options.c
+++ b/options.c
@@ -371,6 +371,10 @@ static const char usage_message[] =
    "                  To listen on a unix domain socket, specific the 
pathname\n"
    "                  in place of ip and use 'unix' as the port number.\n"
  #endif
+  "                  To specify a numeric file descriptor of a connected\n"
+  "                  socket (in the case of openvpn running as a forked 
process)\n"
+  "                  specify the file descriptor number as the 
pathname, and \n"
+  "                  'sockfd' as the port number\n"
    "--management-client : Management interface will connect as a TCP 
client to\n"
    "                      ip/port rather than listen as a TCP server.\n"
    "--management-query-passwords : Query management channel for private 
key\n"
@@ -4076,7 +4080,10 @@ add_option (struct options *options,
        msg (msglevel, "MANAGEMENT: this platform does not support unix 
domain sockets");
        goto err;
  #endif
-    }
+    } else if(streq(p[2], "sockfd")) {
+      options->management_flags |= MF_SOCKFD;
+      /*Check to see if socket address is too big..*/
+    }
        else
      {
        port = atoi (p[2]);
-- 
1.7.2.5


