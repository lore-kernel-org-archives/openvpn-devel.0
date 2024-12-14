Message-ID: <dcc7e538-2035-4697-b306-10eb470632f3@...68...>
Date: Sat, 14 Dec 2024 20:56:56 +0100
MIME-Version: 1.0
Content-Language: de-CH
From: corubba <corubba@...68...>
Subject: [Openvpn-devel] [PATCH] Support IPv6 towards port-share proxy
 receiver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

While port-share already supports IPv6 connections from clients, it only
supported IPv4 connections towards the proxy receiver. The used
common/shared OpenVPN machinery is already IPv6-ready, so all needed was
to use properly-sized `sockaddr` structs and removing hardcoded IPv4
restrictions.

Signed-off-by: corubba <corubba@...68...>
---
 src/openvpn/ps.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 06bf91a8..d12ac9e6 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -414,7 +414,7 @@ proxy_connection_io_requeue(struct proxy_connection *pc=
, const int rwflags_new,
 static bool
 proxy_entry_new(struct proxy_connection **list,
                 struct event_set *es,
-                const struct sockaddr_in server_addr,
+                const struct openvpn_sockaddr server_addr,
                 const socket_descriptor_t sd_client,
                 struct buffer *initial_data,
                 const char *journal_dir)
@@ -425,12 +425,12 @@ proxy_entry_new(struct proxy_connection **list,
     struct proxy_connection *cp;

     /* connect to port share server */
-    if ((sd_server =3D socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
+    if ((sd_server =3D socket(server_addr.addr.sa.sa_family, SOCK_STREAM, =
IPPROTO_TCP)) < 0)
     {
         msg(M_WARN|M_ERRNO, "PORT SHARE PROXY: cannot create socket");
         return false;
     }
-    status =3D openvpn_connect(sd_server, (const struct sockaddr *)  &serv=
er_addr, 5, NULL);
+    status =3D openvpn_connect(sd_server, &server_addr.addr.sa, 5, NULL);
     if (status)
     {
         msg(M_WARN, "PORT SHARE PROXY: connect to port-share server failed=
");
@@ -492,7 +492,7 @@ static bool
 control_message_from_parent(const socket_descriptor_t sd_control,
                             struct proxy_connection **list,
                             struct event_set *es,
-                            const struct sockaddr_in server_addr,
+                            const struct openvpn_sockaddr server_addr,
                             const int max_initial_buf,
                             const char *journal_dir)
 {
@@ -740,7 +740,7 @@ bad:
  * This is the main function for the port share proxy background process.
  */
 static void
-port_share_proxy(const struct sockaddr_in hostaddr,
+port_share_proxy(const struct openvpn_sockaddr hostaddr,
                  const socket_descriptor_t sd_control,
                  const int max_initial_buf,
                  const char *journal_dir)
@@ -822,7 +822,7 @@ port_share_open(const char *host,
 {
     pid_t pid;
     socket_descriptor_t fd[2];
-    struct sockaddr_in hostaddr;
+    struct openvpn_sockaddr hostaddr;
     struct port_share *ps;
     int status;
     struct addrinfo *ai;
@@ -836,11 +836,20 @@ port_share_open(const char *host,
      */

     status =3D openvpn_getaddrinfo(GETADDR_RESOLVE|GETADDR_FATAL,
-                                 host, port,  0, NULL, AF_INET, &ai);
+                                 host, port,  0, NULL, AF_UNSPEC, &ai);
     ASSERT(status=3D=3D0);
-    hostaddr =3D *((struct sockaddr_in *) ai->ai_addr);
+    ASSERT(sizeof(hostaddr.addr) >=3D ai->ai_addrlen);
+    memcpy(&hostaddr.addr.sa, ai->ai_addr, ai->ai_addrlen);
     freeaddrinfo(ai);

+    if (msg_test(D_PS_PROXY_DEBUG))
+    {
+        struct gc_arena gc =3D gc_new();
+        dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: receiver will be %s",
+             print_openvpn_sockaddr(&hostaddr, &gc));
+        gc_free(&gc);
+    }
+
     /*
      * Make a socket for foreground and background processes
      * to communicate.
--
2.47.1

