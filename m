Message-ID: <4CB24484.4050605@...277...>
Date: Mon, 11 Oct 2010 00:56:04 +0200
From: Pierre Bourdon <delroth@...277...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010204060900030205040304"
Subject: [Openvpn-devel] [PATCH] Socks5 username/password authentication
	support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010204060900030205040304
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hello,

This patch adds support for SOCKS plain text (username/password)
authentication as described in RFC 1929. It adds an optional third
parameter to the socks-proxy option, which is a file containing the
login credentials.

I submitted this patch on the Trac (#62) two days ago, but cron2 asked
me to send it here too. It is my first contribution to the OpenVPN
project so this patch will probably need to be reworked a bit :) .

I've been using this patch for two weeks now and it does not seem to
cause any problem. The only modifications are in the SOCKS handshake
handling and the options parser.

Signed-Off-By: Pierre Bourdon <delroth@...277...>
----
diff --git a/init.c b/init.c
index a46fbde..f84fd35 100644
--- a/init.c
+++ b/init.c
@@ -417,6 +417,7 @@ init_proxy_dowork (struct context *c)
       {
         c->c1.socks_proxy =3D socks_proxy_new (c->options.ce.socks_proxy_s=
erver,
                                             c->options.ce.socks_proxy_port,
+                                          c->options.ce.socks_proxy_authfi=
le,
                                             c->options.ce.socks_proxy_retr=
y,
                                             c->options.auto_proxy_info);
         if (c->c1.socks_proxy)
diff --git a/options.c b/options.c
index 5f1efc5..ae4eafb 100644
--- a/options.c
+++ b/options.c
@@ -120,8 +120,11 @@ static const char usage_message[] =3D
     "                  AGENT user-agent\n"
   #endif
   #ifdef ENABLE_SOCKS
-  "--socks-proxy s [p]: Connect to remote host through a Socks5 proxy at a=
ddress\n"
-  "                  s and port p (default port =3D 1080).\n"
+  "--socks-proxy s [p] [up] : Connect to remote host through a Socks5 prox=
y at\n"
+  "                  address s and port p (default port =3D 1080).\n"
+  "                  If proxy authentication is required,\n"
+  "                  up is a file containing username/password on 2 lines,=
 or\n"
+  "                  'stdin' to prompt for console.\n"
     "--socks-proxy-retry : Retry indefinitely on Socks proxy errors.\n"
   #endif
     "--resolv-retry n: If hostname resolve fails for --remote, retry\n"
@@ -4471,6 +4474,7 @@ add_option (struct options *options,
            options->ce.socks_proxy_port =3D 1080;
          }
         options->ce.socks_proxy_server =3D p[1];
+      options->ce.socks_proxy_authfile =3D p[3]; /* might be NULL */
       }
     else if (streq (p[0], "socks-proxy-retry"))
       {
diff --git a/options.h b/options.h
index fc5db58..c1e6d6d 100644
--- a/options.h
+++ b/options.h
@@ -95,6 +95,7 @@ struct connection_entry
   #ifdef ENABLE_SOCKS
     const char *socks_proxy_server;
     int socks_proxy_port;
+  const char *socks_proxy_authfile;
     bool socks_proxy_retry;
   #endif
  =20
diff --git a/socks.c b/socks.c
index 0c1bb3e..7c9edd1 100644
--- a/socks.c
+++ b/socks.c
@@ -23,10 +23,11 @@
    */
  =20
   /*
- * 2004-01-30: Added Socks5 proxy support
+ * 2004-01-30: Added Socks5 proxy support, see RFC 1928
    *   (Christof Meerwald, http://cmeerw.org)
    *
- * see RFC 1928, only supports "no authentication"
+ * 2010-10-10: Added Socks5 plain text authentication support (RFC 1929)
+ *   (Pierre Bourdon <delroth@...277...>)
    */
  =20
   #include "syshead.h"
@@ -38,10 +39,12 @@
   #include "win32.h"
   #include "socket.h"
   #include "fdmisc.h"
+#include "misc.h"
   #include "proxy.h"
  =20
   #include "memdbg.h"
  =20
+#define UP_TYPE_SOCKS          "SOCKS Proxy"
  =20
   void
   socks_adjust_frame_parameters (struct frame *frame, int proto)
@@ -53,6 +56,7 @@ socks_adjust_frame_parameters (struct frame *frame, int p=
roto)
   struct socks_proxy_info *
   socks_proxy_new (const char *server,
                   int port,
+                const char *authfile,
                   bool retry,
                   struct auto_proxy_info *auto_proxy_info)
   {
@@ -77,6 +81,12 @@ socks_proxy_new (const char *server,
  =20
     strncpynt (p->server, server, sizeof (p->server));
     p->port =3D port;
+
+  if (authfile)
+    strncpynt (p->authfile, authfile, sizeof (p->authfile));
+  else
+    p->authfile[0] =3D 0;
+
     p->retry =3D retry;
     p->defined =3D true;
  =20
@@ -90,15 +100,99 @@ socks_proxy_close (struct socks_proxy_info *sp)
   }
  =20
   static bool
-socks_handshake (socket_descriptor_t sd, volatile int *signal_received)
+socks_username_password_auth (struct socks_proxy_info *p,
+                              socket_descriptor_t sd,
+                              volatile int *signal_received)
+{
+  char to_send[516];
+  char buf[2];
+  int len =3D 0;
+  const int timeout_sec =3D 5;
+  struct user_pass creds;
+  ssize_t size;
+
+  creds.defined =3D 0;
+
+  get_user_pass (&creds, p->authfile, UP_TYPE_SOCKS, GET_USER_PASS_MANAGEM=
ENT);
+  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", strlen(creds.userna=
me),
+            creds.username, strlen(creds.password), creds.password);
+  size =3D send (sd, to_send, strlen(to_send), MSG_NOSIGNAL);
+
+  if (size !=3D strlen (to_send))
+    {
+      msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth: TC=
P port write failed on send()");
+      return false;
+    }
+
+  while (len < 2)
+    {
+      int status;
+      ssize_t size;
+      fd_set reads;
+      struct timeval tv;
+      char c;
+
+      FD_ZERO (&reads);
+      FD_SET (sd, &reads);
+      tv.tv_sec =3D timeout_sec;
+      tv.tv_usec =3D 0;
+
+      status =3D select (sd + 1, &reads, NULL, NULL, &tv);
+
+      get_signal (signal_received);
+      if (*signal_received)
+       return false;
+
+      /* timeout? */
+      if (status =3D=3D 0)
+       {
+         msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth:=
 TCP port read timeout expired");
+         return false;
+       }
+
+      /* error */
+      if (status < 0)
+       {
+         msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth:=
 TCP port read failed on select()");
+         return false;
+       }
+
+      /* read single char */
+      size =3D recv(sd, &c, 1, MSG_NOSIGNAL);
+
+      /* error? */
+      if (size !=3D 1)
+       {
+         msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth:=
 TCP port read failed on recv()");
+         return false;
+       }
+
+      /* store char in buffer */
+      buf[len++] =3D c;
+    }
+
+  /* VER =3D 5, SUCCESS =3D 0 --> auth success */
+  if (buf[0] !=3D 5 && buf[1] !=3D 0)
+  {
+    msg (D_LINK_ERRORS, "socks_username_password_auth: server refused the =
authentication");
+    return false;
+  }
+
+  return true;
+}
+
+static bool
+socks_handshake (struct socks_proxy_info *p,
+                 socket_descriptor_t sd,
+                 volatile int *signal_received)
   {
     char buf[2];
     int len =3D 0;
     const int timeout_sec =3D 5;
  =20
-  /* VER =3D 5, NMETHODS =3D 1, METHODS =3D [0] */
-  const ssize_t size =3D send (sd, "\x05\x01\x00", 3, MSG_NOSIGNAL);
-  if (size !=3D 3)
+  /* VER =3D 5, NMETHODS =3D 2, METHODS =3D [0 (no auth), 2 (plain login)]=
 */
+  const ssize_t size =3D send (sd, "\x05\x02\x00\x02", 4, MSG_NOSIGNAL);
+  if (size !=3D 4)
       {
         msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_handshake: TCP port writ=
e failed on send()");
         return false;
@@ -151,13 +245,37 @@ socks_handshake (socket_descriptor_t sd, volatile int=
 *signal_received)
         buf[len++] =3D c;
       }
  =20
-  /* VER =3D=3D 5 && METHOD =3D=3D 0 */
-  if (buf[0] !=3D '\x05' || buf[1] !=3D '\x00')
+  /* VER =3D=3D 5 */
+  if (buf[0] !=3D '\x05')
       {
         msg (D_LINK_ERRORS, "socks_handshake: Socks proxy returned bad sta=
tus");
         return false;
       }
  =20
+  /* select the appropriate authentication method */
+  switch (buf[1])
+    {
+    case 0: /* no authentication */
+      break;
+
+    case 2: /* login/password */
+      if (!p->authfile[0])
+      {
+       msg(D_LINK_ERRORS, "socks_handshake: server asked for username/logi=
n auth but we were "
+                          "not provided any credentials");
+       return false;
+      }
+
+      if (!socks_username_password_auth(p, sd, signal_received))
+       return false;
+
+      break;
+
+    default: /* unknown auth method */
+      msg(D_LINK_ERRORS, "socks_handshake: unknown SOCKS auth method");
+      return false;
+    }
+
     return true;
   }
  =20
@@ -281,7 +399,7 @@ establish_socks_proxy_passthru (struct socks_proxy_info=
 *p,
     char buf[128];
     size_t len;
  =20
-  if (!socks_handshake (sd, signal_received))
+  if (!socks_handshake (p, sd, signal_received))
       goto error;
  =20
     /* format Socks CONNECT message */
@@ -328,7 +446,7 @@ establish_socks_proxy_udpassoc (struct socks_proxy_info=
 *p,
                                  struct openvpn_sockaddr *relay_addr,
                                  volatile int *signal_received)
   {
-  if (!socks_handshake (ctrl_sd, signal_received))
+  if (!socks_handshake (p, ctrl_sd, signal_received))
       goto error;
  =20
     {
diff --git a/socks.h b/socks.h
index 702aa06..b748bb3 100644
--- a/socks.h
+++ b/socks.h
@@ -43,12 +43,14 @@ struct socks_proxy_info {
  =20
     char server[128];
     int port;
+  char authfile[256];
   };
  =20
   void socks_adjust_frame_parameters (struct frame *frame, int proto);
  =20
   struct socks_proxy_info *socks_proxy_new (const char *server,
                                            int port,
+                                         const char *authfile,
                                            bool retry,
                                            struct auto_proxy_info *auto_pr=
oxy_info);


--=20
Pierre "delroth" Bourdon <delroth@...277...>
=C9tudiant =E0 l'EPITA / Student at EPITA
http://bitbucket.org/delroth/


--------------010204060900030205040304
Content-Type: text/plain;
 name="openvpn-socks-auth.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="openvpn-socks-auth.patch"

diff --git a/init.c b/init.c
index a46fbde..f84fd35 100644
--- a/init.c
+++ b/init.c
@@ -417,6 +417,7 @@ init_proxy_dowork (struct context *c)
     {
       c->c1.socks_proxy = socks_proxy_new (c->options.ce.socks_proxy_server,
 					   c->options.ce.socks_proxy_port,
+					   c->options.ce.socks_proxy_authfile,
 					   c->options.ce.socks_proxy_retry,
 					   c->options.auto_proxy_info);
       if (c->c1.socks_proxy)
diff --git a/options.c b/options.c
index 5f1efc5..ae4eafb 100644
--- a/options.c
+++ b/options.c
@@ -120,8 +120,11 @@ static const char usage_message[] =
   "                  AGENT user-agent\n"
 #endif
 #ifdef ENABLE_SOCKS
-  "--socks-proxy s [p]: Connect to remote host through a Socks5 proxy at address\n"
-  "                  s and port p (default port = 1080).\n"
+  "--socks-proxy s [p] [up] : Connect to remote host through a Socks5 proxy at\n"
+  "                  address s and port p (default port = 1080).\n"
+  "                  If proxy authentication is required,\n"
+  "                  up is a file containing username/password on 2 lines, or\n"
+  "                  'stdin' to prompt for console.\n"
   "--socks-proxy-retry : Retry indefinitely on Socks proxy errors.\n"
 #endif
   "--resolv-retry n: If hostname resolve fails for --remote, retry\n"
@@ -4471,6 +4474,7 @@ add_option (struct options *options,
 	  options->ce.socks_proxy_port = 1080;
 	}
       options->ce.socks_proxy_server = p[1];
+      options->ce.socks_proxy_authfile = p[3]; /* might be NULL */
     }
   else if (streq (p[0], "socks-proxy-retry"))
     {
diff --git a/options.h b/options.h
index fc5db58..c1e6d6d 100644
--- a/options.h
+++ b/options.h
@@ -95,6 +95,7 @@ struct connection_entry
 #ifdef ENABLE_SOCKS
   const char *socks_proxy_server;
   int socks_proxy_port;
+  const char *socks_proxy_authfile;
   bool socks_proxy_retry;
 #endif
 
diff --git a/socks.c b/socks.c
index 0c1bb3e..7c9edd1 100644
--- a/socks.c
+++ b/socks.c
@@ -23,10 +23,11 @@
  */
 
 /*
- * 2004-01-30: Added Socks5 proxy support
+ * 2004-01-30: Added Socks5 proxy support, see RFC 1928
  *   (Christof Meerwald, http://cmeerw.org)
  *
- * see RFC 1928, only supports "no authentication"
+ * 2010-10-10: Added Socks5 plain text authentication support (RFC 1929)
+ *   (Pierre Bourdon <delroth@...277...>)
  */
 
 #include "syshead.h"
@@ -38,10 +39,12 @@
 #include "win32.h"
 #include "socket.h"
 #include "fdmisc.h"
+#include "misc.h"
 #include "proxy.h"
 
 #include "memdbg.h"
 
+#define UP_TYPE_SOCKS		"SOCKS Proxy"
 
 void
 socks_adjust_frame_parameters (struct frame *frame, int proto)
@@ -53,6 +56,7 @@ socks_adjust_frame_parameters (struct frame *frame, int proto)
 struct socks_proxy_info *
 socks_proxy_new (const char *server,
 		 int port,
+		 const char *authfile,
 		 bool retry,
 		 struct auto_proxy_info *auto_proxy_info)
 {
@@ -77,6 +81,12 @@ socks_proxy_new (const char *server,
 
   strncpynt (p->server, server, sizeof (p->server));
   p->port = port;
+
+  if (authfile)
+    strncpynt (p->authfile, authfile, sizeof (p->authfile));
+  else
+    p->authfile[0] = 0;
+
   p->retry = retry;
   p->defined = true;
 
@@ -90,15 +100,99 @@ socks_proxy_close (struct socks_proxy_info *sp)
 }
 
 static bool
-socks_handshake (socket_descriptor_t sd, volatile int *signal_received)
+socks_username_password_auth (struct socks_proxy_info *p,
+                              socket_descriptor_t sd,
+                              volatile int *signal_received)
+{
+  char to_send[516];
+  char buf[2];
+  int len = 0;
+  const int timeout_sec = 5;
+  struct user_pass creds;
+  ssize_t size;
+
+  creds.defined = 0;
+
+  get_user_pass (&creds, p->authfile, UP_TYPE_SOCKS, GET_USER_PASS_MANAGEMENT);
+  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", strlen(creds.username),
+            creds.username, strlen(creds.password), creds.password);
+  size = send (sd, to_send, strlen(to_send), MSG_NOSIGNAL);
+
+  if (size != strlen (to_send))
+    {
+      msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth: TCP port write failed on send()");
+      return false;
+    }
+
+  while (len < 2)
+    {
+      int status;
+      ssize_t size;
+      fd_set reads;
+      struct timeval tv;
+      char c;
+
+      FD_ZERO (&reads);
+      FD_SET (sd, &reads);
+      tv.tv_sec = timeout_sec;
+      tv.tv_usec = 0;
+
+      status = select (sd + 1, &reads, NULL, NULL, &tv);
+
+      get_signal (signal_received);
+      if (*signal_received)
+	return false;
+
+      /* timeout? */
+      if (status == 0)
+	{
+	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth: TCP port read timeout expired");
+	  return false;
+	}
+
+      /* error */
+      if (status < 0)
+	{
+	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth: TCP port read failed on select()");
+	  return false;
+	}
+
+      /* read single char */
+      size = recv(sd, &c, 1, MSG_NOSIGNAL);
+
+      /* error? */
+      if (size != 1)
+	{
+	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth: TCP port read failed on recv()");
+	  return false;
+	}
+
+      /* store char in buffer */
+      buf[len++] = c;
+    }
+
+  /* VER = 5, SUCCESS = 0 --> auth success */
+  if (buf[0] != 5 && buf[1] != 0)
+  {
+    msg (D_LINK_ERRORS, "socks_username_password_auth: server refused the authentication");
+    return false;
+  }
+
+  return true;
+}
+
+static bool
+socks_handshake (struct socks_proxy_info *p,
+                 socket_descriptor_t sd,
+                 volatile int *signal_received)
 {
   char buf[2];
   int len = 0;
   const int timeout_sec = 5;
 
-  /* VER = 5, NMETHODS = 1, METHODS = [0] */
-  const ssize_t size = send (sd, "\x05\x01\x00", 3, MSG_NOSIGNAL);
-  if (size != 3)
+  /* VER = 5, NMETHODS = 2, METHODS = [0 (no auth), 2 (plain login)] */
+  const ssize_t size = send (sd, "\x05\x02\x00\x02", 4, MSG_NOSIGNAL);
+  if (size != 4)
     {
       msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_handshake: TCP port write failed on send()");
       return false;
@@ -151,13 +245,37 @@ socks_handshake (socket_descriptor_t sd, volatile int *signal_received)
       buf[len++] = c;
     }
 
-  /* VER == 5 && METHOD == 0 */
-  if (buf[0] != '\x05' || buf[1] != '\x00')
+  /* VER == 5 */
+  if (buf[0] != '\x05')
     {
       msg (D_LINK_ERRORS, "socks_handshake: Socks proxy returned bad status");
       return false;
     }
 
+  /* select the appropriate authentication method */
+  switch (buf[1])
+    {
+    case 0: /* no authentication */
+      break;
+
+    case 2: /* login/password */
+      if (!p->authfile[0])
+      {
+	msg(D_LINK_ERRORS, "socks_handshake: server asked for username/login auth but we were "
+	                   "not provided any credentials");
+	return false;
+      }
+
+      if (!socks_username_password_auth(p, sd, signal_received))
+	return false;
+
+      break;
+
+    default: /* unknown auth method */
+      msg(D_LINK_ERRORS, "socks_handshake: unknown SOCKS auth method");
+      return false;
+    }
+
   return true;
 }
 
@@ -281,7 +399,7 @@ establish_socks_proxy_passthru (struct socks_proxy_info *p,
   char buf[128];
   size_t len;
 
-  if (!socks_handshake (sd, signal_received))
+  if (!socks_handshake (p, sd, signal_received))
     goto error;
 
   /* format Socks CONNECT message */
@@ -328,7 +446,7 @@ establish_socks_proxy_udpassoc (struct socks_proxy_info *p,
 				struct openvpn_sockaddr *relay_addr,
 			        volatile int *signal_received)
 {
-  if (!socks_handshake (ctrl_sd, signal_received))
+  if (!socks_handshake (p, ctrl_sd, signal_received))
     goto error;
 
   {
diff --git a/socks.h b/socks.h
index 702aa06..b748bb3 100644
--- a/socks.h
+++ b/socks.h
@@ -43,12 +43,14 @@ struct socks_proxy_info {
 
   char server[128];
   int port;
+  char authfile[256];
 };
 
 void socks_adjust_frame_parameters (struct frame *frame, int proto);
 
 struct socks_proxy_info *socks_proxy_new (const char *server,
 					  int port,
+					  const char *authfile,
 					  bool retry,
 					  struct auto_proxy_info *auto_proxy_info);
 


--------------010204060900030205040304--

